FROM postgres:14.1


# Set up db user
RUN useradd --uid 1000 --user-group --create-home --home-dir /home/dbuser dbuser 
RUN mkdir -p /data
RUN chown dbuser:dbuser /data
RUN mkdir -p /var/log/postgresql
RUN chown dbuser:dbuser /var/log/postgresql
USER dbuser:dbuser


# Configuration
ENV PGDATA=/data/db
COPY ./postgresql.conf /etc/postgresql/postgresql.conf


# Init scripts
COPY ./scripts/init/* /docker-entrypoint-initdb.d/


# Healthcheck
COPY postgres-healthcheck /usr/local/bin/
HEALTHCHECK --retries=10 --interval=5s --timeout=3s CMD ["postgres-healthcheck"]


CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
