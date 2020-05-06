chmod -R +x ./azurerm
az login --service-principal -u $CLIENT_ID -p $CLIENT_SECRET -t $TENANT_ID
cd ./azurerm
terraform init -upgrade
terraform apply