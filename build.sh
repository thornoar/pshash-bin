#!/usr/bin/env bash

ver="$1"
file="pshash-static.$ver.x86_64-linux"

cp -r /home/ramak/projects/pshash ./temp || exit
( cd temp || exit; git checkout "v$ver")

echo "> Building the static executable"
nix build ./temp#pshash-static --log-format internal-json |& nom --json || exit
notify-send "built version $ver of pshash"

echo "> Moving"
cp ./result/bin/pshash "./$file"
chmod +wx "./$file"

echo "> Shrinking"
upx -9 --ultra-brute --best "./$file"

echo "> Done."

rm -rf ./temp
