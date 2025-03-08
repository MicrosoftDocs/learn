In this unit, we build a retrieval-augmented generation (RAG) application using Spring AI, Azure OpenAI, and `VectorStore` from Spring AI. Additionally, we demonstrate an Evaluator Optimizer Agent pattern that leverages multiple AI agents to generate, evaluate, and refine content iteratively, such as generating blog posts.

## Set up your development environment

Before you start building an AI-powered application, set up your development environment and the required Azure resources.

## Set up your local environment

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

## Set up environment variables

For this exercise, you need some environment variables from the previous exercise. If these variables aren't still available, use the following commands to recreate them:

```bash
echo RESOURCE_GROUP: $RESOURCE_GROUP
echo LOCATION: $LOCATION
```

Additionally, export the following new variables needed for this lab:

```bash
export OPENAI_RESOURCE_NAME=OpenAISpringAI
```

## Deploy the Azure OpenAI models

For our application, you first need to deploy one chat model (gpt-4o) and one embedding model (`text-embedding-ada-002`). To deploy these models, we first need to create an Azure OpenAI resource.

### Create an Azure OpenAI account

We create the Azure OpenAI account using this Azure CLI command:

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

We can now deploy an embedding model named `text-embedding-ada-002` using this command:

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

- **Spring Boot Version**: 3.4.3  
- **Java Version**: 17  
- **Dependencies**:
  - `web`: Adds support for building web applications, including RESTful services using Spring MVC (Model View Controller).
  - `jdbc`: Provides JDBC (Java Database Connectivity) support for database access.
  - `azure-support`: Adds support for integrating with Azure services.
  - `spring-ai-azure-openai`: Adds support for integrating with Azure OpenAI services.
  - `spring-ai-vectordb-pgvector`: Adds support for using `pgvector`, a PostgreSQL extension for vector embeddings.

Unzip the downloaded file using the command:

```bash
unzip -u spring-ai-app.zip -d spring-ai-app
```

Switch directory to this path:

```bash
cd spring-ai-app
```

We need to change the **pom.xml** file to include a dependency for password-less authentication for PostgreSQL.

Open the **pom.xml** file, locate the `<dependencies>` section and add the following dependency:

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

### Project structure

From the **spring-ai-app** directory, run these commands to create new directories for new source files to be added:

```bash
mkdir -p src/main/java/com/example/springaiapp/controller
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
│       └── application.properties
├── test/
│   └── java/
│       └── com/example/springaiapp/
│           └── SpringAiAppApplicationTests.java
└── pom.xml
```

### Spring AI configuration

Before we can run the application successfully, we need to add the required configuration:

- Azure OpenAI Endpoint  
- Azure OpenAI API Key  
- PostgreSQL URL

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

Additionally, provide the **PostgreSQL URL** (retrieved using the command from a prior exercise):

```azcli
az postgres flexible-server show --resource-group $RESOURCE_GROUP --name $DB_SERVER_NAME \
    --query fullyQualifiedDomainName --output tsv
```

### Update Azure OpenAI in application.properties

Locate and open the **application.properties** file in the **src/main/resources** directory and add the following properties, replacing the values retrieved previously:

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

### Implement a RAG service

#### Create the service

Within the **service** directory, create a new file named **RagService.java** with the following content:

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

In the provided code, we implement RAG by generating an answer to a given query by augmenting the knowledge in the model using similar contexts from the `VectorStore`.

#### Create the RAG controller

Next, we need to expose a REST endpoint for our RAG application. Create a new file named **RagController.java** within the **controller** directory:

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

With these changes in place, test the implementation by running:

```bash
mvn spring-boot:run
```

Test the new REST endpoint either from a browser or via a `curl` command:

```bash
curl -G "http://localhost:8080/api/rag" --data-urlencode "query=What is pgvector?"
```

You should see a valid response:

```bash
pgvector is an open-source PostgreSQL extension that enables efficient storage, indexing, 
and querying of vector embeddings within a PostgreSQL database.
```

Next, try asking:

```bash
curl -G "http://localhost:8080/api/rag" --data-urlencode "query=How does QuestionAnswerAdvisor work in Spring AI?"
```

Notice that while the answer may appear valid, it might include phrasing that indicates it is a reasoned guess.

#### Test the application with extra knowledge

We now provide extra knowledge by adding the following documents to the vector store. Create a new file named **DocumentService.java** within the **service** directory:

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

Test these changes by running:

```bash
mvn spring-boot:run
```

Then ask:

```bash
curl -G "http://localhost:8080/api/rag" --data-urlencode "query=How does QuestionAnswerAdvisor work in Spring AI?"
```

You should now see an answer that clearly explains the role of **QuestionAnswerAdvisor** within Spring AI.

---

## Implement Evaluator Optimizer Agent for Blog Post Generation

In addition to the RAG service, this unit now demonstrates an Evaluator Optimizer Agent pattern to improve generated content. In this design, one AI agent (the **Writer**) generates an initial draft (e.g., a blog post), and another agent (the **Evaluator**) reviews and provides actionable feedback. The Writer refines the draft based on the feedback, and the process repeats until the content is approved or the maximum number of iterations is reached.

