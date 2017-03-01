#!/bin/bash
set -e

POSTGRES="psql --username postgres"

echo "Creating database: ${DATABASE_NAME}"

$POSTGRES <<EOSQL
CREATE DATABASE ${DATABASE_NAME} OWNER ${DATABASE_USERNAME};
EOSQL
