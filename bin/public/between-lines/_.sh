
# === cat FILE | {{CMD}}  "PATTERN 1"   "PATTERN 2"
# ===            {{CMD}}  "PATTERN 1"   "PATTERN 2"  "FILE"
between-lines () {
  local +x FIRST="$1"; shift
  local +x SECOND="$1"; shift

  grep -Pzo "(?s)(\A|\n)$FIRST\n?\K(.+?)(?=\n$SECOND)"  "$@"
} # === end function


