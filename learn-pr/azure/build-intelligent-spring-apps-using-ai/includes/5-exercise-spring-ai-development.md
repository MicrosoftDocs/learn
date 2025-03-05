In this unit, we build a RAG (Retrieval Augmented Generation) application using Spring AI, Azure OpenAI, and `VectorStore` from Spring AI.

## Setting Up Your Development Environment

Before we start building our AI-powered application, let's set up our development environment and required Azure resources.

## Local Development Setup

1. Confirm **Java Development Kit (JDK) 17** (or greater) is installed:

   ```bash
   java -version  # Verify Java installation
   ```

2. Confirm **Maven** is installed:

   ```bash
   mvn -version  # Verify Maven installation
   ```

3. Log in to **Azure** using `az`:

   ```azurecli
   az login
   ```

## Environment Variables Setup

For this exercise, we need to some environment variables from the prior exercise. Ensure these variables are still available, and if not, recreate them from the values used previously:

```bash
echo RESOURCE_GROUP: $RESOURCE_GROUP
echo LOCATION: $LOCATION
```

Additionally, export the following new variables needed for this lab:

```bash
OPENAI_RESOURCE_NAME=OpenAISpringAI
```

## Deploy Azure OpenAI Models

For our application, we first need to deploy one chat model (gpt-4o) and one embedding model (`text-embedding-ada-002`). To deploy these models, we first need to create an Azure OpenAI resource.

### Create Azure OpenAI Account

We create the Azure OpenAI account using this Azure CLI command:

```azurecli
az cognitiveservices account create \
  --name $OPENAI_RESOURCE_NAME \
  --resource-group $RESOURCE_GROUP \
  --kind OpenAI \
  --sku S0 \
  --location $LOCATION \
  --yes
```

### Deploy Azure OpenAI Chat Model

We then deploy a chat model named `gpt-4o` using this command:

```azurecli
az cognitiveservices account deployment create \
  --name $OPENAI_RESOURCE_NAME \
  --resource-group $RESOURCE_GROUP \
  --deployment-name gpt-4o \
  --model-name gpt-4o \
  --model-version 2024-11-20 \
  --model-format OpenAI \
  --sku-capacity "15" \
  --sku-name GlobalStandard
```

### Deploy Azure OpenAI Embedding model

We can now deploy embedding model named `text-embedding-ada-002` using this command:

```azurecli
az cognitiveservices account deployment create \
  --name $OPENAI_RESOURCE_NAME \
  --resource-group $RESOURCE_GROUP \
  --deployment-name text-embedding-ada-002 \
  --model-name text-embedding-ada-002 \
  --model-version 2 \
  --model-format OpenAI \
  --sku-capacity 120 \
  --sku-name Standard
```

## Create Spring AI Application

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

- **Spring Boot Version**: 3.4.3
- **Java Version**: 17
- **Dependencies**:
  - `web`: Adds support for building web applications, including RESTful services using Spring MVC (Model View Controller).
  - `jdbc`: Provides JDBC (Java Database Connectivity) support for database access.
  - `azure-support`: Adds support for integrating with Azure services.
  - `spring-ai-azure-openai`: Adds support for integrating with Azure OpenAI services.
  - `spring-ai-vectordb-pgvector`: Adds support for using `pgvector`, a PostgreSQL extension for vector embeddings.

Unzip downloaded file using command:

```bash
unzip -u spring-ai-app.zip -d spring-ai-app
```

Switch directory to this path:

```bash
cd spring-ai-app
```

We need to change the `pom.xml` file to include a dependency for password-less authentication for PostgreSQL.

Open `pom.xml` file, locate the `<dependencies>` section and add the following dependency:

```xml
    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>spring-cloud-azure-starter-jdbc-postgresql</artifactId>
    </dependency>
```

You can compile the application skipping tests using this command:

```bash
mvn clean package -DskipTests
```

Expect to see a successful build output:

```bash
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  25.392 s
[INFO] Finished at: 2025-03-02T15:53:07-05:00
[INFO] ------------------------------------------------------------------------
```

### Project Structure

From the `spring-ai-app` directory, run these commands to create new directories for new source files to be added:

```bash
mkdir -p src/mainjava/com/example/springaiapp/controller
mkdir -p src/main/java/com/example/springaiapp/service
```

Inspect the code using Visual Studio Code or your favorite IDE. The starter code includes the following structure:

```txt
src/
├── main/
│   ├── java/
│   │   └── com/example/springaiapp/
│   │       ├── controller/
│   │       ├── service/
│   │       └── SpringAiAppApplication.java
│   └── resources/
│       ├── application.properties
├── test/
│   ├── java/
│   │   └── com/example/springaiapp/
│   │       └── SpringAiAppApplicationTests.java
└── pom.xml
```

### Spring AI Configuration

Before we can run the application successfully, we need to add required configuration:

- Azure OpenAI Endpoint
- Azure OpenAI API Key
- PostgreSql URL

Retrieve the **Azure OpenAI Endpoint** using this command:

