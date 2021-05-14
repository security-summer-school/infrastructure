#!/bin/bash

apt install -y default-jdk
cd "$HOME"

# I don't know how to get "the latest version"; or if that is something we want
URL='https://ghidra-sre.org/ghidra_9.2_PUBLIC_20201113.zip'

curl -LO "$URL"
unzip -o -u "$(basename "$URL")"
