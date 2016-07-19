
  should-match "1,2,3" 'mksh_setup join-lines  "1\n2\n3" ","'
  should-match "a, b"  'mksh_setup join-lines  "a\nb" ", "'
  should-match "a, b"  'mksh_setup join-lines  "a\nb\n" ", "'
  should-match "a"     'mksh_setup join-lines  "a\n" ", "'
  should-match "a"     'mksh_setup join-lines  "a" ", "'
