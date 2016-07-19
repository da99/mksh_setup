
source $THIS_DIR/bin/public/COLORIZE/_.sh

specs () {
  local +x BRed='\e[1;31m'
  local +x Reset='\e[0m'
  local +x Green='\e[0;32m'

  should-match "$(echo -e this is ${BRed}red${Reset})" \
    "$(bash_setup RED "this is {{red}}" 2>&1)"
  should-match "$(echo -e this is ${BRed}red: {red}${Reset})" \
    "$(bash_setup RED "this is {{red: {red}}}" 2>&1)"
  should-match "$(echo -e this is ${BRed}red: {red}${Reset} and ${Green}green${Reset})" \
    "$(bash_setup RED "this is {{red: {red}}} and GREEN{{green}}" 2>&1)"
}

# === {{CMD}}  "my text"
# === {{CMD}}  "keyword"  "my text with keyword"
# === NOTE: Prints to STDERR
RED () {
  local BRed='\e[1;31m'
  local Red='\e[0;31m'
  COLOR="BRIGHT_RED" COLORIZE "$@" 1>&2
} # === end function
