+++
title = "The Death Throes of a Seagate SMR Hard Drive"
date = 2019-03-16T10:21:31-04:00
description = "It's never a good sign when ZFS starts giving you **uncorrectable I/O failure** errors."
draft = false
toc = false
categories = []
tags = []
images = []
+++

It's never a good sign when ZFS starts giving you **uncorrectable I/O failure** errors.

```bash
kernel: WARNING: Pool 'parity0' has encountered an uncorrectable I/O failure and has been suspended.
kernel: WARNING: Pool 'parity0' has encountered an uncorrectable I/O failure and has been suspended.
kernel: WARNING: Pool 'parity0' has encountered an uncorrectable I/O failure and has been suspended.
kernel: WARNING: Pool 'parity0' has encountered an uncorrectable I/O failure and has been suspended.
kernel: scsi_io_completion_action: 16 callbacks suppressed
kernel: sd 3:0:0:0: [sdc] tag#24 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
kernel: sd 3:0:0:0: [sdc] tag#24 CDB: ATA command pass through(16) 85 06 20 00 00 00 00 00 00 00 00 00 00 0
0 e5 00
rem kernel: sd 3:0:0:0: [sdc] tag#26 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
kernel: sd 3:0:0:0: [sdc] tag#26 CDB: ATA command pass through(16) 85 06 20 00 00 00 00 00 00 00 00 00 00 0
0 e5 00
```

Currently, it seems like the drive is fine until you actually try to write to it, at which point ZFS locks up and dmesg starts spewing `DID_BAD_TARGET` errors, which are apparently the mark of a failing disk. I'm leaving it alone for now, in hopes that its internal firmware can quietly do some recovery (re-shingling?).

Don't worry, though - this is part of a redundant LizardFS pool, so no data has been lost. Yet.

It seems that this error [might also just show up sometimes](https://unix.stackexchange.com/questions/395668/problem-with-a-new-hard-drive-it-stops-working-periodically) with SMR disks? Which is slightly reassuring, but not really since I never got these issues in over a year of usage so far.

## Update (2019-03-16)

Seems we're good. After letting it sit for an hour or two, I re-imported the ZFS pool and started the LizardFS chunkserver. No errors yet.