
# === {{CMD}}  "DIR" "name" "val"
# === {{CMD}}  "DIR" "name"       # Opens editor to enter file.

UPDATE-OR-CREATE-VAR () {
  local DIR="$1"; shift
  local DIR_NAME="$(basename "$DIR")"
  local NAME="$1"; shift
  local FILE="$DIR/$NAME"
  local VAL="$@"

  if [[ ! -d "$DIR" ]]; then
    sh_color RED "=== Directory {{does not exist}}: BOLD{{$DIR}}"
    exit 1
  fi

  touch "$FILE"

  if [[ -z "$VAL" ]]; then
    $EDITOR "$FILE"
  else
    echo "$VAL" > "$FILE"
  fi

} # === end function




