
# === {{CMD}}  "my args to inotifywait"   "my cmd -with -args"
watch () {
  if [[ $(pgrep -f -- "$(echo $@)" | wc -l) -gt 3 ]]; then
    echo "!!! Already running: $@" >&2
    exit 1
  fi

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

    if [[ ! -f "$path" ]] ; then
      # echo -e "\n\n\e[1m=======================================================\e[0m"
      # sh_color ORANGE "=== $CHANGE (Skipping {{non-file}})"
      continue
    fi

    if mksh_setup is-same-file "$path"; then
      sh_color ORANGE "=== Skipping file {{$path}} ({{hasn't changed}})"
      continue
    fi

    sh_color BOLD "=== {{$path}} - $op - $(date +'%I:%M:%S')"

    $cmd || { stat="$?"; sh_color RED "=== {{Failed}}: $stat ($cmd)"; }
  done
} # === end function

