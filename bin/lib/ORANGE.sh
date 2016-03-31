
# === {{CMD}}  "my string that is {{ orange }}"

source $THIS_DIR/bin/lib/COLORIZE.sh

specs () {
  local +x RESET='\e[0m'
  local +x BORANGE='\e[1;33m'

  should-match-output "$(echo -e my string that is ${BORANGE} orange ${RESET})" \
    'mksh_setup ORANGE  "my string that is {{ orange }}"'

  should-match-output "$(echo -e this is also orange: ${BORANGE}my {text}${RESET})" \
    'mksh_setup ORANGE  "this is also orange: {{my {text}}}"'

  should-match-output "$(echo -e this is also orange: ${BORANGE}my {text}${RESET} and ${BORANGE}this${RESET})" \
    'mksh_setup ORANGE  "this is also orange: {{my {text}}} and {{this}}"'
}

ORANGE () {
  COLOR="BRIGHT_ORANGE" COLORIZE "$@"
}



