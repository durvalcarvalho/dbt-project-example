#!/bin/bash

# HOW TO USE >>> ./load_dump.sh hostname port username database_name password container_name_or_id
# Example:   >>> ./load-dataset.sh 0.0.0.0 5432 postgres testing postgres 38bd78d35ff7

# Variables
HOSTNAME=$1
PORT=$2
USERNAME=$3
DATABASE=$4
PASSWORD=$5
DUMP_FILE="art-database-dump.sql"
CONTAINER_NAME_OR_ID=$6

# Export the PGPASSWORD variable
export PGPASSWORD=$PASSWORD

# Load the dump file into the database
docker exec -i $CONTAINER_NAME_OR_ID psql -h $HOSTNAME -p $PORT -U $USERNAME -d $DATABASE -f $DUMP_FILE

# Unset the PGPASSWORD variable
unset PGPASSWORD