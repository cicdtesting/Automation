

#!/bin/bash
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
LBLUE='\033[1;34m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'

source "./Config/mapping.sh"
#source "./common_param.sh"


 setProjectSpecificDetail(){
	 echo "Docker Login ..................."
        docker login docker-registry-default.isvapps02.netmagicsolutions.com -u ocpadmin -p $(oc whoami --show-token)
        oc login https://isvconsole02.netmagicsolutions.com:8443 -u ocpadmin -p Uw5sYygy239NHgs6eHqc

	echo "Please enter password...."
	read password
	token= echo -n '$password' | base64
	echo $token
        if [ $password == 'dev' ] ; then
        	echo $PROJECT_NAME
		eval "oc project $PROJECT_NAME"
        	echo -e "\n${GREEN} You are in $PROJECT_NAME project  ${NC}"
	else
		echo -e  "\n${RED}Existing !!!! Password is mandatory ${NC}"
		exit
	fi
        
 }


  
 PushDockerImage() {
        
	local APP_NAME=$1
        local APP_VER=$2
        local BUILD_ARG=$3
        local BUILD_ARG_NAME=$4
        cd ./App/img
        echo "build args $BUILD_ARG"
	echo "build argnames $BUILD_ARG_NAME"
        eval "docker build  --no-cache  -t $DOCKER_TAG_URL/$PROJECT_NAME/$APP_NAME:$APP_VER  --build-arg $BUILD_ARG=$BUILD_ARG_NAME  ."
	echo -e "\n${CYAN}Pushing  $APP_NAME ${NC}\n"
        eval "docker push $DOCKER_TAG_URL/$PROJECT_NAME/$APP_NAME:$APP_VER"
  } 

setcopyjars()
{


	if [ $input_string == '1' ] ; then
             appname='digital-registry'
	     appVersion=$digital_registry_ver
	 elif [ $input_string == '2' ] ; then
	     appname='digital-config'
	     appVersion=$digital_config_ver
	 elif [ $input_string == '3' ] ; then
	      appname='digital-audit'
	      appVersion=$digital_audit_ver
	 elif [ $input_string == '4' ] ; then
	      appname='digital-alerts'
	      appVersion=$digital_alerts_ver
	 elif [ $input_string == '5' ] ; then
	      appname='digital-approvalwf'
	      appVersion=$digital_approvalwf_ver
         elif [ $input_string == '6' ] ; then
	      appname='digital-conductor'
	      appVersion=$digital_conductor_ver
	 elif [ $input_string == '7' ] ; then
	      appname='digital-gatekeeper'
	      appVersion=$digital_gatekeeper_ver
	 elif [ $input_string == '8' ] ; then
	      appname='digital-limits'
	      appVersion=$digital_limits_ver
	 elif [ $input_string == '9' ] ; then
	      appname='digital-userpref'
	      appVersion=$digital_userpref_ver
	 elif [ $input_string == '10' ] ; then
	      appname='ingestion-users'
	      appVersion=$ingestion_users_ver
	 elif [ $input_string == '11' ] ; then
	      appname='ingestion-roles'
	      appVersion=$ingestion_roles_ver
         elif [ $input_string == '12' ] ; then
	      appname='ingestion-limits'
	      appVersion=$ingestion_limits_ver
	 elif [ $input_string == '13' ] ; then
	      appname='ingestion-approvalwf'
	      appVersion=$ingestion_approvalwf_ver
	 elif [ $input_string == '14' ] ; then
	      appname='ingestion-common-services'
	      appVersion=$ingestion_common_services_ver
	 elif [ $input_string == '15' ] ; then
	      appname='action-userpreferences'
	      appVersion=$action_userpreferences_ver
	 elif [ $input_string == '16' ] ; then
	      appname='action-user-impersonation'
	      appVersion=$action_user_impersonation_ver
	 elif [ $input_string == '17' ] ; then
	      appname='digital-chronos'
	      appVersion=$digital_chronos_ver
	 elif [ $input_string == '18' ] ; then
	      appname='ingestion-filestore'
	      appVersion=$ingestion_filestore_ver
	 elif [ $input_string == '19' ] ; then
	      appname='ingestion-accounts'
	      appVersion=$ingestion_accounts_ver
	 elif [ $input_string == '20' ] ; then
	      appname='ingestion-customers'
	      appVersion=$ingestion_customers_ver
         elif [ $input_string == '21' ] ; then
	      appname='digital-filestore'
	      appVersion=$digital_filestore_ver
         elif [ $input_string == '22' ] ; then
	      appname='action-contacts-standalone'
	      appVersion=$action_contacts_standalone_ver
         elif [ $input_string == '23' ] ; then
	      appname='action-reports-standalone'
	      appVersion=$action_reports_standalone_ver
         elif [ $input_string == '24' ] ; then
	      appname='action-groups-standalone'
	      appVersion=$action_groups_standalone_ver
         elif [ $input_string == '25' ] ; then
	      appname='ingestion-accessprofile'
	      appVersion=$ingestion_accessprofile_ver
	      
         elif [ $input_string == '26' ] ; then
	      appname='ingestion-txn-payments'
	      appVersion=$ingestion_txn_payments_ver
         elif [ $input_string == '27' ] ; then
	      appname='ingestion-paymentinstruction'
	      appVersion=$ingestion_paymentinstruction_ver
	 elif [ $input_string == '28' ] ; then
	      appname='action-payments-standalone'
	      appVersion=$action_payments_standalone_ver
	 elif [ $input_string == '29' ] ; then
	      appname='action-groups'
	      appVersion=$action_groups_ver
         elif [ $input_string == '30' ] ; then
	      appname='digital-workflowinitiator'
	      appVersion=$digital_workflowinitiator_ver
         elif [ $input_string == '31' ] ; then
	      appname='action-contacts-standalone'
	      appVersion=$action_contacts_standalone_ver
         elif [ $input_string == '32' ] ; then
	      appname='ingestion-reportsmetadata'
	      appVersion=$ingestion_reportsmetadata_ver
         elif [ $input_string == '33' ] ; then
	      appname='springboot-es'
	      appVersion=$springboot_es_ver



	 
	 
	      fi
                cd App/jars
		x=$(ls $appname* | wc -l)
                echo $x
		if [ $x -gt 1 ] ; then
		#ls -l $appname* |  awk '{print $9}'
		echo "There are more then one application indise the folder. Please select application name from listing ..."
		ls -l $appname* |  awk '{print $9}'
		read application
              else
		application=$(ls $appname*)		
               fi
		echo "application:-"$application

		#appVersion=$application | awk -F- '{print $NF}'

		appVersion=$(echo $application | awk -F- '{print $NF}')
		#appVersion=$(ls -l $application | awk -F- '{print $NF}'  | tr -d \ .jar)
		echo " appVersion="$appVersion


		jarversion=${appVersion%????}
		echo $jarversion
		
                
		cd ../..
		cp -r ./App/jars/$application ./App/img
                cp -r ./App/artifacts/Dockerfile ./App/img
		cp -r ./App/artifacts/start-service.sh ./App/img
    		cp -r ./App/artifacts/$appname-config.yaml ./App/img/config.yaml
		cp -r ./App/artifacts/$appname-deploy.yaml ./App/img/deploy.yaml
    
    

              
}



