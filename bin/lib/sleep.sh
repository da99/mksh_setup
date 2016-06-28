
# === {{CMD}}  # 60 seconds as default
# === {{CMD}}  seconds-as-number
sleep () {
  local SECONDS=60
  local SLEEP_CMD="$(which sleep)"

  if [[ -n "$@" ]]; then
    SECONDS="$1"; shift
  fi

  local COUNTER="$SECONDS"
  while [[ "$COUNTER" -gt "0" ]]; do
    COUNTER="$(($COUNTER - 1))"
    echo -en "\r$(tput el)  $COUNTER  "
    $SLEEP_CMD "1s"
  done
  echo -en "\r$(tput el)"
} # === end function
