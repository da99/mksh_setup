
# === {{CMD}}  ...
upcase () {
  echo "$@" | tr '[:lower:]' '[:upper:]' 
} # === end function

specs () {
  should-match "UPCASE"  "bash_setup upcase upcase"
  should-match "UPCASES" "bash_setup upcase uPcaSeS"
}
