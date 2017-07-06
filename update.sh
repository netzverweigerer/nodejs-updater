#!/usr/bin/env bash
# 
# Semi-automative nodejs-updater script
# Obtains a fresh copy of the latest NodeJS tar/gz release
# and extracts it to ./release/ - nothing more, nothing less.
# 
# GitHub: @netzverweigerer
# 

if [[ -f latest.tgz ]]; then
  echo "latest.tgz already present in current directory ($(pwd))"
  echo -n "Obtain a fresh release tar/gz file? (y/N) "
  read -n 1 yesno
  case "$yesno" in
    y|Y)
      download=1
    ;;
    *)
      download=0
    ;;
  esac
else
  download=1
fi

if [[ "$download" -gt 0 ]]; then
  rm -rfv latest.tgz release/
  filename="$(curl -s "https://nodejs.org/dist/latest/" | grep linux-x86.tar.gz | grep href | head -n 1 | cut -d'"' -f 2)"
  wget -O latest.tgz "https://nodejs.org/dist/latest/${filename}"
  mkdir release
  tar xzvf latest.tgz -C release --strip-components 1
else
  echo
  echo "Exiting."
fi

echo
echo "Full path to npm: $(readlink -f ./release/bin/npm)"
echo "Full path to node: $(readlink -f ./release/bin/node)"
echo
echo "NOTE: You might want to add these two to your \$PATH"
echo





