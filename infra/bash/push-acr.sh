az login --service-principal --username $AZURE_CLIENT_ID --password $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID
az acr login --name iphonesearch_acr
docker-compose --project-name iphone-search -f ../docker-compose/app.yaml push