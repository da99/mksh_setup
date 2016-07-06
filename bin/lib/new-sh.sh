
# === {{CMD}}  path/to/file
# === Adds ".sh" to file.
new-sh () {
  local FILE="${1}.sh"; shift
  local TEMPLATE="$THIS_DIR/templates/sh.sh"

  if [[ -s "$FILE" ]]; then
    bash_setup RED "=== File already {{exists}}: $FILE"
    exit 1
  fi

  cp -i "$TEMPLATE" "$FILE"
  chmod +x "$FILE"

  bash_setup GREEN "=== Created: {{${FILE}}}"
} # === end function