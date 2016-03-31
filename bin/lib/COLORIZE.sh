
specs () {
  bash_setup COLORIZE "$(tput bold)"  "this is {{bold}}"
  bash_setup COLORIZE "$(tput bold)"  "this is {{bold}}"
  bash_setup COLORIZE "$(tput bold)"  "this is {{bold}} and {{this too}}"
  bash_setup COLORIZE "$(tput bold)"  "this is {{bold {curly}}} and {{this {too}}}"
  bash_setup COLORIZE "$(tput bold)"  "this has no {{new line}}"  "-n"
  echo " ... but this does"
  bash_setup COLORIZE "$(tput bold)"  "this has is {{multi
  line}}"
}

# === {{CMD}}  "MY_ESCAPE_SEQUENCE"  "my {{text}}"
# === {{CMD}}  "MY_ESCAPE_SEQUENCE"  "my {{text}}"   "-n -E"
# === {{CMD}}  "MY_ESCAPE_SEQUENCE"  "my {{text}}"   "-n -E"
COLORIZE () {
  local ESCAPED_COLOR
  local COLOR_OFF="\\e\[0m"
  ESCAPED_COLOR="$1"; shift
  local ECHO_ARGS=""
  local TEXT

  if [[ "$#" -eq 2 ]]; then
    TEXT="$1"; shift
    ECHO_ARGS="$1"; shift
  else
    TEXT="$@"
  fi

  echo $ECHO_ARGS "$TEXT" | perl -p -00 -e "s/\{\{(.+?)\}\}(?!\})/${ESCAPED_COLOR}\1${COLOR_OFF}/gs"

} # === end function

