
# === {{CMD}}  -args -args ...
# === This is used to test to see if args are being passed correctly
# === between the shell and mksh_setup
each-args () {
  local +x NUM="0"
  while [[ ! -z "$@" ]]; do
    NUM="$(($NUM + 1))"
    echo "#$NUM: $1"; shift
  done
} # === end function
