#Variables
RESOURCE_GROUP="AKS-DevOps-Demos"
LOCATION="northeurope"
ACR_NAME="returngis"
AKS_NAME="returngis"

#We need to login with our Azure account
az login

#We need a resource group
az group create -l $LOCATION -n $RESOURCE_GROUP

#We have to create an Azure Container Registry
az acr create -g $RESOURCE_GROUP -n $ACR_NAME --sku Standard

az acr list -g $RESOURCE_GROUP --query "[].{acrLoginServer:loginServer}" --output table

#Create an AKS
az aks create -g $RESOURCE_GROUP \
-n $AKS_NAME \
--node-count 1

#Get AKS context
az aks get-credentials --resource-group $RESOURCE_GROUP --name $AKS_NAME

kubectl get nodes