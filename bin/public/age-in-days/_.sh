
# === {{CMD}}  file|dir|symlink
# === Displays how old the file modified date is in days.
# === Follows symlinks.
age-in-days () {
  local +x ORIGIN="$1"
  local +x TARGET="$(realpath "$1" || :)"; shift

  if [[ -z "$TARGET" || ! -e "$TARGET" ]]; then
    mksh_setup RED "!!! {{$ORIGIN}}"
    exit 1
  fi

  local +x MODIFIED_ISO="$(stat "$TARGET" | grep "Modify: " | cut -d' ' -f2-)"
  if [[ -z "$MODIFIED_ISO" ]]; then
    exit 1
  fi

  local +x MODIFIED="$(date -d"$MODIFIED_ISO" +%s)"

  if [[ -z "$MODIFIED" ]]; then
    exit 1
  fi

  local +x TODAY_IN_SECONDS=$(date +%s)
  echo $(( ($TODAY_IN_SECONDS - $MODIFIED) / (60 * 60 * 24)  ))
} # === end function
