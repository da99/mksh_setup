#!/usr/bin/env mksh
#
# === {{CMD}}
#
set -u -e -o pipefail

local +x ACTION=$1; shift

case "$1" in

  *)
    echo "!!! Invalid option: $@" >&2
    exit
    ;;

esac

