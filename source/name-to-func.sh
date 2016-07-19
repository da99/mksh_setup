

name-to-func () {
  local +x NAME="$1"; shift
  local +x APP_DIR="$THIS_DIR"
  local +x LIB_FILE=""

  LIB_FILE="$APP_DIR/bin/public/${NAME}.sh"
  if [[ -f "$LIB_FILE" ]]; then
    source "$LIB_FILE"
    "$NAME" "$@"
    exit 0
  fi

  LIB_FILE="$APP_DIR/bin/public/${NAME}/_.sh"
  if [[ -f "$LIB_FILE" ]]; then
    source "$LIB_FILE"
    "$NAME" "$@"
    exit 0
  fi

  LIB_FILE="$APP_DIR/bin/lib/${NAME}.sh"
  if [[ -f "$LIB_FILE" ]]; then
    source "$LIB_FILE"
    "$NAME" "$@"
    exit 0
  fi
exit 0
} # === name-to-func
