In this unit, you create the Azure Container Apps environment by using the Azure CLI.

## Set up the Dockerfile for the Quarkus application

Container Apps is used to deploy containerized applications. So you first need to containerize the Quarkus application into a Docker image. This process is easy because the Quarkus Maven plugin has already generated some Dockerfiles under `src/main/docker`.

Use this command to rename one of these Dockerfiles, *Dockerfile.jvm*, to *Dockerfile* and move it to the root folder:

```bash
mv src/main/docker/Dockerfile.jvm ./Dockerfile
```

Replace the content after the long comment in the Dockerfile with the following:

```dockerfile
FROM registry.access.redhat.com/ubi8/openjdk-17:1.18

ENV LANGUAGE='en_US:en'


# We make four distinct layers so if there are application changes the library layers can be re-used
COPY --chown=185 target/quarkus-app/lib/ /deployments/lib/
COPY --chown=185 target/quarkus-app/*.jar /deployments/
COPY --chown=185 target/quarkus-app/app/ /deployments/app/
COPY --chown=185 target/quarkus-app/quarkus/ /deployments/quarkus/

EXPOSE 8080
USER 185
ENV JAVA_OPTS_APPEND="-Dquarkus.http.host=0.0.0.0 -Djava.util.logging.manager=org.jboss.logmanager.LogManager"
ENV JAVA_APP_JAR="/deployments/quarkus-run.jar"

ENTRYPOINT [ "/opt/jboss/container/java/run/run-java.sh" ]
```

This Dockerfile expects the Quarkus application to be packaged as a *quarkus-run.jar* file. This name is the default name for the Quarkus application when it's packaged as a JAR file. You need to make sure that the Quarkus application is packaged as a JAR file. To do so, run the following Maven command:

```bash
./mvnw package    # On Mac or Linux
mvnw.cmd package  # On Windows
```

This command packages the Quarkus application into a JAR file and generates a *quarkus-run.jar* file in the *target/quarkus-app* folder.

## Create the Container Apps environment and deploy the container

Now that the Dockerfile is in the right location, you can create the Container Apps environment and deploy the container by using a single Azure CLI command. Run the following command at the root of the project:

```bash
az containerapp up \
    --name "$AZ_CONTAINERAPP" \
    --environment "$AZ_CONTAINERAPP_ENV" \
    --location "$AZ_LOCATION" \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --ingress external \
    --target-port 8080 \
    --source .
```

This command does several things:

* Creates a Container Apps environment if it doesn't exist
* Creates an Azure registry if it doesn't exist
* Creates a Log Analytics workspace if it doesn't exist
* Builds the Docker image and pushes it to the Azure registry
* Deploys the Docker image to the Container Apps environment

The `az containerapp up` command takes some time to run. You should see output that's similar to the following:

```bash
Using resource group 'rgazure-deploy-quarkus'
Creating ContainerAppEnvironment 'caeazure-deploy-quarkus' in resource group rgazure-deploy-quarkus
No Log Analytics workspace provided.
Generating a Log Analytics workspace with name "workspace-rgazuredeployquarkusEED7"
Creating Azure Container Registry ca001ad52ae7acr in resource group rgazure-deploy-quarkus

Run ID: ca3 was successful after 41s
Creating Containerapp caazure-deploy-quarkus in resource group rgazure-deploy-quarkus
Adding registry password as a secret with name "ca001ad52ae7acrazurecrio-ca001nxc57acr"

Your container app caazure-deploy-quarkus has been created and deployed! Congrats! 
```

## Validate the deployment

You can validate that the deployment has succeeded in several ways. The easiest way is to search for your resource group on the [Azure portal](https://portal.azure.com). You should see resources similar to the following:

![Screenshot that shows the deployed application.](../media/azure-portal.png)

You can also check the deployment by running the following command. It lists all the resources created by the `az containerapp up` command.

```bash
az resource list \
    --location "$AZ_LOCATION" \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --output table
```

You should see output that's similar to this:

```bash
Name                                ResourceGroup           Location    Type                                       Status
----------------------------------  ----------------------  ----------  -----------------------------------------  --------
caea3a6e0afeacr                     rgazure-deploy-quarkus  eastus      Microsoft.ContainerRegistry/registries
psqlazure-deploy-quarkus            rgazure-deploy-quarkus  eastus      Microsoft.DBforPostgreSQL/flexibleServers
caazure-deploy-quarkus              rgazure-deploy-quarkus  eastus      Microsoft.App/containerApps
caeazure-deploy-quarkus             rgazure-deploy-quarkus  eastus      Microsoft.App/managedEnvironments
workspace-rgazuredeployquarkuscDD3  rgazure-deploy-quarkus  eastus      Microsoft.OperationalInsights/workspaces
```

## Run the deployed Quarkus application

You can now run the deployed Quarkus application. First, you need to get the URL of the application. You can get it by running the following command:

```bash
export AZ_APP_URL=$(
    az containerapp show \
        --name "$AZ_CONTAINERAPP" \
        --resource-group "$AZ_RESOURCE_GROUP" \
        --query "properties.configuration.ingress.fqdn" \
        --output tsv \
)

echo "AZ_APP_URL=$AZ_APP_URL"
```

Your application is ready at `https://<app-name>.azurecontainerapps.io/`. Notice the `https` protocol. That protocol is used because the application is deployed with a TLS certificate. To test the application, you can use cURL:

```bash
curl --header "Content-Type: application/json" \
    --request POST \
    --data '{"description":"Configuration","details":"Congratulations, you have set up your Quarkus application correctly!","done": "true"}' \
    https://$AZ_APP_URL/api/todos
```

Retrieve the data by using a new cURL request:

```bash
curl https://$AZ_APP_URL/api/todos
```

This command returns the list of all to-do items from the database:

```json
[
   {
      "description" : "Take Quarkus MS Learn",
      "details" : "Take the MS Learn on deploying Quarkus to Azure Container Apps",
      "done" : true,
      "id" : 1
   },
   {
      "description" : "Take Azure Container MS Learn",
      "details" : "Take the ACA Learn module",
      "done" : false,
      "id" : 2
   },
   {
      "description" : "Configuration",
      "details" : "Congratulations, you have set up your Quarkus application correctly!",
      "done" : true,
      "id" : 3
   }
]
```

If you run this command, you can stream the logs for your container when you create new to-dos:

```bash
az containerapp logs show \
    --name "$AZ_CONTAINERAPP" \
    --resource-group "$AZ_RESOURCE_GROUP" \
    --follow
```

Run more cURL commands. You should see the logs scrolling in the terminal.

```bash
curl https://$AZ_APP_URL/api/todos
```

> [!NOTE]
> You can also open the URL in a web browser to return the list of to-do items.
