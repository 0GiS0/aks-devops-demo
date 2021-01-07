#Variables
RESOURCE_GROUP="AKS-DevOps-Demos"
AKS_NAME="aks-of-runners"
LOCATION="northeurope"

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

#Install cert-manager
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.1.0/cert-manager.yaml

#Install the custom resource and actions-runner-controller itself
kubectl apply -f https://github.com/summerwind/actions-runner-controller/releases/latest/download/actions-runner-controller.yaml

#Setting up authentication with GitHub API
# There are two ways for actions-runner-controller to authenticate with the GitHub API:

    # Using GitHub App.
    # Using Personal Access Token.

# Regardless of which authentication method you use, the same permissions are required, those permissions are:

    # Repository: Administration (read/write)
    # Repository: Actions (read)
    # Organization: Self-hosted runners (read/write)

# NOTE: It is extremely important to only follow one of the sections below and not both.
kubectl get ns #you'll see actions-runner-system
kubectl get po -n actions-runner-system #controller-manager 

#Use this link to create the GitHub App with the right permissions
https://github.com/settings/apps/new?url=http://github.com/summerwind/actions-runner-controller&webhook_active=false&public=false&administration=write&actions=read

#App ID: 95311
#Installation ID: 175379
APP_ID=95311
INSTALLATION_ID=175379
PRIVATE_KEY_FILE_PATH=/Users/gis/Downloads/aks-of-runners.2021-01-07.private-key.pem

#Register the App ID (APP_ID), Installation ID (INSTALLATION_ID), and downloaded private key file (PRIVATE_KEY_FILE_PATH) to Kubernetes as Secret.
# kubectl create secret generic controller-manager \
#     -n actions-runner-system \
#     --from-literal=github_app_id=${APP_ID} \
#     --from-literal=github_app_installation_id=${INSTALLATION_ID} \
#     --from-file=github_app_private_key=${PRIVATE_KEY_FILE_PATH}

#This works
kubectl create secret generic controller-manager \
-n actions-runner-system \
--from-literal=github_token=f20ae2ca8da5c0572cea5b085751c290dd947ede


kubectl get deploy -n actions-runner-system

#Create a new runner
kubectl apply -f k8s/runner.yml

#Check your runners
kubectl get runners

kubectl describe runners example-runner

#Check if your runner is registered in your repository