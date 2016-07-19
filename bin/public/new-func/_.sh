
# === {{CMD}}  name
# === {{CMD}}  folder/name
# === Creates bin/public/name/_.sh.
# === If folder is specified, than it must be relative to bin/public or to an existing folder.
new-func () {
  local folder="$(dirname "$1")"
  local name="$(basename "$1")"
  shift

  if [[ "$folder" == "$name" ]]; then
    local FILE="bin/public/${name}/_.sh"
  else
    if [[ -d "bin/public/$folder" ]]; then
      local FILE="bin/public/$folder/${name}.sh"
    else
      if [[ -d "$folder" ]]; then
        local FILE="$folder/${name}.sh"
      else
        mksh_setup RED "=== Dir {{does not exist}}: BOLD{{$folder}}"
        exit 1
      fi
    fi
  fi

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
