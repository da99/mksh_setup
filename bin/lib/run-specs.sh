
Color_Off='\e[0m'
Bold="$(tput bold)"
Reset='\e[0m'
BRed='\e[1;31m'
Red='\e[0;31m'
Green='\e[0;32m'
BGreen='\e[1;32m'
Orange='\e[0;33m'
BOrange='\e[1;33m'

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
    mksh_setup RED "=== Spec {{Failed}} with exit status: $stat"
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
#  should-match  "EXPECT"   "ACTUAL"
should-match () {
  local +x EXPECT="$1"; shift
  local +x CMD="$1"; shift
  local +x STAT
  local +x ACTUAL

  local +x CMD_FILE="$(echo $CMD | grep -Po "([^[:space:]]+)" | head -n 1)"

  if [[ "$CMD" == "$EXPECT" ]] || ! which "$CMD_FILE" >/dev/null; then
    ACTUAL="$CMD"
  else
    ACTUAL="$(eval "$CMD")"
  fi
  STAT="$?"
  set -e

  if [[ "$ACTUAL" != "$EXPECT" ]]; then
    if [[ -z "$ACTUAL" ]]; then
      ACTUAL="[NULL STRING]"
    fi
    exec >&2
    echo -e -n '=== MISMATCH: "${Red}'; echo -E -n "$ACTUAL";
    echo -e -n '"  !=  "'; echo -E -n "$EXPECT"
    exit 1
  else
    mksh_setup GREEN  "=== {{Passed}}: " -n; echo -E $CMD
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



