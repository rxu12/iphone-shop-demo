echo "My client id is $AZURE_CLIENT_ID"
echo "My client secret is $AZURE_CLIENT_SECRET"
echo "My tenant id is $AZURE_TENANT_ID"
echo "My subscription id is $AZURE_SUBSCRIPTION_ID"
az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID
cd ./azurerm
terraform init -upgrade
terraform apply