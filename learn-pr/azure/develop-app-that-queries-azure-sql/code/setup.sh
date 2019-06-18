ID=$RANDOM
GIT_USERNAME=gitName$ID
GIT_PASSWORD=Pa55w.rd

dotnet build
 
az webapp deployment user set --user-name $GIT_USERNAME --password $GIT_PASSWORD

az appservice plan create --name educationAppServicePlan$ID --resource-group sqlrg --sku B1 --is-linux

az webapp create --resource-group sqlrg --plan educationAppServicePlan$ID --name educationapp-$ID --runtime "DOTNETCORE|2.1" --deployment-local-git

git remote add azure https://$GIT_USERNAME@educationapp-$ID.scm.azurewebsites.net/educationapp-$ID.git

git push https://$GIT_USERNAME:$GIT_PASSWORD@educationapp-$ID.scm.azurewebsites.net/educationapp-$ID.git

echo "Web app deployed to https://educationapp-$ID.azurewebsites.net/"