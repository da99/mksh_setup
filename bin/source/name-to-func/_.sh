
# === source {{SOURCE_PATH}}
# === {{FUNC_NAME}} NAME  arg1 arg2 ...
# ===
# === Runs file in:
# ===   public/NAME/_.sh,
# ===
# === Exits 1 if file not found.
# ===
# === If NAME == "help" "-h" "--help",
# ===  documentation is printed.
# ===
name-to-func () {

  export THIS_DIR="$( dirname "$(dirname "$(realpath "$0")")" )"
  export THIS_FUNC="$1"; shift
  export MKSH_DIR="$THIS_DIR/../mksh_setup"

  if [[ "$THIS_FUNC" == '--help' || "$THIS_FUNC" == '-h' ]]; then
    THIS_FUNC="help"
  fi

  export THIS_FILE="$THIS_DIR/bin/public/${THIS_FUNC}/_.sh"
  export THIS_FUNC_DIR="$THIS_DIR/bin/public/${THIS_FUNC}"
  if [[ -f  "$THIS_FILE"  ]]; then
    source "$THIS_FILE"
    "$THIS_FUNC" "$@"
    return 0
  fi

  if [[ "$THIS_FUNC" == 'help' ]]; then
    source "$THIS_DIR/../mksh_setup/bin/public/print-help/_.sh"
    print-help "$0" "$@"
    return 0
  fi

  # === It's an error:
  if [[ -z "$THIS_FUNC" ]]; then
    THIS_FUNC='[NULL]'
  fi

  mksh_setup RED "!!! Unknown action: {{$THIS_FUNC}}"
  exit 1
} # === name-to-func


