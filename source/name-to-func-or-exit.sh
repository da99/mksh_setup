

name-to-func-or-exit () {
  local +x NAME="$1"; shift
  local +x APP_DIR="$THIS_DIR"

  source "$APP_DIR/../mksh_setup/source/name-to-func.sh"
  name-to-func "$NAME" "$@"

  # === It's an error:
  mksh_setup RED "!!! Unknown action: {{$NAME}}"
  exit 1
} # === name-to-func-or-exit
