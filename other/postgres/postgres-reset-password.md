---
title: Resetting the PostgreSQL Password
---
# Resetting the PostgreSQL Password

Find the file `pg_hba.conf` - it may be located in `/etc/postgresql-9.1/pg_hba.conf` or `/var/lib/pgsql/data/pg_hba.conf` (back it up).

Place the following line (as either the first uncommented line, or as the only one):

`local  all   all   trust`

Restart your PostgreSQL server, e.g., on Linux:

`sudo /etc/init.d/postgresql restart` or (for systemd) `sudo service postgresql restart`

If the service (daemon) doesn't start reporting in log file: `local connections are not supported by this build` you should change:

`local  all   all   trust` to `host  all   all  127.0.0.1/32  trust`

Connect as the postgres user:

`psql -U postgres`

Reset the password:

`ALTER USER my_user_name WITH PASSWORD 'super_secure_password';`

Restore the old pg_hba.conf as it is very dangerous to keep around (remove the line added above or replace with the backup copy).

Restart the server as described above.
<hr>
