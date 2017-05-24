
# === {{CMD}}  NAME
new-script () {
  local +x NAME="$1"; shift
  local +x NEW_FILE="scripts/$NAME"

  local TEMPLATE="$THIS_DIR/templates/script.sh"

  if [[ -s "$NEW_FILE" ]]; then
    sh_color RED "=== File already {{exists}}: $NEW_FILE"
    exit 1
  fi

  mkdir -p "$(dirname "$NEW_FILE")"
  cp -i "$TEMPLATE" "$NEW_FILE"
  chmod +x "$NEW_FILE"

  sh_color GREEN "=== Created: {{${NEW_FILE}}}"
} # === end function
