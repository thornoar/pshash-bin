#!/usr/bin/env bash

ver="$1"
file="pshash-static.$ver.x86_64-linux"

curdir="$(pwd)"
cd /home/ramak/projects/pshash || exit
git checkout "v$ver"
cd "$curdir" || exit

echo "> Building the static executable"
nix build ../pshash#pshash-static --log-format internal-json |& nom --json || exit
notify-send "built version $ver of pshash"

echo "> Moving"
cp ./result/bin/pshash "./$file"
chmod +wx "./$file"

echo "> Shrinking"
upx -9 --ultra-brute --best "./$file"

echo "> Done."
