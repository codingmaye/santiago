#!/bin/bash
#
# Perform hot backups of MySQL databases in a Docker Container.


source ./config/database.sh

#######################################
# Create Mariadb database backup.
# Globals:
#   mysql_username
#   mysql_database_name
#   database_dump_filename
#   container_name
# Arguments:
#   None
#######################################
function backup(){
  docker exec -it ${container_name} /bin/bash -c "mysqldump -u ${mysql_username} -p ${mysql_database_name} > /${database_dump_filename}";
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
function export(){
  time_now=$(date +"%Y_%m_%d-%H_%M_%S")
  mkdir ${export_dir}/${time_now}/
  touch ${export_dir}/${time_now}/.git
  docker cp ${container_name}:/${database_dump_filename} ${export_dir}/${time_now}/;
}
 
#######################################
# Cleanup files from the backup directory.
# Globals:
#   container_name
#   database_dump_filename
# Arguments:
#   None
#######################################
function cleanup() {
  docker exec -it $container_name /bin/bash -c "rm /${database_dump_filename}";
}

backup;
export;
cleanup;