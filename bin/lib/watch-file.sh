
# === {{CMD}}   "file"   "my cmd -with -args"
watch-file () {
  #
  #  For more info on inotifywait:
  #    http://manpages.ubuntu.com/manpages/hardy/man1/inotifywait.1.html
  #
  local TARGET="$(readlink -m "$1")"; shift
  local cmd="$@"

  if [[ -z "$@" ]]
  then
    echo "No command given. Exiting..." 1>&2
    exit 1
  fi

  bash_setup BOLD "=== Watching: {{$TARGET}} -> {{$cmd}}"

  while read -r CHANGE; do
    dir=$(echo "$CHANGE" | cut -d' ' -f 1)
    op=$(echo "$CHANGE" | cut -d' ' -f 2)
    path="${dir}$(echo "$CHANGE" | cut -d' ' -f 3)"
    file="$(basename $path)"
    local FULLPATH="$(readlink -m "$path")"

    echo -n "=== $CHANGE"

    if [[ "$FULLPATH" != "$TARGET" ]]; then
      echo " (Skipping)"
      continue
    fi

    echo ""
    $cmd || { stat="$?"; echo -e "=== ${Red}Failed${Color_Off}: $stat"; }
  done < <(inotifywait --quiet --monitor --event close_write --exclude .git/ "$(dirname "$TARGET")")
} # === end function