setProjectSpecificDetail

echo -e "\n${YELLOW}Select Deploy Application$NC \n"

echo -e "1.digital-registry \n2.digital-config\n3.digital-audit\n4.digital-alerts\n5.digital-approvalwf\n6.digital-conductor\n7.digital-gatekeeper\n8.digital-limits\n9.digital-userpref\n10.ingestion-users\n11.ingestion-roles\n12.ingestion-limits\n13.ingestion-approvalwf\n14.ingestion-common-services\n15.action-userpreferences\n16.action-user-impersonation\n17.digital-chronos\n18.ingestion-filestore\n19.ingestion-accounts\n20.ingestion-customers\n21.digital-filestore\n22.action-contacts-standalone\n23.action-reports-standalone\n24.action-groups-standalone\n25.ingestion-accessprofile\n26.ingestion-txn-payments\n27.ingestion-paymentinstruction\n28.action-payments-standalone\n29.action-groups\n30.digital-workflowinitiator\n31.action-contacts-standalone\n32.ingestion-reportsmetadata\n33.springboot-es"

IFS=";";

read  input_string 


arrIN=($input_string);


echo -e "\n${RED}You have selected following App for Project${NC} ${YELLOW}$PROJECT_NAME${NC}\n"


setcopyjars

PushDockerImage $appname $jarversion "SERVICE_JAR"  "$application"

echo -e "\n${YELLOW}Please select any option(1 or 2 or 3)${NC}"
echo -e "\n${GREEN}1)Do you want to only deploy app?${NC}"
read deployOption

if [[ ${deployOption} == "1" || ${deployOption} == "3" ]]; then

  deployFlag=y;

fi


if [ ${deployOption} == '$PROJECT_NAME' ]; then
      echo "Do you want to deploy app? (y/n)"
      read deployFlag
fi

if [[ ${deployOption} == "1" && ${input_string} == "7"  ]]; then

  deployFlag=7;

fi


if [ $deployFlag == '7' ]; then                   
          eval "oc project $PROJECT_NAME"
          eval "oc delete service ${appname}-service"
          eval "oc delete  deploymentconfig ${appname}"
         # eval "oc delete routes ${appname}"		
	  pwd
	  eval "oc new-app -f  config.yaml  --param PROJECT_NAME=$PROJECT_NAME --param SERVICE_NAME=$appname --param SPRING_CLOUD_CONFIG_NAME=$appname-internal --param EUREKA_CLIENT_REGISTERWITHEUREKA=true"
          eval "oc new-app -f  deploy.yaml  --param PROJECT_NAME=$PROJECT_NAME --param SERVICE_NAME=$appname --param DOCKER_REGISTRY=$DOCKER_REGISTRY/$PROJECT_NAME  --param IMAGE_NAME=$appname --param SERVICE_VERSION=${jarversion}"          


elif [ $deployFlag == 'y' ]; then                   
          eval "oc project $PROJECT_NAME"
          eval "oc delete service ${appname}-service"
          eval "oc delete  deploymentconfig ${appname}"
          eval "oc delete routes ${appname}"		
	  pwd
	  eval "oc new-app -f  config.yaml  --param PROJECT_NAME=$PROJECT_NAME --param SERVICE_NAME=$appname"
	  eval "oc new-app -f  deploy.yaml  --param PROJECT_NAME=$PROJECT_NAME --param SERVICE_NAME=$appname --param DOCKER_REGISTRY=$DOCKER_REGISTRY/$PROJECT_NAME  --param IMAGE_NAME=$appname --param SERVICE_VERSION=${jarversion}"          

        rm -rf *

fi




