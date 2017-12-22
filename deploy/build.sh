#!/bin/bash
set -e -u

project_id="$1"
deploy_environment="$2"
tag="gcr.io/${project_id}/docker-helloworld:${deploy_environment}.v${BUILD_NUMBER}"

cd docker-helloworld-python-microservice

sudo docker build \
    --build-arg=deploy_environment="$deploy_environment" \
    -t "$tag" .
