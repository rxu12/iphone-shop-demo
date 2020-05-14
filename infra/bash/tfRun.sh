# az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID
export ARM_CLIENT_ID=$AZURE_CLIENT_ID
export ARM_CLIENT_SECRET=$AZURE_CLIENT_SECRET
export ARM_SUBSCRIPTION_ID=$AZURE_SUBSCRIPTION_ID
export ARM_TENANT_ID=$AZURE_TENANT_ID

cd ./azurerm/$1
terraform init -input=false -upgrade
terrafrom plan
terraform apply -input=false -auto-approve