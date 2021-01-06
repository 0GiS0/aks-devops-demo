#Variables
SUBSCRIPTION_ID=ca0cd4ab-5601-489a-9e4b-53db45be5503
RESOURCE_GROUP="AKS-DevOps-Demos"

#Create a service principal
az ad sp create-for-rbac --name "aks-devops-demo" --role contributor --scopes /subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP --sdk-auth

