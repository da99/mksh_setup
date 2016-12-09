
# === {{CMD}}  DIR  name
# === {{CMD}}  DIR  name   val
# === Create DIR first.
CREATE-VAR () {
  local +x DIR="$1"; shift
  local +x DIR_NAME="$(basename "$DIR")"
  local +x NAME="$1";     shift
  local +x VAL="$@";
  local +x FILE="$DIR/$NAME"

  if [[ -z "$VAL" ]]; then
    sh_color RED "!!! Empty value for {{$NAME}}"
    exit 1
  fi

  if [[ -e "$FILE" ]]; then
    sh_color RED "=== Already {{exists}}: BOLD{{$FILE}} with content {{$(cat "$FILE")}}"
    exit 1
  fi

  if [[ ! -d "$DIR" ]]; then
    sh_color RED "=== Create directory {{$DIR}} first. This helps to ensure you did not misspell the name of the directory."
    exit 1
  fi

  echo "$VAL" > "$FILE"
  sh_color GREEN "=== Created: {{$FILE}}"
} # === end function




