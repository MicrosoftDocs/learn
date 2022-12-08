In this unit, you'll configure your Quarkus application to be deployed through Maven. Then you'll create and deploy to an Azure Container Apps instance.


## Containerize the Quarkus application 

Rename `Dockerfile.jvm` to `Dockerfile` and move it to the root folder.
This image is a native image that is optimized for running in a container. 

```bash
mv src/main/docker/Dockerfile.jvm ./Dockerfile
```


```dockerfile
FROM registry.access.redhat.com/ubi8/openjdk-11:1.14

ENV LANGUAGE='en_US:en'


# We make four distinct layers so if there are application changes the library layers can be re-used
COPY --chown=185 target/quarkus-app/lib/ /deployments/lib/
COPY --chown=185 target/quarkus-app/*.jar /deployments/
COPY --chown=185 target/quarkus-app/app/ /deployments/app/
COPY --chown=185 target/quarkus-app/quarkus/ /deployments/quarkus/

EXPOSE 8080
USER 185
ENV AB_JOLOKIA_OFF=""
ENV JAVA_OPTS="-Dquarkus.http.host=0.0.0.0 -Djava.util.logging.manager=org.jboss.logmanager.LogManager"
ENV JAVA_APP_JAR="/deployments/quarkus-run.jar"
```

## Deploy the container to Azure Container App


```bash
az containerapp up \
    --name "$AZ_CONTAINERAPP" \
    --environment "$AZ_CONTAINERAPP_ENV" \
    --location "$AZ_LOCATION" \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --ingress external \
    --source src/main/docker/
```

```bash
Using resource group 'rg-azure-deploy-quarkus'
Creating ContainerAppEnvironment 'cae-azure-deploy-quarkus' in resource group rg-azure-deploy-quarkus
No Log Analytics workspace provided.
Generating a Log Analytics workspace with name "workspace-rgazuredeployquarkusEED7"
Creating Azure Container Registry ca001ad52ae7acr in resource group rg-azure-deploy-quarkus

Run ID: ca3 was successful after 41s
Creating Containerapp ca-azure-deploy-quarkus in resource group rg-azure-deploy-quarkus
Adding registry password as a secret with name "ca001ad52ae7acrazurecrio-ca001ad52ae7acr"

Your container app ca-azure-deploy-quarkus has been created and deployed! Congrats! 
```

## Check the deployment

![Screenshot showing the deployed application.](../media/azure-portal.png)


Stream logs for your container with: az containerapp logs show -n ca-azure-deploy-quarkus -g rg-azure-deploy-quarkus

See full output using: az containerapp show -n ca-azure-deploy-quarkus -g rg-azure-deploy-quarkus --query "properties.configuration.ingress.fqdn"


## Execute the Azure Container Apps application

When the deployment finishes, your application is ready at `http://<appName>.azurewebsites.net/`. 

To test the application, you can use `cURL`.

As you redeployed your application, you cleared the database. Now you need to create a new to-do item in the database:

```bash
curl --header "Content-Type: application/json" \
    --request POST \
    --data '{"description":"configuration","details":"congratulations, you have set up your Quarkus application correctly!","done": "true"}' \
    http://<appName>.azurewebsites.net
```

This command should return the created item:

```json
{"id":1,"description":"configuration","details":"congratulations, you have set up your Quarkus application correctly!","done":true}
```

Retrieve the data by using a new `cURL` request:

```bash
curl http://<appName>.azurewebsites.net
```

This command returns the list of to-do items, including the item you created:

```json
[{"id":1,"description":"configuration","details":"congratulations, you have set up your Quarkus application correctly!","done":true}]
```

> [!NOTE]
> You can also open the URL in a web browser to return the list of to-do items.
