#Variables
RESOURCE_GROUP="AKS-DevOps-Demos"
ACR_NAME="returngis"


#List container images
az acr repository list -n $ACR_NAME -o table