
# === {{CMD}}  "$(env)"   "cmd -with -args"
in-env () {
  local ORIGINAL="$1"; shift
  local CMD="$@"

  for LINE in $(echo "$ORIGINAL"); do
    export $LINE
  done
  eval "$CMD"
} # === end function
