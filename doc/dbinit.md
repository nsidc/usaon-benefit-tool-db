# DB Init

## After starting the docker-compose stack for the first time...

1. Postgres and adminer will be running
2. Main user will be created based on value of `POSTGRES_USER` envvar passed to
   container in `docker-compose.yml`
3. `usaon-benefit-tool` database and schema will be created by init scripts, along with
   a `support` user.


Note that no tables are created! Read on...


## Initializing Tables

This is the responsibility of the `usaon-benefit-tool` application project, as the
application code is tightly coupled to the database tables.
[DB Doc](https://github.com/nsidc/usaon-benefit-tool/blob/populate_SBA_ref_data/doc/db.md)
