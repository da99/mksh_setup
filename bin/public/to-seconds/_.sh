
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
    sh_color RED "!!! Invalid value for time: $TIME"
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
      sh_color RED "!!! Invalid value for time: $TIME"
      exit 1
      ;;
  esac
} # === end function


