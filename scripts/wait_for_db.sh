#!/bin/sh
set -e

until [ "$(docker inspect --format='{{.State.Health.Status}}' db)" = "healthy" ]; do
  >&2 echo "DB is unavailable - sleeping"
  sleep 1
done

>&2 echo "DB is up";
