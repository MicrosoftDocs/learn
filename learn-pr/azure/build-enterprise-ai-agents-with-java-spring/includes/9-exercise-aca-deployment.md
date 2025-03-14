In this unit, you deploy your Spring AI application to Azure Container Apps for scalable and serverless container hosting.

## Set up environment variables

For this exercise, you need some environment variables from prior exercises. If you're using the same Bash window, these variables should still exist. If the variables are no longer available, use the following commands to recreate them. Be sure to replace the `<...>` placeholders with your own values, and use the same values that you used previously.

```bash
export RESOURCE_GROUP=<resource-group>
export LOCATION=<location>
export OPENAI_RESOURCE_NAME=OpenAISpringAI
export AZURE_OPENAI_ENDPOINT=$(az cognitiveservices account show \
    --resource-group $RESOURCE_GROUP \
    --name $OPENAI_RESOURCE_NAME \
    --query "properties.endpoint" \
    --output tsv \
    | tr -d '\r')
export AZURE_OPENAI_API_KEY=$(az cognitiveservices account keys list \
    --resource-group $RESOURCE_GROUP \
    --name $OPENAI_RESOURCE_NAME \
    --query "key1" \
    --output tsv \
    | tr -d '\r')
export DB_SERVER_NAME=<server-name>
export PGHOST=$(az postgres flexible-server show \
    --resource-group $RESOURCE_GROUP \
    --name $DB_SERVER_NAME \
    --query fullyQualifiedDomainName \
    --output tsv \
    | tr -d '\r')
```




1. Export a name for the new container app:

   ```bash
   export CONTAINER_APP_NAME=<container-app-name>
   ```

1. Export the name to use as the managed identity for the container app:

   ```bash
   export MANAGED_IDENTITY_NAME=<managed-identity-name>
   ```

With these environment values in place, you're now ready to deploy the application into Azure Container Apps.

## Create a Dockerfile

Next, create a **Dockerfile** and add the following contents. This file is used to build a docker image with the application code for deployment to Azure Container Apps.

```dockerfile
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

## Deploy the container application

To deploy the application, use the following command:

```azurecli
az containerapp up \
    --resource-group $RESOURCE_GROUP \
    --name $CONTAINER_APP_NAME \
    --environment $ENVIRONMENT \
    --source . \
    --ingress external \
    --target-port 8080 \
    --location $LOCATION
```

This command does the following tasks:

- Creates the resource group, if it doesn't already exist.
- Creates the container apps environment named `$ENVIRONMENT` with a Log Analytics workspace.
- Creates an Azure Container Registry instance.
- Builds the container image using the source code and the **Dockerfile** in the directory specified by the `source` parameter, and then pushes it to the registry.
- Creates and deploys the container app named `$CONTAINER_APP_NAME` using the built container image.
- Configures `8080` as the HTTP port that the container app listens to for incoming traffic.
- Deploys the container app in the region specified in the `location` parameter.

To view the logs of your container app, use the following command:

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

The container app needs to be able to authenticate to PostgresSQL server. You use system-assigned managed identities for authentication.

To enable a system-assigned managed identity for your container app, use the following command:

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

To authorize the managed identity of your container app to access the Azure Database for PostgreSQL flexible server instance, use the following command:

```azurecli
az postgres flexible-server ad-admin create \
    --resource-group $RESOURCE_GROUP \
    --server-name $DB_SERVER_NAME \
    --display-name $MANAGED_IDENTITY_NAME \
    --object-id $MANAGED_IDENTITY_ID \
    --type ServicePrincipal
```

## Configure the container app environment and secret

Create a secret for sensitive values:

```azurecli
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

Use the following command to get the container app URL:

```azurecli
export URL=$(az containerapp show \
    --resource-group $RESOURCE_GROUP \
    --name $CONTAINER_APP_NAME \
    --query properties.configuration.ingress.fqdn \
    --output tsv)
```

Use the following command to test the endpoint:

```bash
curl -G "https://$URL/api/rag" --data-urlencode "query=How does QuestionAnswerAdvisor work in Spring AI?"
```

The response should be similar to the following example:

```markdown
In the context of **Spring AI**, the **QuestionAnswerAdvisor** operates as a key component for enabling **Retrieval Augmented Generation (RAG)**, which combines user queries with external contextual data to produce accurate and relevant AI responses.
```

Use the following command to try another question that isn't in the vector store:

```bash
curl -G "https://$URL/api/rag" --data-urlencode "query=What is Vector Search Similarity?"
```

The response should be similar to the following example:

```markdown
**Vector Search Similarity** refers to the process of comparing and ranking data points - represented as vectors - based on their similarity in a multi-dimensional space. This method is commonly used in applications like information retrieval, recommendation systems, natural language processing, and computer vision.
```

Use the following command to test the blog generation endpoint:

```bash
curl -G "https://$URL/api/blog" --data-urlencode "topic=Spring AI Innovation"
```

Because of the review iteration cycle, this request takes longer to complete. After it completes, you should see a blog entry similar to the following example:

```markdown
# Spring AI Innovation: Embracing the Season of Transformation

Spring is a season synonymous with growth, renewal, and fresh beginnings. As nature awakens from its winter slumber, so too does the world of technology. In recent years, artificial intelligence (AI) has followed a similar pattern of blossoming innovation, with spring heralding exciting breakthroughs and applications. From revolutionizing industries to improving our everyday lives, AI is in full bloom, and its potential seems as boundless as the season itself.

In this blog post, we'll explore the latest AI innovations that are flourishing this spring, highlight real-world examples of their impact, and discuss how they're reshaping the future. Whether you're an AI enthusiast, a tech professional, or simply curious about the role of AI in our lives, this is your guide to the season's most exciting developments.
```

## Scale Azure Container Apps

By default, your container app is configured to use zero minimum replicas and an HTTP scaling rule to handle 10 requests per replica. To configure the scaling configuration, use the following command:

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
    --yes \
    --no-wait
```

## Unit summary

In this unit, you successfully deployed a Spring AI application to Azure Container Apps, using scalable and serverless container hosting. You set up necessary environment variables, created a **Dockerfile** to build the application image, and deployed the container app using Azure CLI commands. You enabled managed identity for secure authentication to the PostgreSQL server and configured secrets and environment variables for the application. Finally, you verified the deployment by testing the application endpoint and learned how to clean up resources after testing.
