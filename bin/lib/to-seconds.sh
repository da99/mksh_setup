
# === {{CMD}}  TIME
# === Examples:
# ===  {{CMD}} 5
# ===  {{CMD}} 5s
# ===  {{CMD}} 10m
# ===  {{CMD}} 1h
to-seconds () {
  local +x TIME="$1"; shift
  local +x NUM="$(echo $TIME | grep -Po "\d+"  || :)"
  local +x UNIT="$(echo $TIME | grep -Po "\d+\K(.)" || echo s)"

  if [[ -z "$NUM" || -z "$UNIT" ]]; then
    mksh_setup RED "!!! Invalid value for time: $TIME"
    exit 1
  fi

  case "$UNIT" in
    d|days)
      echo "$(($NUM * 60 * 60 * 24))"
      ;;
    h|hr|hour|hours)
      echo "$(($NUM * 60 * 60))"
      ;;
    m|min|mins)
      echo "$(($NUM * 60))"
      ;;
    s|sec|secs)
      echo "$(($NUM))"
      ;;
    *)
      mksh_setup RED "!!! Invalid value for time: $TIME"
      exit 1
      ;;
  esac
} # === end function

specs () {
  should-match-output "$((60 * 1))"           "mksh_setup to-seconds 1m"
  should-match-output "$((60 * 60))"      "mksh_setup to-seconds 1h"
  should-match-output "$((60 * 60 * 24))" "mksh_setup to-seconds 1d"
} # === specs

