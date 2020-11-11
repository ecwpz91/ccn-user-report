#!/bin/bash 


if [ ! -f ./bin ]; then 
  mkdir -p ./bin 
  echo "Downloading oc cli for application"
  curl -OL https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz
  tar -zxvf openshift-client-linux.tar.gz --directory ./bin 
  chmod +x ./bin/oc
  chmod +x ./bin/kubectl
  rm -rf openshift-client-linux.tar.gz
  echo "Downloading tkn cli for pipelines"
  curl -L https://github.com/tektoncd/cli/releases/download/v0.13.1/tkn_0.13.1_Linux_x86_64.tar.gz \
  | tar -xvzf - -C "./bin" tkn &>/dev/null
fi



echo "Building code in $(pwd) with docker"
docker build -t ccn-user-report:$TAG -f scripts/Dockerfile .

rm -rf ./bin
