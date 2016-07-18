
name-to-prog-bin () {
  local +x NAME="$1"; shift
  local +x APP_DIR="$THIS_DIR"

  local +x BIN_FILE="$APP_DIR/progs/bin/${NAME}"
  if [[ -f "$LIB_FILE" ]]; then
    "$BIN_FILE" "$@"
    exit 0
  fi

} # === name-to-prog-bin
