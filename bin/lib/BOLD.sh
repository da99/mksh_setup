
# === {{CMD}}  "my string that is {{ bold }}"

source $THIS_DIR/bin/lib/COLORIZE.sh

specs () {
  bash_setup BOLD  "my string that is {{ bold }}"
  bash_setup BOLD  "this is also orange:  {{my {bold}}}"
}

BOLD () {
  COLORIZE "$(tput bold)" "$@"
}



