
# === {{CMD}}           "ext" DIR
# === {{CMD}}  --quiet  "ext" DIR
remove-files () {
  local +x IS_LOUD="yes"
  if [[ "$1" == "--quiet" ]]; then
    IS_LOUD=""
    shift
  fi

  local +x EXT="$1"; shift
  local +x DIR="$1"; shift
  local +x FILES="$(find "$DIR" -mindepth 1 -maxdepth 1 -type f -iname "$EXT")"

  if [[ ! -d "$DIR" ]]; then
    mksh_setup RED "!!! Not a directory: $DIR"
    exit 1
  fi

  if [[ -z "$FILES" ]]; then
    if [[ "$IS_LOUD" == "yes" ]]; then
      echo "=== No files of: $EXT"
    fi
    return 0
  fi

  if [[ "$IS_LOUD" == "yes" ]]; then
    set -x
  fi

  echo "$FILES" | xargs -I FILE rm FILE
} # === end function
