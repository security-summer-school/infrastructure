#!/bin/sh

# Print every command and bail on error
set -xe

# Make it possible to login as root from the vbox GUI
chpasswd <<< "root:toor"

# grub pops an annoying TUI checkbox to ask on which drive to install it to. No
# attempt to silence it worked (e.g. https://askubuntu.com/questions/146921) so
# it had to go.
apt remove -y grub-*

# By default, Kali kept "python" to point to python2; also displays an annoying
# messages about this on login.
apt remove -y python-is-python2
apt install -y python-is-python3

"/vagrant/update.sh"

git clone "https://github.com/hexcellents/sss-exploit" "$HOME/sss-exploit"
git clone "https://github.com/hexcellents/sss-web" "$HOME/sss-web"

find "/vagrant/install-scripts/" -type f -exec sh -xe "{}" \;