#### Create the BlogWriterService

Within the **service** directory, create a new file named **BlogWriterService.java** with the following code:

```java
package com.example.springaiapp.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.stereotype.Service;

@Service
public class BlogWriterService {
    private static final Logger logger = LoggerFactory.getLogger(BlogWriterService.class);
    private static final int MAX_ITERATIONS = 3;

    private final ChatClient chatClient;

    public BlogWriterService(ChatClient.Builder chatClientBuilder) {
        this.chatClient = chatClientBuilder.build();
    }

    public String generateBlogPost(String topic) {
        logger.info("Starting blog generation for topic: {}", topic);

        // Writer: Generate initial blog draft
        String initialPrompt = String.format("""
            You are a professional blog writer. Write a well-structured, engaging blog post about "%s".
            The post should have a clear introduction, body paragraphs, and conclusion.
            Include relevant examples and maintain a conversational yet professional tone.
            """, topic);
        
        String draft = chatClient.prompt(initialPrompt).call().chatResponse().getResult().getOutput().getText();
        logger.info("Initial draft generated");
        logger.debug("Initial draft content:\n{}", draft);

        // Enter evaluator-optimizer loop for refinement
        boolean approved = false;
        int iteration = 1;
        
        while (!approved && iteration <= MAX_ITERATIONS) {
            // Evaluator: Assess the current draft
            String evalPrompt = String.format("""
                You are a critical blog editor. Evaluate the following blog draft and respond with either:
                PASS - if the draft is well-written, engaging, and complete
                NEEDS_IMPROVEMENT - followed by specific, actionable feedback on what to improve
                
                Focus on:
                - Clarity and flow of ideas
                - Engagement and reader interest
                - Professional yet conversational tone
                - Structure and organization
                
                Draft:
                %s
                """, draft);
            
            String evaluation = chatClient.prompt(evalPrompt).call().chatResponse().getResult().getOutput().getText();
            logger.info("Iteration {} - Editor's evaluation:\n{}", iteration, evaluation);

            if (evaluation.toUpperCase().contains("PASS")) {
                approved = true;
                logger.info("Draft approved by editor on iteration {}", iteration);
            } else {
                // Extract feedback and refine the draft
                String feedback = extractFeedback(evaluation);
                logger.info("Editor feedback (iteration {}): {}", iteration, feedback);
                
                // Writer: Refine the draft using feedback
                String refinePrompt = String.format("""
                    You are a blog writer. Improve the following blog draft based on this editorial feedback:
                    
                    Feedback: %s
                    
                    Current Draft:
                    %s
                    
                    Provide the complete improved version while maintaining the original topic and structure.
                    """, feedback, draft);
                
                draft = chatClient.prompt(refinePrompt).call().chatResponse().getResult().getOutput().getText();
                logger.info("Iteration {} - Draft revised", iteration);
                logger.debug("Revised draft content:\n{}", draft);
            }
            iteration++;
        }

        if (!approved) {
            logger.warn("Maximum iterations ({}) reached without editor approval", MAX_ITERATIONS);
        }

        return draft;
    }

    private String extractFeedback(String evaluation) {
        if (evaluation == null) return "";
        int idx = evaluation.toUpperCase().indexOf("NEEDS_IMPROVEMENT");
        if (idx != -1) {
            // Return text after "NEEDS_IMPROVEMENT"
            return evaluation.substring(idx + "NEEDS_IMPROVEMENT".length()).trim();
        }
        return evaluation;
    }
}
```

#### Create the BlogWriterController

To expose the blog generation functionality via a REST endpoint, create a new file named **BlogWriterController.java** within the **controller** directory:

```java
package com.example.springaiapp.controller;

import com.example.springaiapp.service.BlogWriterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/blog")
public class BlogWriterController {

    private final BlogWriterService blogWriterService;

    @Autowired
    public BlogWriterController(BlogWriterService blogWriterService) {
        this.blogWriterService = blogWriterService;
    }

    @GetMapping
    public String generateBlogPost(@RequestParam String topic) {
        return blogWriterService.generateBlogPost(topic);
    }
}
```

This controller exposes a GET endpoint at `/api/blog` that accepts a `topic` parameter and delegates the blog post generation to the **BlogWriterService**.

#### Testing the Blog Generation

After adding the BlogWriterService and its controller, compile and run the application:

```bash
mvn spring-boot:run
```

Then test the blog generation endpoint using a REST client or `curl`:

```bash
curl -G "http://localhost:8080/api/blog" --data-urlencode "topic=Spring AI Innovation"
```

This should return a blog post that has been generated and iteratively refined through the Evaluator Optimizer Agent process.

---

## Unit summary

In this unit, we successfully built a Retrieval Augmented Generation (RAG) application using Spring AI, Azure OpenAI, and Spring AI's `VectorStore`. Additionally, we incorporated an Evaluator Optimizer Agent pattern to enhance content generation by iteratively refining a blog post through automated evaluation and optimization. The module exposes both RAG and blog generation capabilities via dedicated REST endpoints through the **RagController** and **BlogWriterController**.