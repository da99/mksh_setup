
source "$THIS_DIR/bin/public/COLORIZE/_.sh"

# === {{CMD}} dir/path
# ===   Prints all *.sh files in dir
# === {{CMD}} path/to/file
# ===   If file is in a dir called "bin/", and file is alongside
# ===   another directory "lib",
# ===   then all the files in lib/ are also printed.
print-help () {

  local +x TARGET="$1"; shift
  local +x DIR="$(dirname "$(realpath "$TARGET")")"
  local +x DIRNAME="$(basename "$DIR")"
  local +x LIB="$DIR/lib"

  if [[ -d "$TARGET" ]]; then
    print-dir "$TARGET"
    return 0
  fi

  set -x
  exit 0

  if [[ "$DIRNAME" == "bin" && -d "$LIB" ]]; then
    print-file "$TARGET"
    print-dir "$LIB"
    return 0
  fi

  if [[ -s "$TARGET" ]]; then
    print-file "$TARGET"
    return 0
  fi

  mksh_setup RED "=== Help not available for: "$TARGET""
  exit 1

} # === end function


print-dir () {
  local +x DIR="$1"; shift
  local +x IFS=$'\n'
  for FILE in $(find "$DIR/" -mindepth 1 -maxdepth 1 -type f -name "*.sh" -print); do
    print-file "$FILE"
  done
} # === print-dir

print-file () {
  # === Accepts one arguments: one file.

  local +x Color_Off='\e[0m'
  local +x Bold="$(tput bold)"
  local +x Reset='\e[0m'
  local +x BRed='\e[1;31m'
  local +x Red='\e[0;31m'
  local +x Green='\e[0;32m'
  local +x BGreen='\e[1;32m'
  local +x Orange='\e[0;33m'
  local +x BOrange='\e[1;33m'

  # === === Extract switch options from file
  # ===      that are followed by: # ===
  # === $ mksh_setup print-help path/to/file

  local +x FILE="$1"; shift
  local +x cmd_print=""
  local +x cmd=""
  local +x nl_printed=""
  local +x BIN_NAME="$(basename "$FILE")"
  local +x IFS=$'\n'

  for line in $(cat $FILE); do
    if echo "$line" | grep -P '^[\*\ +0-9A-Za-z\_\-\"'"\']+\)"'$' >/dev/null; then
      cmd=$(echo $line | tr -d '"'')')
      cmd_print=""
    else
      if test -n "$cmd" && echo "$line" | grep  "# ===" >/dev/null; then
        if [[ -z $cmd_print ]]; then
          echo $cmd
          cmd_print="true"
        fi
        echo ${line/'# ==='/''}
        nl_printed=""
      else
        cmd=""
        if [[ -z $nl_printed ]]; then
          echo ""
          nl_printed="true"
        fi
      fi
    fi

  done

  FUNCTION_NAME="$(basename "$FILE" .sh)"
  FINAL="=== BOLD{{$FUNCTION_NAME}}"
  for LINE in $(cat "$FILE" | grep -P  '^# ==='); do
    LINE=${LINE/'# ==='/}
    LINE=${LINE//'{{CMD}}'/"GREEN{{$BIN_NAME}}  ${FUNCTION_NAME} "}
    LINE=${LINE//'{{BIN}}'/"BOLD{{$BIN_NAME}}"}
    LINE=${LINE//'{{NAME}}'/"GREEN{{$FUNCTION_NAME}}"}
    FINAL="$FINAL\n  $LINE"
  done
  COLORIZE "$FINAL"
} # === print-file


