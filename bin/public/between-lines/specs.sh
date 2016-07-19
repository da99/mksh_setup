
specs () {
  local +x ACTUAL="$(echo "a\nFIRST\nabc\ndef\nSECOND\n" | mksh_setup between-lines "FIRST"  "SECOND")"
  should-match "$(echo -n "abc\ndef\n")"  "$ACTUAL"

  local +x ACTUAL="$(echo "FIRST\na\n-- FIRST\nabc\ndef\n-- SECOND\n" | mksh_setup between-lines "-- FIRST"  "-- SECOND")"
  should-match "$(echo -n "abc\ndef\n")"  "$ACTUAL"

  local +x ACTUAL="$(echo "-- FIRST\na\nFIRST\nabc\ndef\nSECOND\n" | mksh_setup between-lines "FIRST"  "SECOND")"
  should-match "$(echo -n "abc\ndef\n")"  "$ACTUAL"
} # === specs ()

specs
