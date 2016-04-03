
# === {{CMD}}  dir1  dir2
# === This is the same as: diff dir1 dir2
# === It is used because I found "dirs-are-equal" easier to understand and read
# === than "diff".
# === This is mainly used for specs/testing.
dirs-are-equal () {
  diff "$@"
} # === end function
