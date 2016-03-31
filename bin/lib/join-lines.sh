
# === Join multiple lines into one:
# === {{CMD}}  "content"  "delimiter"

specs () {
  should-match "1,2,3" 'mksh_setup join-lines  "1\n2\n3" ","'
  should-match "a, b"  'mksh_setup join-lines  "a\nb" ", "'
  should-match "a, b"  'mksh_setup join-lines  "a\nb\n" ", "'
  should-match "a"     'mksh_setup join-lines  "a\n" ", "'
  should-match "a"     'mksh_setup join-lines  "a" ", "'
}

join-lines () {

  content="$1"; shift
  delim="$1"; shift
  while [[ -n "$@" ]]; do
    content="$content\n$delim"
    delim="$1"; shift
  done
  new_content=""
  total="$(echo -e "$content" | wc -l)"
  counter=0

  for LINE in $(echo -e "$content"); do
    trim="$(echo -n $LINE)"
    [[ -z "$trim" ]] && continue || :

    if [[ -n "$new_content" ]]; then
      new_content="${new_content}${delim}"
    fi
    new_content="${new_content}$LINE"
  done

  echo "$new_content"
} # === end function

