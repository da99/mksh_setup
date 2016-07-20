
# === {{CMD}} APP_DIR  NAME  arg1 arg2 ...
# === Runs file in:
# ===   public/NAME/_.sh,
# ===   or progs/NAME/bin/NAME
# ===   or progs/bin/NAME
# === Exits 1 if file not found.
name-to-func () {
  local +x APP_DIR="$1"; shift
  local +x NAME="$1"; shift
  local +x LIB_FILE=""

  if [[ "$NAME" == '--help' || "$NAME" == '-h' ]]; then
    NAME="help"
  fi

  run-file () {
    local +x LIB_FILE="$1"; shift

    if [[ -f "$LIB_FILE" ]]; then
      source "$LIB_FILE"
      "$NAME" "$@"
      exit 0
    fi
  }

  run-file "$APP_DIR/bin/public/${NAME}/_.sh"  "$@"
  run-file "$APP_DIR/progs/$NAME/bin/$NAME"  "$@"
  run-file "$APP_DIR/progs/bin/$NAME"  "$@"
  run-file "$APP_DIR/bin/public/${NAME}.sh"    "$@"
  run-file "$APP_DIR/bin/lib/${NAME}.sh"       "$@"

  # === It's an error:
  mksh_setup RED "!!! Unknown action: {{$NAME}}"
  exit 1
} # === name-to-func


