#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "This script needs run in root mode!"
    exit 1
fi

# update packages
apt update
snap refresh
apt install curl

# setup java, kotlin, gradle, maven

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version

sdk install java
sdk install kotlin
sdk install gradle
sdk install maven

echo "SDKMAN finished install"

apt install git -y

# setup docker and kubectl

snap install docker
snap install kubectl --classic

IMAGES=("public.ecr.aws/docker/library/rabbitmq:3.9"
 "public.ecr.aws/docker/library/mongo:5.0.18"
 "mongo:5.0.18"
 "gvenzl/oracle-xe:latest"
 "testcontainers/ryuk:0.4.0"
 "rabbitmq:3.10-managemen"
 "mysql:latest"
 "mongo:5.0-focal"
 "mongo:latest"
 "postgres:latest"
 "public.ecr.aws/j8b5g5y5/gpa-wiremock:2.34.0-0"
 "testcontainers/ryuk:0.3.4"
 "mongo:4.2.20"
 "openjdk:17"
 "mongo-express:latest"
 "testcontainers/ryuk:0.3.3"
 "testcontainers/ryuk:0.3.1"
 "rabbitmq:3.7-management"
 "testcontainers/ryuk:0.3.0"
 "solr:8.5.1"
 "mongo:3.4"
 "quay.io/testcontainers/ryuk:0.2.3"
 "rabbitmq:3.7.3"
 "quay.io/testcontainers/ryuk:0.2.2"
 "redis:4.0.2")

if ! command -v docker &>/dev/null; then
    echo "Docker não encontrado. Instale o Docker primeiro."
    exit 1
fi

groupadd docker
usermod -aG docker $USER

# setup GCP toolkit
# sudo apt-get update
# sudo apt-get install apt-transport-https ca-certificates gnupg curl sudo

# ubuntu 18.04 +
# curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
# echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# sudo apt-get update && sudo apt-get install google-cloud-cli
# RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && apt-get update -y && apt-get install google-cloud-sdk -y


echo "  ___                     _                  _ "
echo "/'___) _         _       ( )                ( )"
echo "| (__ (_)  ___  (_)  ___ | |__     __     __| |"
echo "| ,__)| |/' _ \`\\| |/',__)|  _ \`\ /\'__\`\ /'_\` |"
echo "| |   | || ( ) || |\__, \| | | |(   ___/( (_| |"
echo "(_)   (_)(_) (_)(_)(____/(_) (_)\`\____)\` \__,_)"
echo "================================================"