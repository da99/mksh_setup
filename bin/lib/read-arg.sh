
# === {{CMD}}  -arg  vals  -arg  val ...
read-arg () {
  local +x NAME="$1"; shift
  local +x VAL=""
  local +x FOUND=""

  while [[ ! -z "$@" ]]; do
    if [[ "$1" != "$NAME" ]]; then
      shift
      continue
    fi

    shift

    VAL="$1"; shift
    FOUND="yes"
    break
  done

  if [[ -z "$FOUND" ]]; then
    mksh_setup RED "!!! Arg not found: \"$NAME\"  from:  $THE_ARGS"
    exit 1
  fi

  echo "$VAL"
} # === end function

specs () {
  should-match-stdout "yoyo" "mksh_setup read-arg --message  --message yoyo"
  should-match-stdout "yoyo" "mksh_setup read-arg --message  -other -arg random --message yoyo random"
  should-exit         1      "mksh_setup read-arg --body     -no -body or anything else"
} # === specs ()
