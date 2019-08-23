#!/bin/bash

source "./Config/bindings-details.txt"


echo ${BASE_FOLDER_PATH}
echo  "------------------------------------------------------------------------------------" &>>  ${BASE_FOLDER_PATH}/Execution.log
echo  "" &>>  ${BASE_FOLDER_PATH}/Execution.log
echo  "Start of Execution for the Date :: "`date` &>>  ${BASE_FOLDER_PATH}/Execution.log


  setProjectSpecificDetail()
 {
     echo "Console Login ..................."
	 oc login https://isvconsole02.netmagicsolutions.com:8443   -u=ocpadmin 	 
	 eval "oc project $PROJECT_NAME"
        eval " oc projects"
}
  

 # Call function to set PROJECT_NAME
 setProjectSpecificDetail
 
while true
do
 #clear 
 echo "============================="
 echo "Bindings menu"
 echo "============================="
 echo "1 to deploy zookeeper : " 
 echo "2 to deploy git-service : " 
 echo "3 to deploy kafka : " 
 echo "4 to deploy redis : " 
 echo "5 to deploy elasticsearch : " 
 echo "6 to deploy rabbitmq : " 
 echo "q to exit the menu : " 
 
 
 echo -e "\n"
 echo -e "Enter your selection \c" 
 read answers
  
 case "$answers" in
1)eval "oc new-app -f ${BASE_FOLDER_PATH}/${appName}/zookeeper-service-bindings.yaml --param PROJECT_NAME=$PROJECT_NAME --param ZOOKEEPER_PORT=$ZOOKEEPER_PORT --param ZOOKEEPER_HOST=$ZOOKEEPER_HOST" ;; 
2)eval "oc new-app -f ${BASE_FOLDER_PATH}/${appName}/git-service-bindings.yaml --param PROJECT_NAME=$PROJECT_NAME --param GIT_USERNAME=$GIT_USERNAME --param GIT_PASSWORD=$GIT_PASSWORD --param GIT_PORT=$GIT_PORT --param GIT_HOST=$GIT_HOST --param GIT_PROTOCOL=$GIT_PROTOCOL --param GIT_OPTIONS=$GIT_OPTIONS " ;; 
3)eval "oc new-app -f ${BASE_FOLDER_PATH}/${appName}/kafka-service-bindings.yaml --param PROJECT_NAME=$PROJECT_NAME --param KAFKA_PORT=$KAFKA_PORT --param KAFKA_HOST=$KAFKA_HOST --param KAFKA_PROTOCOL=$KAFKA_PROTOCOL" ;; 
4)eval "oc new-app -f ${BASE_FOLDER_PATH}/${appName}/redis-service-bindings.yaml --param PROJECT_NAME=$PROJECT_NAME --param REDIS_PASSWORD=$REDIS_PASSWORD --param REDIS_PORT=$REDIS_PORT --param REDIS_HOST=$REDIS_HOST --param REDIS_PROTOCOL=$REDIS_PROTOCOL" ;; 
5)eval "oc new-app -f ${BASE_FOLDER_PATH}/${appName}/elasticsearch-service-bindings.yaml --param PROJECT_NAME=$PROJECT_NAME --param ELASTICSEARCH_PORT=$ELASTICSEARCH_PORT --param ELASTICSEARCH_HOST=$ELASTICSEARCH_HOST --param ELASTICSEARCH_PROTOCOL=$ELASTICSEARCH_PROTOCOL --param ELASTICSEARCH_OPTIONS=$ELASTICSEARCH_OPTIONS" ;; 
6)eval "oc new-app -f ${BASE_FOLDER_PATH}/${appName}/rabbitmq-service-bindings.yaml --param PROJECT_NAME=$PROJECT_NAME --param RABBITMQ_USERNAME=$RABBITMQ_USERNAME --param RABBITMQ_PASSWORD=$RABBITMQ_PASSWORD --param RABBITMQ_PORT=$RABBITMQ_PORT --param RABBITMQ_HOST=$RABBITMQ_HOST --param RABBITMQ_PROTOCOL=$RABBITMQ_PROTOCOL --param RABBITMQ_OPTIONS=$RABBITMQ_OPTIONS" ;; 
q)exit ;; 
*) echo "invalid option $REPLY" ;;

esac

read input

done


 
 
