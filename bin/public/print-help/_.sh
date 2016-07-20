
source "$THIS_DIR/bin/public/COLORIZE/_.sh"

# === {{CMD}} dir/path
# ===   Prints all *.sh files in dir
# === {{CMD}} path/to/file
# ===   If file is in a dir called "bin/", and file is alongside
# ===   another directory "lib",
# ===   then all the files in lib/ are also printed.
print-help () {

  local +x ORIGINAL="$1"
  local +x TARGET_PATH="$(realpath "$1")"; shift

  # if bin/file
  if [[ "$TARGET_PATH" == */bin/* ]]; then
    export BIN_NAME="$(basename "$TARGET_PATH")"
    export APP_DIR="$(dirname "$(dirname "$TARGET_PATH")" )"
    export APP_NAME="$(basename "$APP_DIR")"

    for FILE in $(find -L $(mksh_setup ls-dirs "$APP_DIR/bin/public") -maxdepth 1 -mindepth 1 -type f -name "_.sh" | sort); do
      export FUNC_NAME="$(basename "$(dirname "$FILE")" )"
      export CMD="$BIN_NAME $FUNC_NAME"
      export FILE
      print-file
    done

    return 0
  fi

  # if dir
  if [[ -d "$TARGET_PATH" ]]; then
    return 0
  fi

  # if _.sh shell file
  if [[ "$TARGET_PATH" == */_.sh ]]; then
    return 0
  fi

  # if non-_.sh shell file
  if [[ "$TARGET_PATH" == *.sh ]]; then
    return 0
  fi

  mksh_setup RED "!!! Unknown file to parse: {{${TARGET_PATH}}} ({{$ORIGINAL}})"

  local +x DIR="$(dirname "$(realpath "$TARGET")")"
  local +x DIRNAME="$(basename "$DIR")"
  local +x LIB="$DIR/lib"

  if [[ -d "$TARGET" ]]; then
    print-dir "$TARGET"
    return 0
  fi

  if [[ "$DIRNAME" == "bin" ]]; then
    local +x APP_DIR="$(dirname "$DIR")"
    local +x BIN_NAME="$(basename "$TARGET")"
    for FILE in $(find -L $(mksh_setup ls-dirs "$DIR/public") -maxdepth 1 -mindepth 1 -type f -name "_.sh" | sort); do
      echo "=== $FILE"
      local +x NAME="$(  basename  "$(dirname "$FILE")"   )"
      print-file "$APP_DIR" "$NAME" "$FILE"
    done
  fi

  # mksh_setup RED "=== Help not available for: "$TARGET""
  # exit 1

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

  local +x cmd_print=""
  local +x cmd=""
  local +x nl_printed=""
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

  FINAL="=== BOLD{{$FUNC_NAME}}"
  for LINE in $(cat "$FILE" | grep -P  '^# ==='); do
    LINE=${LINE/'# ==='/}
    LINE=${LINE//'{{CMD}}'/"GREEN{{$BIN_NAME}}  ${FUNC_NAME} "}
    LINE=${LINE//'{{BIN}}'/"BOLD{{$BIN_NAME}}"}
    LINE=${LINE//'{{NAME}}'/"GREEN{{$FUNC_NAME}}"}
    FINAL="$FINAL\n  $LINE"
  done

  COLORIZE "$FINAL"
} # === print-file


