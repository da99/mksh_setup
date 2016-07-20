
# === {{CMD}} APP_DIR  NAME  arg1 arg2 ...
# === Runs file in:
# ===   public/NAME/_.sh,
# ===   or progs/NAME/bin/NAME
# ===   or progs/bin/NAME
# === Exits 1 if file not found.
name-to-func () {
  local +x APP_DIR="$1"; shift
  if [[ -f "$APP_DIR" ]]; then
    APP_DIR="$( dirname "$(dirname "$(readlink -m "$APP_DIR")")" )"
  fi

  local +x NAME="$1"; shift
  if [[ "$NAME" == '--help' || "$NAME" == '-h' ]]; then
    NAME="help"
  fi

  run-file () {
    local +x LIB_FILE="$1"; shift


    if [[ -f "$LIB_FILE" ]]; then

      export THIS_DIR="$APP_DIR"

      if [[ "$LIB_FILE" == *progs/bin/* ]]; then
        export PATH="$THIS_DIR/progs/bin:$PATH"
        "$THIS_DIR"/progs/bin/"$NAME" "$@"
      else
        source "$LIB_FILE"
        "$NAME" "$@"
        LAST_EXIT="$?"
        exit "$LAST_EXIT"
      fi

      exit 0
    fi
  }

  run-file "$APP_DIR/bin/public/${NAME}/_.sh"  "$@"
  run-file "$APP_DIR/progs/$NAME/bin/$NAME"  "$@"
  run-file "$APP_DIR/progs/bin/$NAME"  "$@"
  run-file "$APP_DIR/bin/public/${NAME}.sh"    "$@"
  run-file "$APP_DIR/bin/lib/${NAME}.sh"       "$@"

  if [[ "$NAME" == 'help' ]]; then
    mksh_setup print-help $0
    exit 0
  fi

  # === It's an error:
  if [[ -z "$NAME" ]]; then
    NAME='[NULL]'
  fi

  mksh_setup RED "!!! Unknown action: {{$NAME}}"
  exit 1
} # === name-to-func


