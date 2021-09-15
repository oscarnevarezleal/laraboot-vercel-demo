#!/usr/bin/env bash
# This is an example script that uses laraboot build hooks

set -eu
set -o pipefail

# Here we're using sqlite but a real world scenario would be using real database connection
touch database/database.sqlite
echo "APP_ENV=local" >> .env
echo "APP_DEBUG=true" >> .env
echo "DB_CONNECTION=sqlite" >>.env
echo "DB_DATABASE=$(pwd)/database/database.sqlite" >>.env

# Use this for artisan calls
readonly artisan="php $PHP_ARGS artisan"

# Force the migration, it will happen during build time
${artisan} migrate:refresh --seed --force
