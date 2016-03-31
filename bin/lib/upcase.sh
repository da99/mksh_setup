
# === {{CMD}}  ...
upcase () {
  echo "$@" | tr '[:lower:]' '[:upper:]' 
} # === end function

specs () {
  should-match-output "UPCASE"  "mksh_setup upcase upcase"
  should-match-output "UPCASES" "mksh_setup upcase uPcaSeS"
}
