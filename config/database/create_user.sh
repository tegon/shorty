#!/bin/bash
set -e

POSTGRES="psql --username postgres"

echo "Creating database role: ${DATABASE_USERNAME}"

$POSTGRES <<-EOSQL
CREATE USER ${DATABASE_USERNAME} WITH CREATEDB PASSWORD '${DATABASE_PASSWORD}';
EOSQL
