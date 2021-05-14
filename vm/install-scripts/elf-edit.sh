#!/bin/sh

apt install -y rustc cargo
git clone https://github.com/TheThirdOne/elf-edit/ "$HOME/elf-edit"
cd "$HOME/elf-edit"
cargo install --path .
