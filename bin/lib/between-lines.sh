
# === cat FILE | {{CMD}}  "PATTERN 1"   "PATTERN 2"
# ===            {{CMD}}  "PATTERN 1"   "PATTERN 2"  "FILE"
between-lines () {
  local +x FIRST="$1"; shift
  local +x SECOND="$1"; shift

  grep -Pzo "(?s)$FIRST\n?\K(.+?)(?=$SECOND)"  "$@"
} # === end function


specs () {
  local +x ACTUAL="$(echo "a\nFIRST\nabc\ndef\nSECOND\n" | mksh_setup between-lines "FIRST"  "SECOND")"
  should-match "$(echo -n "abc\ndef\n")"  "$ACTUAL"
} # === specs ()
