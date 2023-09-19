#!/bin/bash
#
# Perform hot backups of WordPress files in a Docker Container.

source ./config/wordpress.sh

#######################################
# Create WordPress backup file.
# Globals:
#   backup_target
#   backup_filename
# Arguments:
#   None
#######################################
function backup(){
  docker exec -it ${container_name} /bin/bash -c "tar -cvf ${export_filename} ${backup_dir}/${backup_target}/" 
}

#######################################
# export the WordPress backup file to localhost.
# Globals:
#   container_name
#   wordpress_dir
#   backup_filename
# Arguments:
#   None
#######################################
function export(){
  docker cp ${container_name}:${backup_dir}/${export_filename} ${export_dir}/
}
 
#######################################
# Cleanup files from docker container.
# Globals:
#   container_name
# Arguments:
#   None
#######################################
function cleanup() {
  docker exec -it $container_name /bin/bash -c "rm ${export_filename}";
}

backup;
export;
cleanup;