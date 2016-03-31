
# === {{CMD}}  name
# === Creates bin/lib/name.sh
new-func () {
  local name="$1"; shift
  local FILE="bin/lib/${name}.sh"
  local TEMPLATE="$THIS_DIR/templates/${name}.sh"

  mkdir -p bin/lib
  if [[ -s "$FILE" ]]; then
    bash_setup RED "=== File already {{exists}}: $FILE"
    exit 1
  fi

  if [[ -s "$TEMPLATE" ]]; then
    cp -i "$TEMPLATE" "$FILE"
  else
    echo "" >> "$FILE"
    echo "# === {{CMD}}  ..." >> "$FILE"
    echo "${name} () {" >> "$FILE"
    echo "} # === end function" >> "$FILE"
  fi

  bash_setup GREEN "=== Created: {{${FILE}}}"
}
