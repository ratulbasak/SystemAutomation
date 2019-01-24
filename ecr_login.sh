#===============================================================================
#
#          FILE: ecr_login.sh
# 
#         USAGE: ./ecr_login.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: awscli [aws configure]
#          BUGS: ---
#         NOTES: Login to aws ecr. [crontab -e] * */8 * * * /scripts/ecr_login.sh >> /scripts/cron.log
#        AUTHOR: Ratul Basak, 
#  ORGANIZATION: 
#       CREATED: বৃহস্পতিবার 24 জানু 2019 11:28:06  +06
#      REVISION:  ---
#===============================================================================

#!/bin/bash

export docker_server=https://AWS_ACCOUNT_ID.dkr.ecr.eu-central-1.amazonaws.com
export token=$(aws ecr get-authorization-token --query authorizationData[].authorizationToken --output text | base64 -d | cut -d: -f2)

#export login=`echo $aws_login`

#$login
docker login -u AWS -p $token $docker_server

