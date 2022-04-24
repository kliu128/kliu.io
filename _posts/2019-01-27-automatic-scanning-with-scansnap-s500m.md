---
layout: post
comments: true
title: "Fully Automatic Scanning with the Scansnap S500M on Linux"
date: 2019-01-27T09:00:44-05:00
description: "One-button scanning to PDF from a $50 scanner on eBay"
tags: "tech"
---

I have a _massive_ pile of schoolwork in paper form. (Mostly from History class, of course.) And when the accordian folder I used to use for storage filled up, I was left with two options:

1. Buy a filing cabinet.
2. Buy a scanner. (Sheet-fed, of course. There's no way I'd spend hours scanning paper on a flatbed scanner.)

Enter the Fujitsu ScanSnap S500M. Released in 2007 (its [minimum system requirements](http://www.fujitsu.com/us/products/computing/peripheral/scanners/product/eol/s500m/) recommend the PowerPC G4), it is so outdated that not one, but _two_ models have been released to succeed it: the S1500M and the iX500.

There are some benefits, however: it's ridiculously cheap on eBay, and, despite its age, it still scans 600 dpi in color. Just really slowly. Naturally, I bought one.

Now, since the scanner is white, Fujitsu only ever released Mac drivers for it. (The ScanSnap S500 is its black, Windows counterpart.) But thanks to the tireless work of unpaid Linux enthusiasts, it is [fully supported](http://www.sane-project.org/sane-mfgs.html#Z-FUJITSU) by SANE, Linux's scanner access library. Thus, after plugging it in, I could use _already_ use it seamlessly with applications like [Simple Scan](https://gitlab.gnome.org/GNOME/simple-scan).

However, "12-year-old hardware works perfectly on Linux" probably wouldn't be that newsworthy. (Or would it?) As useful as Simple Scan is, I wanted a more convenient solution that didn't involved starting up a program on my desktop and manually clicking Scan -> Scan All From Feeder. Ideally, I would be able to just click the Scan button and have it automatically scan all pages to a timestamped, black-and-white PDF.

Here's how I got there.

## Scanner Button Daemon

One of the lesser-known daemons on Linux is the [Scanner Button Daemon](https://wiki.archlinux.org/index.php/Scanner_Button_Daemon), or `scanbd`. `scanbd` quietly runs in the background, polling for scanner button presses and running commands on specific presses. Thankfully, it supports the S500M. You can start it by running `scanbd --config=<config>.conf`, which I wrapped in a simple systemd service. Then, I edited the stock configuration file's `action scan` to look like this:

```
action scan {
        filter = "^scan.*"
        numerical-trigger {
                from-value = 1
                to-value   = 0
        }
        desc   = "Scan to file"
        # script must be an relative path starting from scriptdir (see above),
        # or an absolute pathname.
        # It must contain the path to the action script without arguments
        # Absolute path example: script = "/some/path/foo.script
        script = "/etc/scan.sh"
}
```

Note the line `script = "/etc/scan.sh"`. This means that `scanbd` will execute `/etc/scan.sh` when you press the scan button. Thus, by making `/etc/scan.sh` an automated scanner script, I could automate a scan.

Here's what it looks like.

```bash
#!/bin/sh
export PATH=${lib.makeBinPath [ pkgs.coreutils pkgs.sane-backends pkgs.imagemagickpkgs.ghostscript ]}
set -x
date="$(date --iso-8601=seconds)"
filename="Scan $date.pdf"
exec 3>&1 1>>"/srv/paperless-incoming/$filename.log" 2>&1
tmpdir="$(mktemp -d)"
pushd "$tmpdir"
scanimage --batch=out%d.jpg --format=jpeg --mode Gray -d "fujitsu:ScanSnap S500M:4530"--source "ADF Duplex" --resolution 300

for i in out*.jpg; do convert $i ''${i//jpg/pdf}; done
gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE="/srv/paperless-incoming/$filename" -dBATCH`ls -v out*.pdf`
chown -R kevin:users /srv/paperless-incoming
popd
rm -r "$tmpdir"
```

Lines of note:

1. `export PATH=...`: You can mostly ignore this; this is for NixOS to declare the script's dependencies.
2. `filename="Scan $date.pdf"`: Sets the scan filename to `Scan <date>.pdf`.
3. `exec 3>&1 1>>"/srv/paperless-incoming/$filename.log" 2>&1`: Redirect all script output to a log file. This is useful because scanbd doesn't really log what happens in the script.
4. `scanimage --batch=out%d.jpg --format=jpeg --mode Gray -d "fujitsu:ScanSnap S500M:4530"--source "ADF Duplex" --resolution 300`: Scan from the S500M's _duplex_ source, at 300 dpi, saving as JPEGs named out1.jpg, out2.jpg, etc. The `--source` option tripped me up initially, because the default is only to scan the front side.
5. `for i in out*.jpg; do convert $i ''${i//jpg/pdf}; done`: Convert each JPEG to a PDF. I didn't convert them all at once (i.e. `convert *.jpg out.pdf`) because ImageMagick _really_ enjoys using up memory.
6. `gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE="/srv/paperless-incoming/$filename" -dBATCH $(ls -v out*.pdf)`: This uses ghostscript to concatenate the PDFs and place the final product in `/srv/paperless-incoming`. It uses `ls -v` so that e.g. `out2.pdf` comes _before_ `out11.pdf`.

And voila. Combined with software like [Paperless](https://github.com/danielquinn/paperless) for auto-OCRing, you basically have a fully-automated scan processing center!
