#===============================================================================
#
#          FILE: remove_docker_images_clean_disk.sh
# 
#         USAGE: ./remove_docker_images_clean_disk.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: remove all docker images when disk space above 80%. [crontab -e] */5 * * * * bash /scripts/remove-docker-images.sh >> /scripts/clean.log >/dev/null 2>&1
#        AUTHOR: Ratul Basak, 
#  ORGANIZATION: 
#       CREATED: বৃহস্পতিবার 24 জানু 2019 11:19:52  +06
#      REVISION:  ---
#===============================================================================

#!/bin/bash

volume='/dev/xvda1'
space=$(df -H $volume | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 }')
cmd=$(df -H $volume | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 }' | cut -d'%' -f1)

if [ $cmd -ge 80 ]; then
   echo "Running out of space. Deleting docker images"
   docker rm $(docker ps -a -q)
   docker rmi $(docker images -aq)
else
   echo "Diskspace is available $volume : $space"
fi

