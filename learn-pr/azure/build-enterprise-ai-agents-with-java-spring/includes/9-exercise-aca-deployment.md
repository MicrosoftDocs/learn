In this unit, you deploy your Spring AI application to Azure Container Apps for scalable and serverless container hosting.

## Set up environment variables

For this exercise, you need some environment variables from prior exercises. If you're using the same Bash window, these variables should still exist. If the variables are no longer available, use the following commands to recreate them. Be sure to replace the `<...>` placeholders with your own values, and use the same values that you used previously.

```azurecli
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

You also need some new environment variables for this unit. Use the following command to define these variables. Be sure to replace the `<...>` placeholders with your own values.

```bash
export CONTAINER_APP_NAME=<container-app-name>
export MANAGED_IDENTITY_NAME=<managed-identity-name>
export ENVIRONMENT=<Azure-Container-Apps-environment>
```

With these environment variables in place, you're now ready to deploy the application to Azure Container Apps.

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
- Creates the Container Apps environment with a Log Analytics workspace. The environment is named using the value specified in the `environment` parameter.
- Creates an Azure Container Registry instance.
- Builds the container image using the source code and the **Dockerfile** in the directory specified by the `source` parameter, and then pushes it to the registry.
- Creates and deploys the container app using the built container image. The container app is named using the value specified in the `name` parameter.
- Configures `8080` as the HTTP port that the container app listens to for incoming traffic.
- Deploys the container app to the region specified in the `location` parameter.

To view the logs of your container app, use the following command:

```azurecli
az containerapp logs show \
    --resource-group $RESOURCE_GROUP \
    --name $CONTAINER_APP_NAME \
    --tail 80
```

The following example shows a typical log. When you inspect the logs, you can see that the application isn't starting successfully due to missing configuration values, which is expected at this point.

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

The container app needs to be able to authenticate to the PostgresSQL server. You use system-assigned managed identities for authentication.

To enable a system-assigned managed identity for your container app, use the following command:

```azurecli
az containerapp identity assign \
    --resource-group $RESOURCE_GROUP \
    --name $CONTAINER_APP_NAME \
    --system-assigned
```

To get the ID of the system assigned managed identity and display it, use the following commands:

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

To create a secret for sensitive values, use the following command:

```azurecli
az containerapp secret set \
    --resource-group $RESOURCE_GROUP \
    --name $CONTAINER_APP_NAME \
    --secrets \
      azure-openai-api-key=$AZURE_OPENAI_API_KEY
```

Next, use the following command to set environment variables:

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

This command intentionally uses a different `pgvector` schema name to avoid conflicts from using the same schema name with a different user.

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
curl -G "https://$URL/api/rag" \
    --data-urlencode "query=How does QuestionAnswerAdvisor work in Spring AI?"
```

The response should be similar to the following example:

```markdown
In the context of **Spring AI**, the **QuestionAnswerAdvisor** operates as a key component for enabling **Retrieval Augmented Generation (RAG)**, which combines user queries with external contextual data to produce accurate and relevant AI responses.
```

Use the following command to try another question that isn't in the vector store:

```bash
curl -G "https://$URL/api/rag" \
    --data-urlencode "query=What is vector similarity search?"
```

The response should be similar to the following example:

```markdown
**Vector similarity search** refers to the process of comparing and ranking data points - represented as vectors - based on their similarity in a multi-dimensional space. This method is commonly used in applications like information retrieval, recommendation systems, natural language processing, and computer vision.
```

Use the following command to test the blog generation endpoint:

```bash
curl -G "https://$URL/api/blog" \
    --data-urlencode "topic=Java on Azure"
```

Because of the review iteration cycle, this request takes longer to complete. After it completes, you should see a JSON response containing both the blog content and metadata about the generation process, as shown in the following example:

