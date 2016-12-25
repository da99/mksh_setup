#!/usr/bin/env bash
# === {{CMD}}
# === Install mksh binary
install () {
  local +x ORIGIN="$PWD"

  mkdir -p "tmp"
  cd "tmp"

  if [[ -d "mksh" ]]; then
    cd mksh
    git pull
  else
    git clone https://github.com/MirBSD/mksh
    cd mksh
  fi

  unset -f install
  set "-x"
  sh ./Build.sh -r -c lto

  mkdir -p "$ORIGIN"/progs/mksh/bin/
  install -c -s mksh "$ORIGIN"/progs/mksh/bin/
} # === end function

if [[ "$0" == *"install/_.sh" ]]; then
  install
fi
