
source "$MKSH_DIR/bin/public/COLORIZE/_.sh"

# === {{CMD}} bin/file
# === {{CMD}} bin/file --list
# === {{CMD}} bin/file 'My Perl RegExp'
# === Available values in doc comments: 
# ===   CMD, FUNC_NAME, BIN, NAME, FILE_PATH, SOURCE_PATH, APP_NAME
print-help () {

  local +x ORIGINAL="$1"
  local +x TARGET_PATH="$(realpath "$1")"; shift
  local +x IS_FOUND=""
  local +x LIST_ONLY=""

  local +x SEARCH="/bin/public/"
  if [[ ! -z "$@" && "$1" == "--list" ]]; then
    LIST_ONLY="$1"; shift
  fi

  if [[ ! -z "$@" ]]; then
    SEARCH="$1"; shift
  fi

  # if bin/file
  if [[ "$TARGET_PATH" == */bin/* ]]; then
    export BIN_NAME="$(basename "$TARGET_PATH")"
    export APP_DIR="$(dirname "$(dirname "$TARGET_PATH")" )"
    export APP_NAME="$(basename "$APP_DIR")"
    export RELATIVE_APP_DIR="${APP_DIR/"$(dirname "$APP_DIR")"/".."}"

    cd "$APP_DIR"

    for FILE in $( \
      find -L "$APP_DIR/bin" -maxdepth 3 -mindepth 3 -type f  -name "_.sh" | \
      grep -P "$SEARCH" | \
      sort \
    ); do
      export FUNC_NAME="$(basename "$(dirname "$FILE")" )"
      export CMD="$BIN_NAME $FUNC_NAME"
      export FILE
      export FILE_SUB_PATH="${FILE/"$APP_DIR/"/""}"
      IS_FOUND="yes"
      if [[ ! -z "$LIST_ONLY" ]]; then
        COLORIZE "BOLD{{$FUNC_NAME}}"
        continue
      fi
      print-file
    done

  fi

  if [[ -z "$IS_FOUND" ]]; then
    mksh_setup RED "!!! No help documentation found for: {{${ORIGINAL}}}"
    exit 1
  fi

} # === end function

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

  FINAL=" BOLD{{$FUNC_NAME}}"
  local +x MSG="$(grep -P  "^# ===" "$FILE")"

  MSG=${MSG//'# ==='/"  "}
  MSG=${MSG//'{{CMD}}'/"GREEN{{$BIN_NAME}}  ${FUNC_NAME} "}
  MSG=${MSG//'{{APP_NAME}}'/"GREEN{{${APP_NAME}}}"}
  MSG=${MSG//'{{FUNC_NAME}}'/"GREEN{{${FUNC_NAME}}}"}
  MSG=${MSG//'{{BIN}}'/"BOLD{{$BIN_NAME}}"}
  MSG=${MSG//'{{NAME}}'/"GREEN{{$FUNC_NAME}}"}
  MSG=${MSG//'{{FILE_PATH}}'/"GREEN{{$FILE}}"}
  MSG=${MSG//'{{SOURCE_PATH}}'/"GREEN{{\$THIS_DIR/$RELATIVE_APP_DIR/$FILE_SUB_PATH/}}"}
  FINAL="$FINAL\n$MSG"

  COLORIZE "$FINAL"
} # === print-file


