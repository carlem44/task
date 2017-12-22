#!/bin/bash
set -e -u

project_id="$1"
deploy_environment="$2"
git_sha1="$3"
tag="gcr.io/${project_id}/docker-helloworld:${git_sha1}.${deploy_environment}.v${BUILD_NUMBER}"

cd docker-helloworld-python-microservice

sudo docker build \
    --build-arg=deploy_environment="$deploy_environment" \
    --build-arg=git_sha1="$git_sha1" \
    -t "$tag" .
