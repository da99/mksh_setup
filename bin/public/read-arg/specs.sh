
  should-match-stdout "yoyo" "mksh_setup read-arg --message  --message yoyo"
  should-match-stdout "yoyo" "mksh_setup read-arg --message  -other -arg random --message yoyo random"
  should-exit         1      "mksh_setup read-arg --body     -no -body or anything else"
