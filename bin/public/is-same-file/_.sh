
# === {{CMD}}  file.ext
# === Mainly used in inotifywait loops to prevent
# === programs that close_write files multiple times
# === (e.g. Geany IDE).
is-same-file () {
  export TEMP_DIR="/tmp/is_same_file"
  mkdir -p "$TEMP_DIR"

  # === is_same_file  path/to/file
  # === Used to see if file has changed.
  # === This was created when Neovim was issue-ing a "CLOSE_WRITE,CLOSE"
  # === event on opening a file.
  local +x file="$1"; shift

  local +x temp_file="$TEMP_DIR/${file//\//_}"
  touch "$temp_file"
  if diff "$file" "$temp_file" >/dev/null; then
    exit 0
  fi
  cp "$file" "$temp_file"
  exit 1
} # === end function
