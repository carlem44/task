#!/bin/bash
set -e -u

project_id="$1"
deploy_environment="$2"
tag="gcr.io/${project_id}/docker-helloworld:${deploy_environment}.v${BUILD_NUMBER}"

sudo gcloud docker push "$tag"

kubectl patch deployment docker-helloworld \
  --namespace=pastely-"${deploy_environment}" \
  -p \
  '{"spec":{"template":{"spec":{"containers":[{"name":"docker-helloworld","image":'"\"${tag}\""'}]}}}}'
