
# === {{CMD}}
is-dev () {
   test -n "$IS_DEV"
} # === end function

specs () {
   IS_DEV="yes" should-exit 0 "mksh_setup is-dev"
   IS_DEV=""    should-exit 1 "mksh_setup is-dev"
} # === specs ()
