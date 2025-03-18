In this unit, you build a retrieval-augmented generation (RAG) application using Spring AI, Azure OpenAI, and `VectorStore` from Spring AI.

## Set up environment variables

For this exercise, you need some environment variables from prior exercises. If you're using the same Bash window, these variables should still exist. If the variables are no longer available, use the following commands to recreate them. Be sure to replace the `<...>` placeholders with your own values, and use the same values that you used previously.

```bash
export RESOURCE_GROUP=<resource-group>
export LOCATION=<location>
export DB_SERVER_NAME=<server-name>
export PGHOST=$(az postgres flexible-server show \
    --resource-group $RESOURCE_GROUP \
    --name $DB_SERVER_NAME \
    --query fullyQualifiedDomainName \
    --output tsv \
    | tr -d '\r')
```

You also need a new environment variable for this unit. Use the following command to define this variable:

```bash
export OPENAI_RESOURCE_NAME=OpenAISpringAI
```

## Deploy the Azure OpenAI models

For your application, you first need to deploy one chat model - `gpt-4o` - and one embedding model - `text-embedding-ada-002`. To deploy these models, you first need to create an Azure OpenAI resource.

### Create an Azure OpenAI account

Use the following command to create an Azure OpenAI account:

```azurecli
az cognitiveservices account create \
    --resource-group $RESOURCE_GROUP \
    --name $OPENAI_RESOURCE_NAME \
    --kind OpenAI \
    --sku S0 \
    --location $LOCATION \
    --yes
```

### Deploy an Azure OpenAI chat model

Use the following command to deploy a chat model named `gpt-4o`:

```azurecli
az cognitiveservices account deployment create \
    --resource-group $RESOURCE_GROUP \
    --name $OPENAI_RESOURCE_NAME \
    --deployment-name gpt-4o \
    --model-name gpt-4o \
    --model-version 2024-11-20 \
    --model-format OpenAI \
    --sku-capacity "15" \
    --sku-name GlobalStandard
```

### Deploy an Azure OpenAI embedding model

You can now deploy an embedding model named `text-embedding-ada-002` by using the following command:

```azurecli
az cognitiveservices account deployment create \
    --resource-group $RESOURCE_GROUP \
    --name $OPENAI_RESOURCE_NAME \
    --deployment-name text-embedding-ada-002 \
    --model-name text-embedding-ada-002 \
    --model-version 2 \
    --model-format OpenAI \
    --sku-capacity 120 \
    --sku-name Standard
```

## Create a Spring AI application

Use the following `curl` command to generate a new Spring Boot starter project with all of the dependencies needed:

```bash
curl https://start.spring.io/starter.zip \
    -d groupId=com.example \
    -d artifactId=spring-ai-app \
    -d name=spring-ai-app \
    -d description="Spring AI Azure Integration" \
    -d version=0.0.1-SNAPSHOT \
    -d bootVersion=3.4.3 \
    -d javaVersion=17 \
    -d dependencies=web,jdbc,azure-support,spring-ai-azure-openai,spring-ai-vectordb-pgvector \
    -d type=maven-project \
    -d packageName=com.example.springaiapp \
    --output spring-ai-app.zip
```

The generated Spring Boot starter project includes the following configurations and dependencies:

- Spring Boot version: 3.4.3
- Java version: 17
- Dependencies:
  - `web`: adds support for building web applications, including RESTful services using Spring Model View Controller (MVC).
  - `jdbc`: provides Java Database Connectivity (JDBC) support for database access.
  - `azure-support`: adds support for integrating with Azure services.
  - `spring-ai-azure-openai`: adds support for integrating with Azure OpenAI services.
  - `spring-ai-vectordb-pgvector`: adds support for using `pgvector`, a PostgreSQL extension for vector embeddings.

Use the following commands to unzip the downloaded file and navigate to the created directory:

```bash
unzip -u spring-ai-app.zip -d spring-ai-app
cd spring-ai-app
```

Next, you need to change the **pom.xml** file to include a dependency for passwordless authentication for PostgreSQL. Open the **pom.xml** file, locate the `<dependencies>` section, and then add the following dependency:

