
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
    if [[ ! -f "$BIN" ]]; then
      echo "skipping: $DIR - Not found: $BIN"
    fi
    git diff
    echo "=== Continue? y/n"
    read ANS
    if test "$ANS" != "y" ; then
      echo "skipping: $DIR by request"
      continue
    fi
    set -x
    git add $BIN
    git commit -am "Fixed: mksh_setup, no longer bash_setup"
    git push
    set +x
  done
}
