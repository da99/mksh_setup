
# === {{CMD}}  "perl regex pattern"
first-line-after () {
  local +x PATTERN="$1"; shift
  while read -r LINE ; do
    if ! echo "$LINE" | grep -P "^${PATTERN}$" >/dev/null; then
      continue
    fi

    while read -r ORIGINAL_LINE; do
      local +x CLEAN="$(echo -n $ORIGINAL_LINE)"
      if [[ -z "$CLEAN" ]]; then
        continue
      fi
      echo "$ORIGINAL_LINE"
      exit 0
    done

  done
  exit 1
} # === end function


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
