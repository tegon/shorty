#!/bin/bash
set -e

POSTGRES="psql --username postgres ${DATABASE_NAME}"

echo "Create uuid-ossp extension on: ${DATABASE_NAME}"

$POSTGRES <<EOSQL
CREATE EXTENSION "uuid-ossp";
EOSQL
