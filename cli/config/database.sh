#!/bin/bash
#
# Data for export and import cli commands

database_dump_filename="database.sql"

## export-database.sh
export_dir="../backups/to_export"
export_filename="database.sql"
container_name="wordpress_docker_manager_cli-database-1"
mysql_username="wordpress"
mysql_database_name="wordpress"

## import-database.sh
import_dir="../backups/to_import"
import_filename=""