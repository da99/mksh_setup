
source "$THIS_DIR/bin/lib/COLORIZE.sh"

# === {{CMD}}
print-help () {
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

  local +x file="$1"; shift
  local +x cmd_print=""
  local +x cmd=""
  local +x nl_printed=""
  local +x BIN_NAME="$(basename "$file")"
  local +x IFS=$'\n'


  for line in $(cat $file); do
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

  dir_functions="$(dirname "$file")/lib"
  [[ ! -d "$dir_functions" ]] && exit 0 || :

  local +x IFS=$'\n'
  for FILE in $(find "$dir_functions" -type f -iname "*.sh" -print | sort); do
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
  done
} # === end function
