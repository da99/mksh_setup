
# === {{CMD}}
# === {{CMD}}  "/path/to/directory"
# === Outputs JSON to STDOUT.
dir-to-json () {
  local DIR="$@"
  if [[ -z "$DIR" ]]; then
    DIR="$PWD"
  fi
  DIR="$(realpath -m "$DIR")"


  cd $THIS_DIR
  node  bin/lib/dir-to-json.js  "$DIR"
} # === end function

specs () {
  local TMP="/tmp/bash_setup/dir-to-json"
  reset-fs () {
    rm -rf "$TMP"
    mkdir -p "$TMP"
    cd $TMP
  }

  # =================================================================================================
  reset-fs
  echo "ted" > NAME
  echo "General Creative" > CORP
  should-match '{"CORP":"General Creative","NAME":"ted"}'  "bash_setup dir-to-json"
  # =================================================================================================

  # =================================================================================================
  reset-fs
  echo "ted" > NAME
  echo "General Creative" > CORP
  cd /tmp
  should-match '{"CORP":"General Creative","NAME":"ted"}'  "bash_setup dir-to-json  $TMP"
  # =================================================================================================
} # === specs