```azcli
export AZURE_OPENAI_ENDPOINT=$(az cognitiveservices account show \
  --name $OPENAI_RESOURCE_NAME \
  --resource-group $RESOURCE_GROUP \
  --query "properties.endpoint" \
  --output tsv | tr -d '\r')
```

Retrieve the **Azure OpenAI API Key** using this command:

```azcli
export AZURE_OPENAI_API_KEY=$(az cognitiveservices account keys list \
  --name $OPENAI_RESOURCE_NAME \
  --resource-group $RESOURCE_GROUP \
  --query "key1" \
  --output tsv | tr -d '\r')
```

Additionally we need to provide the **PostgreSQL URL**, which you can retrieve using command from prior exercise:

```azcli
az postgres flexible-server show --resource-group $RESOURCE_GROUP --name $DB_SERVER_NAME \
 --query fullyQualifiedDomainName --output tsv
```

### Update Azure OpenAI in application.properties

Locate and open the `application.properties` file in the `src/main/resources` directory and add the following properties replacing the values retrieved previously:

```properties
spring.application.name=spring-ai-app
spring.ai.azure.openai.api-key=${AZURE_OPENAI_API_KEY}
spring.ai.azure.openai.endpoint=${AZURE_OPENAI_ENDPOINT}
spring.ai.azure.openai.chat.model=gpt-4o
spring.ai.azure.openai.embedding.model=text-embedding-ada-002

spring.datasource.url=jdbc:postgresql://${PGHOST}/postgres?sslmode=require
spring.datasource.username=cliuser
spring.datasource.azure.passwordless-enabled=true
spring.ai.vectorstore.pgvector.initialize-schema=true
spring.ai.vectorstore.pgvector.schema-name=postgres
```

### Implementing RAG Service

#### Create Service

Within the `service` directory, create a new file name `RagService.java` with the following content:

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
        String answer = "";
        List<Document> similarContexts = vectorStore.similaritySearch(SearchRequest.builder().query(query).similarityThreshold(0.8).topK(3).build());
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
        answer = this.chatClient.prompt()
            .user(promptText)
            .call()
            .content();
        return answer;
    }
}
```

In the provided code, we implement RAG by to generate an answer to a given query by augmenting knowledge in the model using similar contexts from the `VectorStore` as follows:

1. First perform a similarity search using Spring AI's `VectorStore` with the provided `query`. The search is configured to find documents with a similarity threshold of 0.8 and to return the top three most similar documents.
1. The results of the similarity search are then transformed into a formatted string that pairs the new prompt (question) with the contents from the similar found documents.
1. Finally, the new prompt is sent to the `ChatClient`, which sends it to the Azure OpenAI model and returns the response from the model.

#### Create Controller

Next, we need to expose and REST endpoint for our application. To do that, create a new file named `RagController.java` within the `controller` directory.
Update the file with this content:

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

#### Test application

With these changes in place, we're now ready to test the implementation by running this command:

```bash
mvn spring-boot:run
```

Test the new REST endpoint either from a browser or via `curl` command:

```bash
curl -G "http://localhost:8080/api/rag" --data-urlencode "query=What is pgvector?"
```

Expect to see a valid response:

```bash
pgvector is an open-source PostgreSQL extension that enables efficient storage, indexing, 
and querying of vector embeddings within a PostgreSQL database. 
```

Next, use the `curl` command to ask this question "How does QuestionAnswerAdvisor work in Spring AI?":

```bash
curl -G "http://localhost:8080/api/rag" --data-urlencode "query=How does QuestionAnswerAdvisor work in Spring AI?"
```

Notice that even though the answer may appear valid, there are words indicating that this response is a likely guess:

```bash
### 2. **What is QuestionAnswerAdvisor?**
The **QuestionAnswerAdvisor** is likely a component or feature within Spring AI that focuses on providing AI-driven advice or responses to user queries. 
```

#### Test application with extra knowledge

We now provide extra knowledge by providing the following documents to be stored using our vector store:

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
        logger.info("DocumentService initialized with. Document count: {}", 
                   documents.size());
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

In this code, we create two new documents: one about Spring AI, and the second one explaining how `QuestionAnswerAdvisor` works.  Data Scientists are normally responsible for creating these documents.

Test these changes by running:

```bash
mvn spring-boot:run
```

Use the `curl` command to ask this question again: "How does QuestionAnswerAdvisor work in Spring AI?":

```bash
```bash
curl -G "http://localhost:8080/api/rag" --data-urlencode "query=How does QuestionAnswerAdvisor work in Spring AI?"
```

Notice how the agent now knows about `QuestionAnswerAdvisor`:

```bash
In Spring AI, the **QuestionAnswerAdvisor** works as a mechanism to enable **Retrieval Augmented Generation (RAG)**, helping developers integrate advanced question-answering capabilities into their applications. 
```

## Unit Summary

In this unit, we successfully built a Retrieval Augmented Generation (RAG) application using Spring AI, Azure OpenAI, and Spring AI's `VectorStore`.
