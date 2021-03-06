#!/bin/bash


if [ "$1" != "" ]; then
	TAG=$1
else
	TAG="latest"
fi
######################################

echo "1. Database..."
docker run -d -p 5432:5432 --name aos_postgres \
--hostname aosdb.aos.com --net demo-net admpresales/aos-postgres:$TAG
######################################

echo "2. Account Service..."
#docker run -p 8001:8080 --name aos_accountservice --hostname aosaccount.aos.com \
#-e "POSTGRES_PORT=5432" -e "POSTGRES_IP=aos_postgres" -e "MAIN_PORT=8000" \
#-e "ACCOUNT_PORT=8001" -e 'MAIN_IP=nimbusserver.aos.com' -e "ACCOUNT_IP=nimbusserver.aos.com" \
#-e "PGPASSWORD=admin" --net demo-net -d admpresales/aos-accountservice:$TAG

# 7/6/18
docker run -p 8001:8080 --name aos_accountservice --hostname aosaccount.aos.com \
-e "POSTGRES_PORT=5432" -e "POSTGRES_IP=nimbusserver.aos.com" -e "MAIN_PORT=8000" \
-e "ACCOUNT_PORT=8001" -e 'MAIN_IP=nimbusserver.aos.com' -e "ACCOUNT_IP=nimbusserver.aos.com" \
-e "PGPASSWORD=admin" -e "AGENT_NAME=aos-accountservice-dev" --add-host nimbusserver.aos.com:172.50.0.1 \
--net demo-net -d admpresales/aos-accountservice:$TAG
######################################

echo "3. Main Application..."
#docker run -p 8000:8080 --name aos_main --hostname aosweb.aos.com \
#-e "POSTGRES_PORT=5432" -e "POSTGRES_IP=aos_postgres" -e "MAIN_PORT=8000" \
#-e "ACCOUNT_PORT=8001" -e "MAIN_IP=nimbusserver.aos.com" -e "ACCOUNT_IP=nimbusserver.aos.com" \
#-e "PGPASSWORD=admin" -e "http_proxy=${http_proxy}" -e "https_proxy=${https_proxy}" \
#--add-host nimbusserver:172.50.0.1 --add-host nimbusserver.aos.com:172.50.0.1 \
#--net demo-net -d admpresales/aos-main-app:$TAG

# 7/6/18
docker run -p 8000:8080 --name aos_main --hostname aosweb.aos.com \
-e "POSTGRES_PORT=5432" -e "POSTGRES_IP=nimbusserver.aos.com" -e "MAIN_PORT=8000" \
-e "ACCOUNT_PORT=8001" -e "MAIN_IP=nimbusserver.aos.com" -e "ACCOUNT_IP=nimbusserver.aos.com" \
-e "PGPASSWORD=admin" -e "AGENT_NAME=aos-main-dev" --add-host nimbusserver:172.50.0.1 \
--add-host nimbusserver.aos.com:172.50.0.1 --net demo-net -d admpresales/aos-main-app:$TAG

# 7/6/18 (for QA)
#docker run -p 8400:8080 --name aos_main_qa --hostname aosweb.aos.com \
#-e "POSTGRES_PORT=8432" -e "POSTGRES_IP=nimbusserver.aos.com" -e "MAIN_PORT=8400" \
#-e "ACCOUNT_PORT=8401" -e "MAIN_IP=nimbusserver.aos.com" -e "ACCOUNT_IP=nimbusserver.aos.com" \
#-e "PGPASSWORD=admin" -e "AGENT_NAME=aos-main-qa" --add-host nimbusserver:172.50.0.1 \
#--add-host nimbusserver.aos.com:172.50.0.1 --net demo-net -d admpresales/aos-main-app:TAG
