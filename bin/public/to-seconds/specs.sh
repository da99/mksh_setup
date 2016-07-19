  should-match-stdout "$((60 * 1))"           "mksh_setup to-seconds 1m"
  should-match-stdout "$((60 * 60))"      "mksh_setup to-seconds 1h"
  should-match-stdout "$((60 * 60 * 24))" "mksh_setup to-seconds 1d"

