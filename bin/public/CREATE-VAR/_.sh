
# === {{CMD}}  DIR  name
# === {{CMD}}  DIR  name   val
# === Create DIR first.
CREATE-VAR () {
  local +x DIR="$1"; shift
  local +x DIR_NAME="$(basename "$DIR")"
  local +x NAME="$1";     shift
  local +x VAL="$@";
  local +x FILE="$DIR/$NAME"

  if [[ -z "$VAL" ]]; then
    mksh_setup RED "!!! Empty value for {{$NAME}}"
    exit 1
  fi

  if [[ -e "$FILE" ]]; then
    mksh_setup RED "=== Already {{exists}}: BOLD{{$FILE}} with content {{$(cat "$FILE")}}"
    exit 1
  fi

  if [[ ! -d "$DIR" ]]; then
    mksh_setup RED "=== Create directory {{$DIR}} first. This helps to ensure you did not misspell the name of the directory."
    exit 1
  fi

  echo "$VAL" > "$FILE"
  mksh_setup GREEN "=== Created: {{$FILE}}"
} # === end function


specs () {
  local +x TMP="/tmp/mksh_setup_specs/vars"

  reset-fs () {
    cd /tmp
    rm -rf "$TMP"
    mkdir -p "$TMP/config/DEV"
    mkdir -p "$TMP/config/PROD"
    cd "$TMP"
  }

  # ===============================================================
  reset-fs
  should-create-file-with-content "config/DEV/port" "4567" "mksh_setup CREATE-VAR config/DEV port 4567"
  # ===============================================================

  # ===============================================================
  reset-fs
  should-create-file-with-content "config/PROD/port" "4567" "mksh_setup CREATE-VAR config/PROD port 4567"
  # ===============================================================

  # ===============================================================
  reset-fs
  should-exit 1 "mksh_setup CREATE-VAR config/stag port 4567"
  # ===============================================================

  # ===============================================================
  reset-fs
  mkdir -p $TMP/config/stag
  should-create-file-with-content  "config/stag/port" "4567" "mksh_setup CREATE-VAR config/stag port 4567"
  # ===============================================================

} # === function specs




