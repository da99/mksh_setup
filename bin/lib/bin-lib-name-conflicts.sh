
# === Expects names end in .sh:  bin/lib/name-goes-here.sh
# === Exits 1 if any conflicts found between file name and function name.
# === {{CMD}}
bin-lib-name-conflicts () {

  found=""
  files="$(find $(echo /apps/*/bin/lib) -type f -iname '*.sh')"
  [[ -z "$files" ]] && { echo "=== No files found." 1>&2; exit 1; } || :

  while read FILE; do
    BASE="$(basename "$FILE" .sh)"
    FUNCTION_NAMES="$(grep -Pzo '^([a-zA-Z\-\_0-9\!\?]+?)(?=\s+\(\)\s+{)' "$FILE" || :)"
    FUNC="$(echo "$FUNCTION_NAMES" | grep --extended-regexp '^'$BASE'$' || :)"
    if [[ "$BASE" != "$FUNC" ]]; then
      found="yes"
      echo -n -e "!!! ${Red}Conflict${Color_Off}: $BASE != [" 1>&2
      echo -n $(bash_setup join-lines  "$FUNCTION_NAMES" ", ") 1>&2
      echo -e "] in ${Bold}$FILE${Color_Off}" 1>&2
    # else
    #   echo -e "=== pass: ${Bold}$FILE${Color_Off}"
    fi
  done < <(echo "$files")

  if [[ -n "$found" ]]; then
    exit 1
  else
    echo -e "=== ${Green}Passed${Color_Off}: $(echo "$files" | wc -l) files"
  fi
}
