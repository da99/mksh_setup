
# === {{CMD}}  ...
upcase () {
  echo "$@" | tr '[:lower:]' '[:upper:]' 
} # === end function

specs () {
  should-match-stdout "UPCASE"  "mksh_setup upcase upcase"
  should-match-stdout "UPCASES" "mksh_setup upcase uPcaSeS"
}
