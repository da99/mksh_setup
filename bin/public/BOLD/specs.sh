

specs () {
  local +x RESET='\e[0m'
  local +x BOLD='\e[1m'

  should-match-stdout "$(echo -e my string that is ${BOLD} bold ${RESET})" \
    'mksh_setup BOLD  "my string that is {{ bold }}"'

  should-match-stdout "$(echo -e this is also bold: ${BOLD}my {bold}${RESET})" \
    'mksh_setup BOLD  "this is also bold: {{my {bold}}}"'
}
specs
