#===============================================================================
#
#          FILE: restart_all_pods.sh
# 
#         USAGE: ./restart_all_pods.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: Restart all pods in all Namespaces exclude (kube-system,kube-public,reverse-proxy)
#        AUTHOR: Ratul Basak, 
#  ORGANIZATION: 
#       CREATED: বৃহস্পতিবার 24 জানু 2019 11:56:56  +06
#      REVISION:  ---
#===============================================================================

#!/bin/bash
set e

NAMESPACES=( $(kubectl get namespaces -o jsonpath="{.items[?(@.spec)].metadata.name}") )
# NAMESPACES=( $(ls) )
#echo $NAMESPACES
my_array_length=${NAMESPACES[@]}

echo
echo "---------------------------------------------------------------------"
echo "|INFO| : Restarting All PODS"
echo "---------------------------------------------------------------------"
echo
for i in "${NAMESPACES[@]}"
do
  if [[ $i == "kube-system" ]] || [[ $i == "kube-public" ]] || [[ $i == "reverse-proxy" ]];
  then
    echo "Skipping! NAMESPACE---> $i"
  else
    echo "Namespaces : $i"
    kubectl delete pods --all --namespace=$i
  fi

done

echo
echo "---------------------------------------------------------------------"
echo "|RESTARTED|"
echo "---------------------------------------------------------------------"#!/bin/bash
