In this unit, we deploy our Spring AI application to Azure Container Apps for scalable and serverless container hosting.

## Set up environment variables

For this exercise, we need to some environment variables from prior exercises.

1. Confirm these variables are available:

   ```bash
   export RESOURCE_GROUP=spring-ai-postgresql-rg
   export LOCATION=eastus2
   echo "RESOURCE_GROUP: $RESOURCE_GROUP LOCATION: $LOCATION"
   ```

1. Confirm OpenAI Key and Endpoint variables from prior exercise are available:

   ```bash
   echo "Azure OpenAI Endpoint: $AZURE_OPENAI_ENDPOINT, key: $AZURE_OPENAI_API_KEY"
   ```

1. Confirm `DB_SERVER_NAME` and `PGHOST` variable from prior exercise is available:

   ```bash
   echo "DB_SERVER_NAME: $DB_SERVER_NAME PGHOST: $PGHOST"
   ```

1. Export a name for the new container app:

   ```bash
   export CONTAINER_APP_NAME=rag-api
   ```

1. Export the name to use as the Managed Identity for the Azure Container App:

```azurecli
export MANAGED_IDENTITY_NAME=containerappusr
```

With these environment values in place, you're now ready to deploy the application into Azure Container Apps.

## Create a Dockerfile

Next we create a `Dockerfile` that is used to build a docker image with the application code to be used to deploy to Azure Container Apps:

```txt
# Step 1: Use microsoft JDK image with maven3 to build the application
FROM mcr.microsoft.com/openjdk/jdk:17-mariner AS builder
RUN tdnf install maven3 -y
WORKDIR /app
COPY pom.xml ./
COPY src ./src
RUN mvn clean package -DskipTests

# Step 2: Use microsoft JDK image for the final image
FROM mcr.microsoft.com/openjdk/jdk:17-mariner
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
```

## Deploy Azure Container Application

To deploy the application, use the following command:

```bash
az containerapp up --name $CONTAINER_APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --environment $ENVIRONMENT \
  --source . \
  --ingress external \
  --target-port 8080 \
  --location $LOCATION
```

This command will:

* Create the resource group, it not created already.
* Create the Container Apps environment named `$ENVIRONMENT` with a Log Analytics workspace
* Create an Azure Container Registry
* Build the container image using the source code and `Dockerfile` specified in `--source` path, and push it to the registry
* Create and deploy the container app named `$CONTAINER_APP_NAME` using the built container image
* Configure `8080` as the HTTP port that the container app listens for incoming traffic
* Deploy the container app in the region specified in the `--location` parameter

To view the logs of your Azure Container App, use the following command:

```azurecli
az containerapp logs show \
    --resource-group $RESOURCE_GROUP \
    --name $CONTAINER_APP_NAME \
    --tail 80
```

Inspect the logs and notice that the application isn't starting successfully due to missing configuration values as expected:

```json
{"TimeStamp": "2025-03-04T19:04:52.7673831+00:00", "Log": "F Caused by: org.postgresql.util.PSQLException: 
FATAL: Azure AD user token for role[AzureAdmin] is neither an AAD_AUTH_TOKENTYPE_APP_USER or an 
AAD_AUTH_TOKENTYPE_APP_OBO token."}
```

To redeploy the application after making changes, you can use the following command:

```azurecli
az containerapp update \
    --resource-group $RESOURCE_GROUP \
    --name $CONTAINER_APP_NAME \
    --source .
```

## Enable managed identity

The Container App needs to be able to authenticate to PostgresSQL server. We use System Assigned Managed Identities for authentication.

To enable system-assigned managed identity for your Azure Container App, use this command:

```azurecli
az containerapp identity assign \
    --resource-group $RESOURCE_GROUP \
    --name $CONTAINER_APP_NAME \
    --system-assigned
```

To get the ID of the system assigned managed identity, use the following command:

```azurecli
export MANAGED_IDENTITY_ID=$(az containerapp show \
    --resource-group $RESOURCE_GROUP \
    --name $CONTAINER_APP_NAME \
    --query 'identity.principalId' \
    --output tsv \
    | tr -d '\r')
echo "Managed Identity ID: $MANAGED_IDENTITY_ID"
```

To authorize the managed identity of your Azure Container App to access the PostgreSQL Flexible Server instance, use the following command:

```azurecli
az postgres flexible-server ad-admin create \
    --resource-group $RESOURCE_GROUP \
    --server-name $DB_SERVER_NAME \
    --display-name $MANAGED_IDENTITY_NAME \
    --object-id $MANAGED_IDENTITY_ID \
    --type ServicePrincipal
```

