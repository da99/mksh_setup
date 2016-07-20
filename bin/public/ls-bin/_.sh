
# === {{CMD}}
# === {{CMD}} DIR
# === Prints all the NAME/bin/NAME under DIR (Default: $PWD).
ls-bin () {
  cd "$PWD"
  if [[ ! -z "$@" ]]; then
    cd "$1"; shift
  fi

  local +x DIR="$PWD"
  local +x IFS=$'\n'
  for DIR in $(mksh_setup ls-dirs "$DIR"); do
    local +x NAME="$(basename "$DIR" )"
    local +x BIN="$DIR/bin/$NAME"
    if [[ ! -f "$BIN" ]]; then
      continue
    fi
    echo "$BIN"
  done
} # === end function
