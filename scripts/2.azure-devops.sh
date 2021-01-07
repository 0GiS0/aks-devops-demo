#Variables
RESOURCE_GROUP="AKS-DevOps-Demos"
LOCATION="northeurope"
ACR_NAME="returngis"
AKS_NAME="returngis"

#To create the service connection on Azure DevOps
kubectl config get-contexts
cat ~/.kube/config
pbcopy < ~/.kube/config

#Attach ACR to my existing AKS
az aks update -n $AKS_NAME -g $RESOURCE_GROUP --attach-acr $ACR_NAME

#Get pods
kubectl get pod

#Get service
kubectl get svc
