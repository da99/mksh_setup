# === {{CMD}}  "{{Passed}}: my text"
# === {{CMD}}  "mY {{teSts}} aLl PaSs"

source $THIS_DIR/bin/public/COLORIZE/_.sh

specs () {
  local +x RESET='\e[0m'
  local +x GREEN='\e[1;32m' # Bright/Bold Green
  local +x RED='\e[1;31m'   # Bright/Bold REd

  should-match-stdout "$(echo -e "=== ${GREEN}colored${RESET}: specs")" \
    'mksh_setup GREEN "=== {{colored}}: specs"'

  should-match-stdout "$(echo -e === ${GREEN}colored${RESET}dddd: specs)" \
    'mksh_setup GREEN "=== {{colored}}dddd: specs"'

  should-match-stdout "$(echo -e === my${GREEN}colored${RESET}dddd: specs)" \
    'mksh_setup GREEN "=== my{{colored}}dddd: specs"'

  should-match-stdout "$(echo -e === ${GREEN}COLOR${RESET}: specs)" \
    'mksh_setup GREEN "=== {{COLOR}}: specs"'

  should-match-stdout "$(echo -e === ${GREEN}GGGGREATT${RESET}: specs)" \
    'mksh_setup GREEN "=== {{GGGGREATT}}: specs"'

  should-match-stdout "$(echo -e === ${GREEN}colored${RESET}: ${RED}specs${RESET})" \
    'mksh_setup GREEN "=== {{colored}}: BRIGHT_RED{{specs}}"'
}

GREEN () {
  COLOR="BRIGHT_GREEN" COLORIZE "$@"
} # === end function

