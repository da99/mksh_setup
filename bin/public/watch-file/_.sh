
# === {{CMD}}   "file"   "my cmd -with -args"
watch-file () {
  if [[ $(pgrep -f -- "$(echo $@)" | wc -l) -gt 3 ]]; then
    echo "!!! Already running: $@" >&2
    exit 1
  fi

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

  sh_color BOLD "=== Watching: {{$TARGET}} -> {{$cmd}}"

  if [[ ! -e "$TARGET" ]]; then
    while [[ ! -e "$TARGET" ]]; do
      sleep 1
    done
    sh_color BOLD "=== Created: $TARGET"
    $cmd
  fi

  inotifywait  \
   --quiet    \
   --monitor  \
   --event close_write \
   --exclude .git/ "$(dirname "$TARGET")" | while read -r CHANGE; do
    dir=$(echo "$CHANGE" | cut -d' ' -f 1)
    op=$(echo "$CHANGE" | cut -d' ' -f 2)
    path="${dir}$(echo "$CHANGE" | cut -d' ' -f 3)"
    file="$(basename $path)"
    local FULLPATH="$(readlink -m "$path")"

    if [[ "$FULLPATH" != "$TARGET" ]]; then
      continue
    fi

    sh_color BOLD "=== {{Changed}}: $CHANGE"
    $cmd || { stat="$?"; sh_color RED "=== Command {{Failed}}: $stat"; }
  done
} # === end function