```xml
<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>spring-cloud-azure-starter-jdbc-postgresql</artifactId>
</dependency>
```

Then, use the following command to compile the application, skipping tests:

```bash
mvn clean package -DskipTests
```

The output should include a success message similar to the following example:

```output
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  25.392 s
[INFO] Finished at: 2025-03-02T15:53:07-05:00
[INFO] ------------------------------------------------------------------------
```

### Project structure

From the **spring-ai-app** directory, use the following commands to create new directories for new source files to be added:

```bash
mkdir -p src/main/java/com/example/springaiapp/controller
mkdir -p src/main/java/com/example/springaiapp/service
```

Inspect the code using Visual Studio Code or your favorite IDE. The starter code includes the following structure:

```
src/
├── main/
│   ├── java/
│   │   └── com/example/springaiapp/
│   │       ├── controller/
│   │       ├── service/
│   │       └── SpringAiAppApplication.java
│   └── resources/
│       └── application.properties
├── test/
│   └── java/
│       └── com/example/springaiapp/
│           └── SpringAiAppApplicationTests.java
└── pom.xml
```

### Configure Spring AI

Before you can run the application successfully, you need to add the following required configuration:

- An Azure OpenAI endpoint.
- An Azure OpenAI API key.
- A PostgreSQL URL.

Retrieve the Azure OpenAI endpoint by using the following command:

```azurecli
export AZURE_OPENAI_ENDPOINT=$(az cognitiveservices account show \
    --resource-group $RESOURCE_GROUP \
    --name $OPENAI_RESOURCE_NAME \
    --query "properties.endpoint" \
    --output tsv \
    | tr -d '\r')
```

Retrieve the Azure OpenAI API key by using the following command:

```azurecli
export AZURE_OPENAI_API_KEY=$(az cognitiveservices account keys list \
    --resource-group $RESOURCE_GROUP \
    --name $OPENAI_RESOURCE_NAME \
    --query "key1" \
    --output tsv \
    | tr -d '\r')
```

Retrieve the PostgreSQL URL by using the following command:

```azurecli
az postgres flexible-server show \
    --resource-group $RESOURCE_GROUP \
    --name $DB_SERVER_NAME \
    --query fullyQualifiedDomainName \
    --output tsv
```

#### Update the application.properties file

Locate and open the **application.properties** file in the **src/main/resources** directory. There are three properties that are initialized using values from the following environment variables: `AZURE_OPENAI_API_KEY`, `AZURE_OPENAI_ENDPOINT`, and `PGHOST`. Replace the file's content with the following content:

```properties
spring.application.name=spring-ai-app
spring.ai.azure.openai.api-key=${AZURE_OPENAI_API_KEY}
spring.ai.azure.openai.endpoint=${AZURE_OPENAI_ENDPOINT}
spring.ai.azure.openai.chat.model=gpt-4o
spring.ai.azure.openai.embedding.model=text-embedding-ada-002

spring.datasource.url=jdbc:postgresql://${PGHOST}/postgres?sslmode=require
spring.datasource.username=azureuser
spring.datasource.azure.passwordless-enabled=true
spring.ai.vectorstore.pgvector.initialize-schema=true
spring.ai.vectorstore.pgvector.schema-name=postgres
```

### Implement a RAG service

#### Create the service

Within the **service** directory, create a new file named **RagService.java** and add the following code:

```java
package com.example.springaiapp.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.ai.document.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.vectorstore.SearchRequest;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RagService {
    private static final Logger logger = LoggerFactory.getLogger(RagService.class);

    private final ChatClient chatClient;

    @Autowired
    VectorStore vectorStore;

    public RagService(ChatClient.Builder chatClientBuilder) {
        this.chatClient = chatClientBuilder.build();
    }

    public String processQuery(String query) {
        List<Document> similarContexts = vectorStore.similaritySearch(
            SearchRequest.builder()
                .query(query)
                .similarityThreshold(0.8)
                .topK(3)
                .build()
        );
        String context = similarContexts.stream()
                .map(ch -> String.format("Q: %s\nA: %s", ch.getMetadata().get("prompt"), ch.getText()))
                .collect(Collectors.joining("\n\n"));
        logger.debug("Found {} similar contexts", similarContexts.size());
        String promptText = String.format("""
            Use these previous Q&A pairs as context for answering the new question:

            Previous interactions:
            %s

            New question: %s

            Please provide a clear and educational response.""",
            context,
            query
        );
        return this.chatClient.prompt()
            .user(promptText)
            .call()
            .content();
    }
}
```

