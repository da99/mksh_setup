
# === {{CMD}} bin   path/to/file
# === {{CMD}} func  path/to/file
# === {{CMD}} sh    path/to/file
# === {{CMD}} sh/sh path/to/file
# === {{CMD}} watch path/to/file
# === {{CMD}} spec  path/to/file
create () {
  local +x FIRST="$1"; shift
  local +x SECOND=""
  if [[ ! -z "$@" ]]; then
    local +x SECOND="$1"; shift
  fi

  case "$FIRST" in
    func)
      if test -d sh ; then
        create-file "sh.sh" sh/"$SECOND"/_
      else
        create-file "func" "bin/public/$SECOND/_.sh"
      fi
      ;;

    awk|py|sh)
      create-file "$FIRST" "$SECOND"
      ;;

    "sh/sh")
      create-file "sh.sh" sh/"$SECOND"/_
      ;;

    bin)
      if [[ -z "$SECOND" ]]; then
        local +x NAME="$(basename "$(realpath "$PWD")")"
      else
        local +x NAME="$SECOND"
      fi

      create-file "bin" bin/"$NAME"
      ;;

    watch)
      create-file "watch" sh/watch/_
      ;;

    spec)
      local +x NAME="$SECOND"
      if [[ -d bin/public/$NAME ]]; then
        local +x FILE="bin/public/$NAME/specs"
      else
        local +x FILE="sh/$NAME/specs"
      fi
      create-file "spec" "$FILE"
      ;;

    *)
      sh_color RED "!!! Unknown options: {{$FIRST $SECOND}}"
      exit 2
      ;;
  esac
} # === end function

create-file () {
  local +x TEMPLATE="$THIS_DIR/templates/$1"; shift
  local +x THE_FILE="$1"; shift
  local +x THE_DIR="$(dirname "$(realpath --canonicalize-missing "$THE_FILE")")"

  if [[ ! -e "$TEMPLATE" ]]; then
    sh_color RED "!!! === Template {{does not}} exist: $TEMPLATE"
    exit 2
  fi

  if [[ -e "$THE_FILE" ]]; then
    sh_color RED "!!! {{Already exists}}: BOLD{{$THE_FILE}}"
    exit 2
  fi

  mkdir -p "$THE_DIR"
  CMD="{{CMD}}" NAME="$(basename "$THE_FILE")" mksh_setup template-render "$TEMPLATE" >> "$THE_FILE"
  chmod +x "$THE_FILE"
  sh_color GREEN "=== Wrote: {{${THE_FILE}}}"
}
