
source $THIS_DIR/bin/lib/COLORIZE.sh

specs () {
  bash_setup RED "this is {{red}}"
  bash_setup RED "this is {{red: {red}}}"
}

# === {{CMD}}  "my text"
# === {{CMD}}  "keyword"  "my text with keyword"
# === NOTE: Prints to STDERR
RED () {
  local BRed='\e[1;31m'
  local Red='\e[0;31m'
  COLORIZE "$BRed" "$@" 1>&2
} # === end function
