

specs () {
   local +x OUTPUT="$(echo -n "a\nb\nc\n" | mksh_setup first-line-after "b")"
   should-match "c" "$OUTPUT"

   local +x OUTPUT="$(echo -n "a\n===  b\nc  c\n" | mksh_setup first-line-after "===\ +b")"
   should-match "c  c" "$OUTPUT"

   echo -n "a\n===  b\nc\n" | mksh_setup first-line-after "===\ +d" && stat="$?" || stat="$?"
   should-match "1" "$stat"

   echo -n "a\n===  b\nc\n" | mksh_setup first-line-after "===\ +b" >/dev/null && stat="$?" || stat="$?"
   should-match "0" "$stat"
} # === specs ()

specs
