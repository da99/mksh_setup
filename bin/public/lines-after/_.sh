
# === {{CMD}}  "perl regex pattern"
lines-after () {
  local +x PATTERN="$1"; shift
  grep -Pzo "(?s)(\A|\n)(\s*)$PATTERN\ *\n\K(.+)"
} # === end function

specs () {

  local +x OUTPUT="$(echo -e "a\nb\nc\nd\ne" | mksh_setup lines-after "b")"
  should-match "$(echo -e "c\nd\ne")" "$OUTPUT"

  local +x OUTPUT="$(echo -e "a\na b\nc\nd\ne" | mksh_setup lines-after "b")"
  should-match "" "$OUTPUT"

} # === specs ()
