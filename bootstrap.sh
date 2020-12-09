#!/bin/sh

# Print every command and bail on error
set -xe

# grub pops an annoying TUI checkbox to ask on which drive to install it to. No
# attempt to silence it worked (e.g. https://askubuntu.com/questions/146921) so
# it had to go.
apt remove -y grub-*

# By default, Kali kept "python" to point to python2; also displays an annoying
# messages about this on login.
apt remove -y python-is-python2
apt install -y python-is-python3

"/vagrant/update.sh"

find "/vagrant/install-scripts/" -type f -exec {} \;
