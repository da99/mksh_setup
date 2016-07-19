
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

