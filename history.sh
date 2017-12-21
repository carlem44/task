# Add the Cloud SDK distribution URI as a package source\
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list\

# Import the Google Cloud Platform public key\
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -\

# Update the package list and install the Cloud SDK\
sudo apt-get update && sudo apt-get install google-cloud-sdk

gcloud components install kubectl
sudo apt-get install kubectl

gcloud container clusters get-credentials cluster-1 --zone us-central1-a --project kubernetes-54610
kubectl proxy

gcloud auth login

gcloud components install kubectl
sudo apt-get install kubectl

#zadnie start
mkdir zadanie
cd zadanie
#download repo Dockerimage
git clone https://github.com/drhelius/docker-helloworld-python-microservice.git
cd docker-helloworld-python-microservice
#set G-cloud config
gcloud config set project kubernetes-54610
gcloud config set compute/zone us-central1-a
export PROJECT_ID="$(gcloud config get-value project -q)"
echo $PROJECT_ID

sudo docker build -t gcr.io/${PROJECT_ID}/hello-app:v1 .
sudo docker images
#send to google repo
sudo gcloud docker -- push gcr.io/${PROJECT_ID}/hello-app:v1
#run locally for testing image
sudo docker run --rm -p 8080:8080 gcr.io/${PROJECT_ID}/hello-app:v1
#create kubernetes cluster "hello-cluster" with 3 nodes
gcloud container clusters create hello-cluster --num-nodes=3
gcloud compute instances list
#login to cluster
gcloud container clusters get-credentials hello-cluster
#run helloworld from google repo
kubectl run hello-web --image=gcr.io/${PROJECT_ID}/hello-app:v1 --port 8080
kubectl get pods
#run LoadBalancer with gate to internet
kubectl expose deployment hello-web --type=LoadBalancer --port 80 --target-port 8080
kubectl get pods

kubectl get service
#run in scale
kubectl scale deployment hello-web --replicas=3
kubectl get pods
#check listo of deployment app "hello-app"
kubectl get deployment hello-web
kubectl get pods
#Deploy changes in app
vim hello.py
#rebuild v2
sudo docker build -t gcr.io/${PROJECT_ID}/hello-app:v2 .
# push to repo
sudo gcloud docker -- push gcr.io/${PROJECT_ID}/hello-app:v2
#Deploy v2
kubectl set image deployment/hello-web hello-web=gcr.io/${PROJECT_ID}/hello-app:v2
# clean-up
kubectl delete service hello-web
gcloud compute forwarding-rules list
gcloud container clusters delete hello-cluster