This code implements RAG by generating an answer to a given query, augmenting the knowledge in the model using similar contexts from the `VectorStore`.

#### Create the RAG controller

Next, you need to expose a REST endpoint for your RAG application. Create a new file named **RagController.java** within the **controller** directory, and then add the following code:

```java
package com.example.springaiapp.controller;

import com.example.springaiapp.service.RagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/rag")
public class RagController {

    @Autowired
    private RagService ragService;

    @GetMapping
    public String processQuery(@RequestParam String query) {
        return ragService.processQuery(query);
    }
}
```

#### Test the RAG application

With these changes in place, use the following command to compile and run the code:

```bash
mvn spring-boot:run
```

Test the new REST endpoint either from a browser or by using the following command:

```bash
curl -G "http://localhost:8080/api/rag" \
    --data-urlencode "query=What is pgvector?"
```

You should see a valid response similar to the following example:

```output
pgvector is an open-source PostgreSQL extension that enables efficient storage, indexing,
and querying of vector embeddings within a PostgreSQL database.
```

Next, try the following command:

```bash
curl -G "http://localhost:8080/api/rag" \
    --data-urlencode "query=How does QuestionAnswerAdvisor work in Spring AI?"
```

Although the answer might appear valid, it might include phrasing that indicates it's a reasoned guess.

#### Test the application with extra knowledge

Next, provide extra knowledge by adding documents to the vector store. Create a new file named **DocumentService.java** within the **service** directory, and then add the following code:

```java
package com.example.springaiapp.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.document.Document;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;

@Service
public class DocumentService {

    private static final Logger logger = LoggerFactory.getLogger(DocumentService.class);

    @Autowired
    VectorStore vectorStore;

    @PostConstruct
    private void init() {
        vectorStore.add(documents);
        logger.info("DocumentService initialized with. Document count: {}", documents.size());
    }

    List<Document> documents = List.of(
        new Document("3e1a1af7-c872-4e36-9faa-fe53b9613c69",
                    """
                    The Spring AI project aims to streamline the development of applications that
                    incorporate artificial intelligence functionality without unnecessary complexity.
                    The project draws inspiration from notable Python projects, such as LangChain
                    and LlamaIndex, but Spring AI is not a direct port of those projects.
                    The project was founded with the belief that the next wave of Generative AI
                    applications will not be only for Python developers but will be ubiquitous
                    across many programming languages.
                    """,
                     Map.of("prompt", "What is Spring AI?")),
        new Document("7a7c2caf-ce9c-4dcb-a543-937b76ef1098",
                    """
                    A vector database stores data that the AI model is unaware of. When a user
                    question is sent to the AI model, a QuestionAnswerAdvisor queries the vector
                    database for documents related to the user question.
                    The response from the vector database is appended to the user text to provide
                    context for the AI model to generate a response. Assuming you have already
                    loaded data into a VectorStore, you can perform Retrieval Augmented Generation
                    (RAG) by providing an instance of QuestionAnswerAdvisor to the ChatClient.
                    """,
                     Map.of("prompt", "How does QuestionAnswer Advisor work?"))
        );
}
```

To test these changes, use the following command to compile and run the code:

```bash
mvn spring-boot:run
```

Then, ask a question by using the following command:

```bash
curl -G "http://localhost:8080/api/rag" \
    --data-urlencode "query=How does QuestionAnswerAdvisor work in Spring AI?"
```

You should now see an answer that clearly explains the role of `QuestionAnswerAdvisor` within Spring AI.

## Unit summary

In this unit, you successfully built a RAG application using Spring AI, Azure OpenAI, and Spring AI's `VectorStore`. The module exposes the RAG capability via a dedicated REST endpoint through the `RagController` class.
