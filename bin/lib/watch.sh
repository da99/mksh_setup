
# === {{CMD}}  "my args to inotifywait"   "my cmd -with -args"
watch () {
  #
  #  For more info on inotifywait:
  #    http://manpages.ubuntu.com/manpages/hardy/man1/inotifywait.1.html
  #
  args="$1"; shift
  cmd="$@"

  if [[ -z "$@" ]]
  then
    echo "No command given. Exiting..." 1>&2
    exit 1
  fi

  # === From an answer by "technosaurus":
  #     http://stackoverflow.com/a/18295696/841803
  echo "=== Watching: $args -> $cmd"
  inotifywait --quiet --monitor --event close_write --exclude .git/ $args | while read -r CHANGE; do
    dir=$(echo "$CHANGE" | cut -d' ' -f 1)
    op=$(echo "$CHANGE" | cut -d' ' -f 2)
    path="${dir}$(echo "$CHANGE" | cut -d' ' -f 3)"
    file="$(basename $path)"

    echo -n "=== $CHANGE"
    [[ ! -f "$path" ]] && echo " (Skipping)" && continue || :
    echo ""
    $cmd || { stat="$?"; bash_setup RED "=== {{Failed}}: $stat"; }
  done
} # === end function

