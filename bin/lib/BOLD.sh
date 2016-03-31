
# === {{CMD}}  "my string that is {{ bold }}"

source $THIS_DIR/bin/lib/MULTI.sh

specs () {
  local +x RESET='\e[0m'
  local +x BOLD='\e[1m'

  should-match-output "$(echo -e my string that is ${BOLD} bold ${RESET})" \
    'mksh_setup BOLD  "my string that is {{ bold }}"'

  should-match-output "$(echo -e this is also bold: ${BOLD}my {bold}${RESET})" \
    'mksh_setup BOLD  "this is also bold: {{my {bold}}}"'
}

BOLD () {
  COLOR="BOLD" MULTI "$@"
}



