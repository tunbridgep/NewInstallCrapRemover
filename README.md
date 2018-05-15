# New Install Crap Remover
A relatively straightforward set of batch files designed to remove the unnecessary garbage from new Windows installations, as well as install some core software.

This is largely untested, use at your own risk!

A brief description of each file is as follows:

- **new_pc_installation.bat** - This is the main file. This turns off a lot of unnecessary Windows features.
- **software_installation.bat** - This installs chocolatey, and installs a bunch of software. It is advisable to modify the installed softwares list as there may be unwanted items in the list
- **always_on.bat** - This installs a special power profile which prevents sleep, disables the power buttons, and effectively makes the PC never turn off automatically.
