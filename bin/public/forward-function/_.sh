
# === {{CMD}}  "function name" "
forward-function () {

  local +x NAME="$1" ; shift

  for REPO in $(echo sh_string sh_color mksh_setup bash_setup) ; do
    local +x FILE="$THIS_DIR/../$REPO/bin/public/$NAME/_.sh"
    if [[ -f "$FILE" ]]; then
      "$THIS_DIR"/../"$REPO"/bin/"$REPO" "$NAME" "$@"
      return $?
    fi
  done

  echo "!!! Action not found: \"$NAME\", Arguments: $@" >&2
  exit 1
} # === end function