## Azure Container App Environment and Secret Configuration

Create a secret for sensitive values:

```bash
az containerapp secret set \
    --resource-group $RESOURCE_GROUP \
    --name $CONTAINER_APP_NAME \
    --secrets \
      azure-openai-api-key=$AZURE_OPENAI_API_KEY
```

Next set environment variables:

```azurecli
az containerapp update \
    --resource-group $RESOURCE_GROUP \
    --name $CONTAINER_APP_NAME \
    --set-env-vars \
      SPRING_AI_AZURE_OPENAI_API_KEY=secretref:azure-openai-api-key \
      SPRING_AI_AZURE_OPENAI_ENDPOINT=${AZURE_OPENAI_ENDPOINT} \
      SPRING_DATASOURCE_USERNAME=${MANAGED_IDENTITY_NAME} \
      SPRING_DATASOURCE_URL=jdbc:postgresql://${PGHOST}/postgres?sslmode=require \
      SPRING_AI_VECTORSTORE_PGVECTOR_SCHEMA_NAME=containerapp
```

We intentionally use a different `pgvector` schema name to avoid conflicts from using the same schema name with a different user.

## Verify the deployment

Get Container App URL:

```azurecli
export URL=$(az containerapp show \
    --name $CONTAINER_APP_NAME \
    --resource-group $RESOURCE_GROUP \
    --query properties.configuration.ingress.fqdn \
    --output tsv)
```

Test Endpoint:

```bash
curl -G "https://$URL/api/rag" --data-urlencode "query=How does QuestionAnswerAdvisor work in Spring AI?"
```

Expect to see a valid response:

```markdown
In the context of **Spring AI**, the **QuestionAnswerAdvisor** operates as a key component for enabling **Retrieval Augmented Generation (RAG)**, which combines user queries with external contextual data to produce accurate and relevant AI responses.
```

Try another question that isn't in our vector store:

```bash
curl -G "https://$URL/api/rag" --data-urlencode "query=What is Vector Search Similarity?"
```

Expect to see a similar valid response:

```markdown
**Vector Search Similarity** refers to the process of comparing and ranking data points (represented as vectors) based on their similarity in a multi-dimensional space. This method is commonly used in applications like information retrieval, recommendation systems, natural language processing, and computer vision.
```

You can also test the blog generation endpoint using a REST client or `curl`:

```bash
curl -G "https://$URL/api/blog" --data-urlencode "topic=Spring AI Innovation"
```

Because of the review iteration cycle, this request will take longer to complete. Once it completes, expect to see a blog entry similar to this excerpt:

```markdown
# Spring AI Innovation: Embracing the Season of Transformation

Spring is a season synonymous with growth, renewal, and fresh beginnings. As nature awakens from its winter slumber, so too does the world of technology. In recent years, artificial intelligence (AI) has followed a similar pattern of blossoming innovation, with spring heralding exciting breakthroughs and applications. From revolutionizing industries to improving our everyday lives, AI is in full bloom, and its potential seems as boundless as the season itself.

In this blog post, we’ll explore the latest AI innovations that are flourishing this spring, highlight real-world examples of their impact, and discuss how they’re reshaping the future. Whether you’re an AI enthusiast, a tech professional, or simply curious about the role of AI in our lives, this is your guide to the season’s most exciting developments.
```

## Scaling Azure Container Apps

By default, your Azure Container App is configured to use zero minimum replicas and an HTTP scaling rule to handle 10 requests per replica. You can configure the scaling configuration using the `az containerapp update` command:

```azurecli
az containerapp update \
    --resource-group $RESOURCE_GROUP \
    --name $CONTAINER_APP_NAME \
    --min-replicas 1 \
    --max-replicas 10 \
    --scale-rule-name http-scaler \
    --scale-rule-type http \
    --scale-rule-http-concurrency 15
```

## Cleanup

After you're done testing, use the following commands to remove resources:

```azurecli
az group delete \
    --name $RESOURCE_GROUP \
    --yes --no-wait
```

## Unit summary

In this unit, we successfully deployed a Spring AI application to Azure Container Apps, using scalable and serverless container hosting. We set up necessary environment variables, created a Dockerfile to build the application image, and deployed the container app using Azure CLI commands. We enabled managed identity for secure authentication to the PostgreSQL server and configured secrets and environment variables for the application. Finally, we verified the deployment by testing the application endpoint and learned how to clean up resources after testing.
