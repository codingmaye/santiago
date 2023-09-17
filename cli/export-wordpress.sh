#!/bin/bash
#
# Perform hot backups of WordPress files in a Docker Container.


backup_dir="../backups/to_export"
backup_filename="wordpress.tar"
wordpress_dir="/var/www/html"
backup_target="wp-content/"                # Change it according to your needs
container_name="support_mac_and_pc-wordpress-1"

#######################################
# Create WordPress backup file.
# Globals:
#   backup_target
#   backup_filename
# Arguments:
#   None
#######################################
function backup(){
  docker exec -it $container_name /bin/bash -c "tar -cvf ${backup_filename} ${backup_target}" 
}

#######################################
# Copy the WordPress backup file to localhost.
# Globals:
#   container_name
#   wordpress_dir
#   backup_filename
# Arguments:
#   None
#######################################
function copy(){
  docker cp $container_name:${wordpress_dir}/$backup_filename $backup_dir/
}
 
#######################################
# Cleanup files from docker container.
# Globals:
#   container_name
# Arguments:
#   None
#######################################
function cleanup() {
  docker exec -it $container_name /bin/bash -c "rm ${backup_filename}";
}

backup;
copy;
cleanup;