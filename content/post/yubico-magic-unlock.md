+++
title = "Using a Yubikey as a touchless, magic unlock key for Linux"
date = 2020-08-16T11:29:28-04:00
description = "Yubikeys are great for security, but not when you leave them in your computer unattended. I also have login passwords that are way too long. How to solve these problems? Use a Yubikey to unlock your computer!"
draft = false
toc = false
categories = []
tags = []
images = []
+++

Yubikeys are great for security, but not when you leave them in your computer unattended. At that point, anyone can take the key and use it for 2-factor authentication/SSH/GPG signing, so it's not much better than just using a normal password. I unfortunately have a habit of forgetting my key when I walk away from the computer. I also have login passwords that are way too long and easy to typo.

[hacker news edit & a slight correction to my previous paragraph: using a Yubikey to store SSH/GPG keys _is_ actually better than just storing it locally, because you have to enter a PIN and you can lock out the user after a certain number of invalid entries. If you use it for 2FA, it does obviously become useless if your attacker has it, but hopefully you still have a secure password.]

Thankfully, there's a way to solve both of these problems: use a Yubikey to unlock your computer when you put it in and lock your computer when you remove it!

## Prior art

The first example I remember seeing of this concept years ago was [Predator](https://www.predator-usb.com/predator/en/index.php), Windows software (with a delightfully retro website) that locks your computer when you remove a special USB drive. Similar examples for Linux include [pamusb](https://wiki.debian.org/pamusb), which allows you to login using Linux's PAM by inserting a specially-formatted USB stick.

Of course, nowadays most people use Yubikeys to accomplish this, and Yubico has [convenient guides](https://developers.yubico.com/yubico-pam/Authentication_Using_Challenge-Response.html) on how to accomplish this very task. However, I wanted to make it _touchless_ -- that is, I wanted to be able to plug in my Yubikey and instantly unlock my laptop, without clicking through logins or touching the Yubikey button. Upon removal, I wanted to instantly lock my computer.

## Making it contactless[^1]

There are some guides on how to do this online (unlock when you plug in, lock when you remove), but unfortunately most of them fall prey to the problem described in [this article](https://medium.com/@d0znpp/how-to-sacrifice-security-using-a-public-yubikey-linux-guides-c823c4c6e2). A lot of them use udev to detect when the Yubikey is plugged in, but they don't actually authenticate the key beyond checking its vendor ID, model ID, and sometimes serial number, which all can [easily be faked](https://forums.anandtech.com/threads/changing-creating-a-custom-serial-id-on-a-flash-drive-low-level-blocks.2099116/).

To provide actual security, most official guides use either `pam_u2f` (which authenticates a Yubikey through the [U2F protocol](https://en.wikipedia.org/wiki/Universal_2nd_Factor)) or `pam_yubico` (which uses either online validation through YubiCloud or offline validation through a challenge-response protocol). The U2F method requires a tap on the Yubikey, while the challenge-response process can be done without user interaction, so I went with the latter. I set up traditional Yubikey authentication using [this great guide from System76](https://support.system76.com/articles/yubikey-login/).

However, I still needed some way to test the challenge-response for success when I plugged in the key. Usually, `pam_yubico` is run when you login or unlock your computer (i.e. when pressing the enter key on the lockscreen). But I didn't want _any_ clicks, so I needed a way to run it without interaction.

Enter `udev` (again) and `pamtester`!

Here's the udev rules I included:

```
kevin@you:~ » cat /etc/udev/rules.d/yubikey.rules
ACTION=="remove", ENV{DEVTYPE}=="usb_device", ENV{PRODUCT}=="1050/407*", RUN+="/usr/local/sbin/ykunlock.sh lock"
ACTION=="add", ENV{DEVTYPE}=="usb_device", ENV{ID_BUS}=="usb", ENV{PRODUCT}=="1050/407*", RUN+="/usr/local/sbin/ykunlock.sh unlock"
```

These rules effectively call a script when inserting and removing the key, so I can trigger any action from the script. Note that the script **should not immediately unlock the computer**, to avoid the security issues mentioned earlier.

To actually test the challenge-response from the Yubikey on inserting, I decided to use [pamtester](http://pamtester.sourceforge.net/), a simple utility that pretends to trigger a PAM authentication from the command line. Since `pam_yubico` is installed, this will naturally test the challenge-response if a Yubikey is plugged in.

Here's the final script:

```bash
#!/bin/bash
exec 1> >(logger -s -t "$(basename "$0")") 2>&1
echo "RUN"
if [ "$1" = "lock" ]; then
        pkill -USR1 swayidle
else
        # unlock
        if echo "" | pamtester login kevin authenticate; then
                # PAM login successful
                # kill locker
                kill -KILL $(pgrep swaylock)
                ps aux | grep swaylock
                # turn on displays
                SWAYSOCK=$(ls /run/user/1000/sway-ipc.*.sock) swaymsg "output * dpms on"
        fi
fi
exit 0
```

- On lock, it immediately locks my desktop (by sending a SIGUSR1 to swayidle, the program that manages locking on the Sway window manager)
- On unlock, it first sees if it can authenticate using pamtester without interaction (when no Yubikey is inserted or if the key is invalid, pamtester asks for a password). If it can, it kills the lockscreen and turns on all displays using Sway WM protocols.

The final result is amazingly convenient, and has successfully made me remember to pull out my Yubikey when leaving my computer unattended more than once[^2]! Mission success.

[^1]: You might call it Yubikey: Coronavirus Edition.
[^2]: Yes, yes, I know there's not too much of a danger because we're all stuck at home right now. But who knows -- maybe this will be helpful when we _eventually_ get back on campus.