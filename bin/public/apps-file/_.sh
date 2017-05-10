
# === {{CMD}}
# === Goes through all dirtyh /apps repos and commits
# === bin/name
apps-file () {
  local +x IFS=$'\n'

  for DIR in $(paradise backup); do
    if [[ ! -d "$DIR" ]]; then
      echo "skipping: $DIR"
      continue
    fi

    echo "=== $DIR"
    cd $DIR
    local +x BIN=bin/$(basename "$DIR")
    if ! git status | grep "$BIN"; then
      echo "skipping: $DIR - No change to $BIN"
      continue
    fi

    if [[ ! -f "$BIN" ]]; then
      echo "skipping: $DIR - Not found: $BIN"
    fi
    git status
    sh_color ORANGE "=== {{Continue}}? y/n"
    read ANS
    if test "$ANS" != "y" ; then
      echo "skipping: $DIR by request"
      continue
    fi
    set '-x'
    git add $BIN
    git commit -am "Fixed: mksh_setup, no longer my_bash"
    git push
    set +x
  done
}