```json
{
  "metadata": {
    "totalTokensUsed": 8637,
    "approved": false,
    "tokenUsage": {
      "promptTokens": 5324,
      "totalTokens": 8637,
      "completionTokens": 3313
    },
    "model": "Azure OpenAI",
    "editorFeedback": [
      {
        "feedback": "**Feedback:**\n\n1. **Sentence Count Issue:** The draft exceeds the strict 10-sentence maximum requirement. It contains 11 sentences. To comply with the rules, you need to condense the content without losing essential details.\n\n2. **Clarity and Flow of Ideas:** While the draft is informative, the transition between sections feels slightly mechanical. For instance, the sentence about deploying a Spring Boot application being simple could flow better into the discussion about monitoring and diagnostics. Consider smoothing out these transitions to make the blog more cohesive.\n\n3. **Engagement and Reader Interest:** The tone is professional but lacks a conversational spark that would fully engage the reader. Adding a brief anecdote, rhetorical question, or vivid example could help draw readers in. For example, you could open with a scenario like, \"Imagine deploying your Java app to the cloud in minutes, while Azure handles the heavy lifting.\"\n\n4. **Professional Yet Conversational Tone:** While polished, the tone leans slightly towards technical documentation rather than a conversational blog. Use more approachable phrasing to make it relatable to broader audiences, such as developers exploring Azure for the first time.\n\n5. **Structure and Organization:** The draft provides valuable information but feels slightly dense. Breaking it into smaller, more digestible sections or trimming less critical details can improve readability. For example, you could consolidate the points about Azure's tools and services into a single sentence to save space.\n\n6. **Actionable Suggestions:**\n   - Reduce sentence count to meet the 10-sentence maximum by combining or trimming redundant ideas. For example, integrate the points about Azure's services and Spring Boot deployment into a single concise statement.\n   - Add a conversational hook or engaging opening sentence to draw readers in immediately.\n   - Improve transitions between ideas to enhance flow and readability. For instance, connect the infrastructure management point more naturally to the monitoring and diagnostics capabilities.\n   - Consider rephrasing to strike a balance between technical detail and approachable language.\n\n7. **Conclusion Improvement:** The conclusion is strong but could be more dynamic. Consider ending with a forward-looking statement or call-to-action, such as, \"Explore how Azure can revolutionize your Java development journey today.\"\n\nBy implementing these changes, the blog can achieve a more refined, engaging, and reader-friendly result while adhering to the rules.",
        "iteration": 1
      },
      {
        "feedback": "**Feedback:**\n\n1. **Sentence Count:** The draft contains 11 sentences, exceeding the 10-sentence limit. This violates the stated guidelines and must be corrected. Revising for conciseness is necessary.\n\n2. **Clarity and Flow:** While the ideas are clear, the flow feels slightly disjointed. The transitions between Java frameworks, tools, and Azure services could be smoother to create a more cohesive narrative. Consider linking sections with transitional phrases to enhance readability.\n\n3. **Engagement and Reader Interest:** The opening sentence is engaging but could be more specific to immediately hook the reader. For example, instead of \"Imagine deploying your Java app to the cloud,\" consider adding a concrete benefit or scenario that resonates with developers.\n\n4. **Professional yet Conversational Tone:** The tone is professional but leans too heavily on technical descriptions without enough conversational elements. Adding relatable examples or posing direct questions might make the blog more inviting.\n\n5. **Structure and Organization:** The structure is logical but somewhat crowded. Too many points are packed into a small space, leading to information overload. Break the content into digestible chunks and prioritize key ideas.\n\n6. **Adherence to the 10-Sentence Limit:** Beyond trimming the number of sentences, ensure each sentence delivers maximum impact. Avoid redundancy, such as mentioning \"Azure manages infrastructure effortlessly\" and \"Azure supports popular Java frameworks to simplify your development journey,\" which overlap conceptually.\n\n7. **Suggestions for Improvement:**\n   - Reduce sentence count to meet the 10-sentence limit while retaining the essential points.\n   - Strengthen transitions to improve flow.\n   - Rewrite the opening sentence to include a more compelling example or benefit.\n   - Focus on fewer Azure services for clarity and emphasize their unique value instead of listing too many features.\n   - Add a more engaging closing statement that calls the reader to action or leaves a memorable impression.\n\n**Actionable Revision Steps:**\n- Consolidate redundant ideas.\n- Use a more concise, focused approach to highlight Azure's benefits for Java developers.\n- Revise for a conversational yet professional tone that balances technical details with reader engagement.\n\nThis draft shows promise but requires significant refinement to meet the strict evaluation standards.",
        "iteration": 2
      },
      {
        "feedback": "Here is my detailed feedback on the draft:\n\n1. **Sentence Count**: The blog draft contains **10 sentences**, meeting the sentence limit requirement. However, adhering to the rule that all first iterations must receive a NEEDS_IMPROVEMENT rating, the draft will be evaluated critically.\n\n2. **Clarity and Flow of Ideas**: The draft is clear and flows logically, but it lacks specificity in some areas. For instance, phrases like \"Azure simplifies the process\" and \"streamline development workflows\" are somewhat vague. Readers may appreciate concrete examples or brief technical details to substantiate these claims. For example, how exactly does the integration with IntelliJ IDEA streamline workflows?\n\n3. **Engagement and Reader Interest**: While the draft is informative, it could enhance engagement by including a compelling hook. The opening sentence is functional but lacks the punch to immediately captivate readers. Consider starting with a thought-provoking question, statistic, or anecdote tied to Java and cloud computing.\n\n4. **Tone**: The tone is professional yet conversational, which works well for the target audience. However, certain phrases like \"letting you focus on what matters most—your code\" feel slightly generic. Adding a more nuanced observation tailored to Java developers could elevate the tone further.\n\n5. **Structure and Organization**: The structure is solid, but the final call-to-action (\"Ready to take your Java projects to the next level?\") is abrupt and lacks a sense of closure. A stronger conclusion could summarize the benefits discussed and tie them back to the opening idea, creating a more cohesive experience.\n\n6. **Suggestions for Improvement**:  \n   - Add more specificity to claims about Azure's tools and services to make the draft more actionable and informative.  \n   - Craft a more engaging opening sentence to draw readers in immediately.  \n   - Refine the conclusion to provide a sense of completion and reinforce the value proposition.  \n   - Consider rephrasing generic statements to better resonate with the Java developer audience.  \n\nOverall, the draft has potential but needs refinement in its engagement techniques, specificity, and structural polish.",
        "iteration": 3
      }
    ],
    "iterations": 3
  },
  "topic": "Java on Azure",
  "content": "JAVA ON AZURE  \n\nWhat if deploying your Java app to the cloud was as simple as a few clicks, instantly connecting you to millions of users worldwide? Java, the backbone of enterprise software development, pairs effortlessly with Microsoft Azure to transform how developers create, deploy, and scale cloud applications. Whether you're crafting microservices with Spring Boot or managing enterprise systems with Jakarta EE, Azure empowers you with tools and services designed for speed and reliability.  \n\nTake IntelliJ IDEA integration, for example—it streamlines workflows by enabling developers to deploy directly from their IDE, eliminating the need for complex manual setups. Azure App Service simplifies operations even further, allowing you to publish Spring Boot applications with minimal configuration, while Azure Kubernetes Service (AKS) handles container orchestration seamlessly. These features let you focus on writing clean, efficient code without getting bogged down by infrastructure concerns.  \n\nAzure also ensures your applications perform flawlessly with Application Insights, providing end-to-end monitoring for debugging and optimization. Built-in security measures like compliance certifications and encryption safeguard your data, while the pay-as-you-go pricing model lets you scale intelligently based on project demands.  \n\nWith Azure, Java developers can embrace a cloud-first future without compromising on efficiency or control. Ready to unlock new possibilities for your Java projects? Explore how Azure can revolutionize your development journey today.  "
}
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
