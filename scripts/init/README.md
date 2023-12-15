These scripts will be executed on postgres container startup only if the data
directory is found to be empty.

`*.sql` scripts will be executed first, in alphabetical order, followed by
`*.sh` scripts, also in alphabetical order.

Please name the scripts with a two-digit prefix indicating the order in which
they will run. SQL scripts should start with 0, and shell scripts with 1. e.g.:

* 00-foo.sql
* 01-bar.sql
* 02-baz.sql
* 10-quz.sh
* 11-quux.sh
* 12-zyzzx.sh
