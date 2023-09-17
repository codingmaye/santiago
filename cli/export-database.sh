#!/bin/bash
#
# Perform hot backups of MySQL databases in a Docker Container.


backup_dir="../backups/to_export"
backup_filename="database.sql"
container_name="support_mac_and_pc-db-1"
mysql_username="wordpress"
mysql_password="wordpress"
mysql_database_name="wordpress"

#######################################
# Create MySQL database backup.
# Globals:
#   mysql_username
#   mysql_database_name
#   backup_filename
#   container_name
# Arguments:
#   None
#######################################
function backup(){
  docker exec -it $container_name /bin/bash -c "mysqldump -u ${mysql_username} -p ${mysql_database_name} > ${backup_filename}";
}

#######################################
# Copy database dump file to localhost.
# Globals:
#   backup_dir
#   backup_filename
#   container_name
# Arguments:
#   None
#######################################
function copy(){
  docker cp $container_name:/$backup_filename $backup_dir;
}
 
#######################################
# Cleanup files from the backup directory.
# Globals:
#   container_name
#   backup_filename
# Arguments:
#   None
#######################################
function cleanup() {
  docker exec -it $container_name /bin/bash -c "rm ${backup_filename}";
}

backup;
copy;
cleanup;