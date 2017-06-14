
* https://news.ycombinator.com/item?id=14390976

bin/install-mksh
================

Instead of `mksh_setup install`, you have to use `mksh_setup/bin/install-mksh`.
The `mksh_setup` binary runs on `mksh`. `bin/install` runs on `sh` because
you can't use `mksh` because it is install on the system.`

KSH (Korn Shell)
===
* https://www.ibm.com/support/knowledgecenter/ssw_aix_72/com.ibm.aix.osdevice/korn_shell_enhanced.htm

Guidelines
=========

* Once I start "sourcing" other files that I wrote, then it's
a sign I need to use Crystal.

* `local +x PATH` -- Don't use this because it sets PATH to an NULL string
  for sub/child processes.

TODO:
===========

* watch : When multiple files are changed in less than one 1 second.
  Example: ":wa" in VIM

* watch-file: is watching all of directory for:
  "watch-file "/tmp/file" "my cmd"
