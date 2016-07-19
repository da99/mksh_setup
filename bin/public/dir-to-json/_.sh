
# === {{CMD}}
# === {{CMD}}  "/path/to/directory"
# === Outputs JSON to STDOUT.
dir-to-json () {
  local DIR="$@"
  if [[ -z "$DIR" ]]; then
    DIR="$PWD"
  fi
  DIR="$(readlink -m "$DIR")"


  cd $THIS_DIR
  node  bin/lib/dir-to-json.js  "$DIR"
} # === end function



