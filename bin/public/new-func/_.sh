
# === {{CMD}}  name
# === Creates: bin/public/name/_.sh.
new-func () {
  if [[ -z "$@" ]]; then
    echo -n "Enter name of new function: "
    read -r NAME
  else
    local +x NAME="$1"
    shift
  fi

  local +x FILE="bin/public/$NAME/_.sh"

  mkdir -p "bin/public/$NAME"

  local TEMPLATE="$THIS_DIR/templates/${NAME}.sh"

  if [[ -s "$FILE" ]]; then
    sh_color RED "=== File already {{exists}}: $FILE"
    exit 1
  fi

  if [[ -s "$TEMPLATE" ]]; then
    cp -i "$TEMPLATE" "$FILE"
  else
    echo "" >> "$FILE"
    echo "# === {{CMD}}  ..." >> "$FILE"
    echo "${NAME} () {" >> "$FILE"
    echo "} # === end function" >> "$FILE"
  fi

  sh_color GREEN "=== Created: {{${FILE}}}"
}
