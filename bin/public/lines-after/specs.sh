
specs () {

  local +x OUTPUT="$(echo -e "a\nb\nc\nd\ne" | mksh_setup lines-after "b")"
  should-match "$(echo -e "c\nd\ne")" "$OUTPUT"

  local +x OUTPUT="$(echo -e "a\na b\nc\nd\ne" | mksh_setup lines-after "b")"
  should-match "" "$OUTPUT"

} # === specs ()

specs
