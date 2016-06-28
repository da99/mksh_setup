
# === {{CMD}}  "DIR" "name" "val"
# === {{CMD}}  "DIR" "name"       # Opens editor to enter file.

UPDATE-OR-CREATE-VAR () {
  local DIR="$1"; shift
  local DIR_NAME="$(basename "$DIR")"
  local NAME="$1"; shift
  local FILE="$DIR/$NAME"
  local VAL="$@"

  if [[ ! -d "$DIR" ]]; then
    mksh_setup RED "=== Directory {{does not exist}}: BOLD{{$DIR}}"
    exit 1
  fi

  touch "$FILE"

  if [[ -z "$VAL" ]]; then
    $EDITOR "$FILE"
  else
    echo "$VAL" > "$FILE"
  fi

} # === end function

specs () {
  local TMP="/tmp/mksh_setup_specs/vars"

  reset-fs () {
    rm -rf "$TMP"
    mkdir -p $TMP/config/DEV
    cd $TMP
  }

  # ===============================================================
  reset-fs
  echo -n "=== Create var: "
  should-create-file-with-content "config/DEV/port" 4567 'mksh_setup UPDATE-OR-CREATE-VAR config/DEV port 4567'
  # ===============================================================

  # ===============================================================
  reset-fs
  mksh_setup CREATE-VAR config/DEV port 9000 >/dev/null
  echo -n "=== Updates var: "
  should-create-file-with-content "config/DEV/port" 8000 'mksh_setup UPDATE-OR-CREATE-VAR config/DEV port 8000'
  # ===============================================================

} # specs()



