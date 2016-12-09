
# === {{CMD}}  DIR
# === Changes bin/lib/ layout to func/ layout.
lib-to-public () {
  local +x DIR="$1"; shift
  local +x BIN_LIB="$DIR/bin/lib"
  local +x BIN_PUBLIC="$DIR/bin/public"

  echo ""
  sh_color BOLD "=== in {{$DIR}}"

  local +x IFS=$'\n'


  # === mv bin/lib file into bin/public/NAME/_.sh
  if [[ -d "$BIN_LIB" ]]; then
    for FILE in $(find -L "$BIN_LIB" -mindepth 1 -maxdepth 1 -type f -name "*.sh") ; do
      local +x FILENAME="$(basename "$FILE" ".sh")"
      local +x NEW_DIR="$DIR/bin/public/$FILENAME"
      local +x NEW_FILENAME="$NEW_DIR/_.sh"

      echo "=== lib $FILE"
      mkdir -p "$NEW_DIR"
      mv -iv "$FILE" "$NEW_FILENAME"
    done # === for each FILE
  else
    sh_color ORANGE "=== No {{bin/lib}} dir found."
  fi

  # === mv bin/public/NAME.sh to bin/public/NAME/_.sh
  if [[ -d "$BIN_PUBLIC" ]]; then
    for FILE in $(find -L "$BIN_PUBLIC" -mindepth 1 -maxdepth 1 -type f -name "*.sh"); do
      local +x FILENAME="$(basename "$FILE" ".sh")"
      local +x NEW_DIR="$DIR/bin/public/$FILENAME"
      local +x NEW_FILENAME="$NEW_DIR/_.sh"

      echo "=== public $FILE"
      mkdir -p "$NEW_DIR"
      mv -iv "$FILE" "$NEW_FILENAME"
    done # === for each FILE
  else
    sh_color ORANGE "=== No {{bin/public}} dir found."
  fi

  # === Trash empty bin/lib
  if [[ -d "$BIN_LIB" && -z "$(ls -A "$BIN_LIB")" ]]; then
    sh_color BOLD "=== Trashing {{$BIN_LIB}}"
    trash-put "$BIN_LIB"
  fi

  # === Trash empty bin/public
  if [[ -d "$BIN_PUBLIC" && -z "$(ls -A "$BIN_PUBLIC")" ]]; then
    sh_color BOLD "=== Trashing {{$BIN_PUBLIC}}"
    trash-put "$BIN_PUBLIC"
  fi

  if [[ -d "$BIN_PUBLIC" ]]; then
    for FILE in $(ag "^specs\ +\(\)" "$BIN_PUBLIC/" -G "_\.sh" -l); do
      local +x SPEC_FILE="$(dirname "$FILE")/specs.sh"
      nvim -O "$FILE" "$SPEC_FILE"
    done
  fi

} # === end function


