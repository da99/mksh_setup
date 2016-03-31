
# === {{CMD}}  spec-run  my-shell-script.sh
run-specs () {
  if [[ -z "$@" ]]; then
    for FILE in $(grep -r -l -P '^specs\s*\(\)' bin/lib); do
      bash_setup BOLD "=== Specs: {{$FILE}}"
      bash_setup run-specs "$FILE"
      echo ""
    done

    files="$(grep -r -L -P '^specs\s*\(\)' bin/lib || :)"
    if [[ -n "$files" ]]; then
      bash_setup ORANGE "=== Files {{without}} specs:"
      echo -e "$files"
      echo ""
    fi

    bash_setup GREEN "==== All specs {{passed}}."
    return 0
  fi

  local FILE_ARG="$1"; shift
  local FILE

  if [[ -f "$FILE_ARG" ]]; then
    FILE="$FILE_ARG"
  else
    FILE="$(find bin/lib -type f -iname "$FILE_ARG")"
  fi

  source "$FILE"

  # NOTE: We can't use 'specs || report-fail'
  #  because of this:
  #  http://stackoverflow.com/questions/4072984/set-e-in-a-function
  trap 'report-fail $?' EXIT
  specs
  trap - EXIT

}

report-fail () {
  stat=$1; shift
  if [[ "$stat" -ne "0" ]]; then
    bash_setup RED "=== Spec {{Failed}} with exit status: $stat"
  fi
  exit $stat
}

# should-pass  "my cmd with args"
# should-pass  my cmd with args
should-pass () {
  local stat
  set +e
  eval "$@"
  stat=$?
  set -e

  if [[ "$stat" -eq "0" ]]; then
    bash_setup GREEN  "=== {{Passed}}: $@"
  else
    bash_setup RED "=== {{Failed}}: exit $stat: $@"
  fi
}

should-exit () {
  local expect="$1"; shift
  local actual
  local cmd="$@"

  set +e
  eval "$@"
  actual="$?"
  set -e

  if [[ "$expect" -eq "$actual" ]]; then
    bash_setup GREEN  "=== {{Passed}}: exit $expect: $cmd"
  else
    bash_setup RED "=== Spec wanted status $expect but got {{$actual}}"
  fi
}

#  should-match  "EXPECT"   "my-cmd -with -args"
should-match () {
  local EXPECT="$1"; shift
  local CMD="$1"; shift
  local STAT
  local ACTUAL

  set +e
  ACTUAL="$(eval "$CMD")"
  STAT="$?"
  set -e

  if [[ "$ACTUAL" != "$EXPECT" ]]; then
    if [[ -z "$ACTUAL" ]]; then
      ACTUAL="[NULL STRING]"
    fi
    bash_setup RED "=== MISMATCH: \"{{$ACTUAL}}\"  !=  \"$EXPECT\""
    exit 1
  else
    bash_setup GREEN  "=== {{Passed}}: $CMD"
  fi
}

# should-match-regexp  "my regexp"  "my cmd -with -args"
should-match-regexp () {
  local EXPECT="$1"; shift
  local CMD="$1"; shift
  local STAT
  local ACTUAL

  set +e
  ACTUAL="$(eval "$CMD")"
  STAT="$?"
  set -e

  if echo "$ACTUAL" | grep -P "$EXPECT"; then
    bash_setup GREEN  "=== {{Passed}}: $CMD"
  else
    bash_setup RED "=== EXPECTED: {{$ACTUAL}}  =~  $EXPECT"
  fi
}



