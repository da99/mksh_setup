
# === {{CMD}}  name
# === {{CMD}}  folder-name/name
# === Creates bin/folder-name/name/_.sh.
# === Default: bin/public/name/_.sh
new-func () {
  local +x FOLDER="$(dirname "$1")"
  local +x NAME="$(basename "$1")"
  shift

  if [[ "$FOLDER" == "$NAME" || "$FOLDER" == "." ]]; then
    local +x FOLDER="public"
  fi

  local +x FILE="bin/$FOLDER/$NAME/_.sh"

  mkdir -p "bin/$FOLDER/$NAME"

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
