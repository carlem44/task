#!/bin/bash
set -e -u

project_id="$1"
deploy_environment="$2"
git_sha1="$3"
cluster_name="hello-cluster"
tag="gcr.io/${project_id}/docker-helloworld:${git_sha1}.${deploy_environment}.v${BUILD_NUMBER}"

#create kubernetes cluster "hello-cluster" with 3 nodes
gcloud container clusters create ${cluster_name} --num-nodes=3
#login to cluster
gcloud container clusters get-credentials ${cluster_name}
#run helloworld from google repo
kubectl run hello-web --image=$tag --port 8080

#run LoadBalancer with gate to internet
kubectl expose deployment hello-web --type=LoadBalancer --port 80 --target-port 8080
#run in scale
kubectl scale deployment hello-web --replicas=3
