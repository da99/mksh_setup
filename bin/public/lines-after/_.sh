
# === {{CMD}}  "perl regex pattern"
lines-after () {
  local +x PATTERN="$1"; shift
  grep -Pzo "(?s)(\A|\n)(\s*)$PATTERN\ *\n\K(.+)"
} # === end function

