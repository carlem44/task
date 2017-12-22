#!/bin/bash
set -e -u
# ------- clean-up
cluster_name="hello-cluster"
service_name="hello-web"

kubectl delete service ${service_name}

#gcloud compute forwarding-rules list
#WAIT 30sec
sleep 30

gcloud container clusters delete ${cluster_name}
