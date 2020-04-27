eval $(aws ecr get-login-password --no-include-email --region ap-southeast-2 | sed 's|https://||')
docker-compose --project-name iphone-search -f ../docker-compose/app.yaml push