#!/bin/sh

apt install -y libssl-dev libffi-dev build-essential
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade pwntools

# If we ever need support for foreign architectures, all we need to do is:
# (per https://docs.pwntools.com/en/stable/install/binutils.html)
#apt install -y software-properties-common
#apt-add-repository -y ppa:pwntools/binutils
#apt update

# Then repeat the following for each ARCH we want
#apt install -y binutils-$ARCH-linux-gnu
