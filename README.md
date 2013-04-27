# OpenELEC (Qt development)

This fork contains additional projects and packages to make OpenELEC a multi-purpose
linux distribution for application development using Qt5.

The goal is to create a minimal linux distribution ready for cross development using Qt5.
For that, some additional packages will be available:

- QT5 including the following modules
   - qtjsbackend
   - qtimageformats
   - qtsvg
   - qtscript
   - qtxmlpatterns
   - qtdeclarative
   - qtgraphicaleffects
   - qtquick
   - qtmultimedia

- GStreamer-1.0.5
   - gst-plugins-base-1.0.5
   - gst-plugins-good-1.0.5
   - gst-plugins-bad-1.0.5
   - gst-omx (latest repository clone (master branch))

**Important Notes**

It is in a quite early state, so don't expect anything to work out of the box, yet. By the time writing this, gstreamer is not working, and so is qtmultimedia.

**Ubuntu Notes**
When building the first time, besides the required packages installed during build, you probably also need libexpat-dev and perl XML::Parser.

Just install that with

sudo apt-get install libexpat-dev
cpan -i XML::Parser

**QT Creator Notes**

Install Qt Creator and setup the ARM toolchain by adding a new gcc compiler (in build.xxx/toolchain/bin) and the qt5 (qmake in build.xxx/toolchain/arm-xxx/usr/bin). You also have to setup your Raspberry Pi as a generic linux device. Then you're ready to compile your projects and run them remotely on your Raspberry Pi.

**Installation**

Just build one of the projects (currently qt5 will only build for RPi). But don't forget to add textmode to you cmdline.txt. Otherwise boot will fail with a kernel panic, due to missing init scripts.

**ToDo**

- Correct some path issues with Qt5 (examples will fail to run if you don't set QT_PLUGIN_PATH=/usr/plugins, QML_IMPORT_PATH=/usr/imports; currently set by profile.d/qt5.conf)
- Get audio playback working (qmlvideo will fail to choose the correct audiosink; dont know wether one of them works, yet.)
- Clean up and tidy messy scripts

**License**

* OpenELEC is released under [GPLv2](http://www.gnu.org/licenses/gpl-2.0.html). Please refer to the "licenses" folder and 
  source code for clarification on upstream licensing.

**Copyright**

* Since OpenELEC includes code from many up stream projects it includes many 
  copyright owners. OpenELEC makes NO claim of copyright on any upstream code. 
  However all OpenELEC authored code is copyright openelec.tv.
  For a complete copyright list checkout the source code to examine the headers.
  Unless expressly stated otherwise all code submitted DIRECTLY to the OpenELEC 
  project (in any form) is licensed under [GPLv2](http://www.gnu.org/licenses/gpl-2.0.html) and the Copyright is donated to 
  openelec.tv.
  This allows the project to stay manageable in the long term by giving us the
  freedom to maintain the code as part of the whole without the management 
  overhead of preserving contact with every submitter ever e.g. move to GPLv3.
  You are absolutely free to retain copyright. To retain copyright simply add a 
  copyright header to every submitted code page.
  If you are submitting code that is not your own work it is the submitters 
  responsibility to place a header stating the copyright. 

**Notes**

* SSH login details are user: “root” password: “openelec”.
  SSH allows command line access to your openelec.tv machine for configuration
  and file transfer. Linux/Mac clients can natively use SSH, while Windows
  users might want to try PuTTY for their terminal access.
  Starting with OpenELEC 2.0, SSH is disabled by default but all that is needed
  is an empty “ssh_enable” file to exist in /storage/.config to enable it.
* $HOME is mounted on /storage (the second ext4 partition on the drive). 
  All data transfered to the machine will go here, the rest of the system is
  read-only with the exception of /var (containing runtime configuration data).
* Manual update/downgrade procedure is as follows:
  Extract the snapshot and navigate to the 'target' directory.
  Copy KERNEL and SYSTEM to the 'Update' network share (or /storage/.update) on
  your openelec machine. Your system will automatically upgrade during the 
  next reboot.
* Automatic mounting of filesystems is supported. Devices such as USB Flash 
  sticks can be plugged into a running machine and will be mounted to /media,
  showing up in xbmc’s GUI.
* Comments and questions are more than welcome, help is even better and patches 
  are absolutely perfect!!

**Questions/Support**

* Forums on [http://openelec.tv](http://openelec.tv)
* IRC chatroom **#openelec** on Freenode

**Happy OpenELEC'ing**
