In this unit, we build a RAG (Retrieval Augmented Generation) application using Spring AI, Azure OpenAI and PGVectorStore.

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
   az login  # Log in to Azure
   ```

## Install Spring Boot CLI

We need the Spring Boot CLI to create a starter project. You can install the cli using any of the options listed [here](https://docs.spring.io/spring-boot/installing.html#getting-started.installing.cli). We can install it using the `SDKMAN` option.

Install `SDKMAN` using:

```bash
curl -s "https://get.sdkman.io" | bash
```

Install Spring Boot CLI using this command:

```bash
sdk install springboot
```

Type `spring` to verify it installed successfully:

```bash
spring
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

For our application, we first need to deploy one chat model (gpt-4o) and one embedding model (text-embedding-ada-002).
To deploy these models, we first need to create an Azure OpenAI resource.

### Create Azure OpenAI Resource

We create the Azure OpenAI resource using this Azure CLI command:

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

Use the following maven command to generate a new Spring Boot starter project with all of the dependencies needed:

```bash
spring init \
    --groupId=com.example \
    --artifactId=spring-ai-app \
    --name=spring-ai-app \
    --description="Spring AI Azure Integration" \
    --version=0.0.1-SNAPSHOT \
    --boot-version=3.4.3 \
    --java-version=17 \
    --dependencies=web,jdbc,spring-shell,spring-ai-azure-openai,spring-ai-vectordb-pgvector,postgresql \
    --build=maven \
    --package-name=com.example.springaiapp \
    spring-ai-app
```

If successful, the command output should show:

```bash
Using service at https://start.spring.io
Project extracted to '/mnt/c/Users/user/source/repos/spring-ai-app'
```

Switch directory to this path:

```bash
cd spring-ai-app
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
mkdir -p src/mainjava/com/example/springaiapp/config
mkdir -p src/mainjava/com/example/springaiapp/controller
mkdir -p src/main/java/com/example/springaiapp/service
mkdir -p src/main/java/com/example/springaiapp/shell
```

Inspect the code using Visual Studio Code or your favorite IDE. The starter code includes the following structure:

```txt
src/
├── main/
│   ├── java/
│   │   └── com/example/springaiapp/
│   │       ├── config/
│   │       ├── controller/
│   │       ├── service/
│   │       ├── shell/
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

* Azure OpenAI Endpoint
* Azure OpenAI API Key
* PostgreSql URL

Retrieve the **Azure OpenAI Resource Endpoint** using this command:

```azcli
az cognitiveservices account show \
  --name $OPENAI_RESOURCE_NAME \
  --resource-group $RESOURCE_GROUP \
  --query "properties.endpoint" \
  --output tsv
```

Retrieve the **Azure OpenAI Resource Key** using this command:

```azcli
az cognitiveservices account keys list \
  --name $OPENAI_RESOURCE_NAME \
  --resource-group $RESOURCE_GROUP \
  --query "key1" \
  --output tsv
```

Additionally we need to provide the **PostgreSql URL**, which you can retrieve using command from prior exercise:

```azcli
az postgres flexible-server show --resource-group $RESOURCE_GROUP --name $DB_SERVER_NAME \
 --query fullyQualifiedDomainName --output tsv
```

### Update Azure OpenAI in application.properties

Locate and open the `application.properties` file in the `src/main/resources` directory and add the following properties replacing the values retrieved previously:

```properties
# Azure OpenAI Configuration
spring.ai.azure.openai.api-key=<Azure OpenAI Key>
spring.ai.azure.openai.endpoint=<Azure OpenAI Endpoint>
spring.ai.azure.openai.chat.model=gpt-4o
spring.ai.azure.openai.embedding.model=text-embedding-ada-002

# Database Configuration
spring.datasource.url=jdbc:postgresql://<PostgreSql URL>/postgres
spring.datasource.username=AzureAdmin
spring.ai.vectorstore.pgvector.initialize-schema=true
spring.shell.interactive.enabled=true
spring.main.web-application-type=none
```

Additionally, we need to add `azure-identity` as dependency. Open `pom.xml` and add the following lines:

```xml
        <dependency>
            <groupId>com.azure</groupId>
            <artifactId>azure-identity</artifactId>
            <version>1.15.3</version>
        </dependency>
```

You can re-compile the application to ensure the build is still successful:

```bash
mvn clean package -DskipTests
```

Expect to see a `BUILD SUCCESS` output.

### Implementing RAG Service

Within the `service` directory, create a new file name `RagService.java` with the following content:

```java
package com.example.springaiapp.service;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.client.advisor.QuestionAnswerAdvisor;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RagService {
    private final ChatClient chatClient;

    @Autowired
    VectorStore vectorStore;
    
    public RagService(ChatClient.Builder chatClientBuilder) {
        this.chatClient = chatClientBuilder.build();
    }

    public String processQuery(String query) {
        String answer = "";
        answer = this.chatClient.prompt()
            .advisors(new QuestionAnswerAdvisor(vectorStore))
            .user(query)
            .call()
            .content();
        return answer;
    }
}
```

In this implementation, we use the Spring AI's `QuestionAnswerAdvisor` to augment the knowledge of our chat client with documents loaded in the vector store.

Within the `config` directory, create a new file name `DataSourceConfig.java` with the following content:

```java
package com.example.springaiapp.config;

import com.azure.identity.AzureCliCredential;
import com.azure.identity.AzureCliCredentialBuilder;
import org.springframework.beans.factory.annotation.Value;
import com.azure.core.credential.TokenRequestContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import javax.sql.DataSource;

@Configuration
public class DataSourceConfig {

    @Value("${spring.datasource.url}")
    private String dbUrl;

    @Value("${spring.datasource.username}")
    private String dbUsername;

    @Bean
    public DataSource dataSource() {
        ChainedTokenCredential credential = createChainedCredential();
        String accessToken = credential.getToken(
            new TokenRequestContext()
                .addScopes("https://ossrdbms-aad.database.windows.net"))
                .block().getToken();
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("org.postgresql.Driver");
        dataSource.setUrl(dbUrl);
        dataSource.setUsername(dbUsername);
        dataSource.setPassword(accessToken);
        return dataSource;
    }
}
```

In this implementation, we use `AzureCliCredentialBuilder` to get credentials from `az` cli to be able to authenticate to our PostgreSQL instance.
The use of these credentials, is suitable for development purposes. In a subsequent exercise, we update this implementation to use Managed Identities instead.

Within the `shell` directory, create a new file name `RagDemoCommands.java` with the following content:

```java
package com.example.springaiapp.shell;

import com.example.springaiapp.service.RagService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.shell.standard.ShellComponent;
import org.springframework.shell.standard.ShellMethod;
import org.springframework.shell.standard.ShellOption;

@ShellComponent
public class RagDemoCommands {
    @Autowired
    private RagService ragService;

    @ShellMethod(key = "ask", value = "Ask a question using RAG")
    public String ask(@ShellOption(help = "Your question") String question) {
        return ragService.processQuery(question);
    }
}
```

This shell component allows to test our RAG service using a command shell interface.

With these changes in place, we are now ready to test the implementation by running this command:

```bash
mvn spring-boot:run
```

When prompted ask a question using the ask command about `PGVector`:

```bash
shell:>ask "What is PGVector?"
PGVector is an open-source PostgreSQL extension that enables efficient storage, indexing, 
and querying of vector embeddings within a PostgreSQL database. 
```

Next, use the ask command to ask this question: `ask "How does QuestionAnswerAdvisor work in Spring AI?"`:

```bash
shell:>ask "How does QuestionAnswerAdvisor work in Spring AI?"
"QuestionAnswerAdvisor" does not appear to be an officially recognized or widely known term or 
feature within the Spring Framework or AI ecosystem (as of my knowledge cutoff in 2023).
```

Notice how it doesn't know about the `QuestionAnswerAdvisor` in Spring AI yet.

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

In this code, we create two new documents: one about Spring AI, and the second one explaining how `QuestionAnswerAdvisor` works.

Test these changes by running:

```bash
mvn spring-boot:run
```

Use the ask command to ask this question: `ask "How does QuestionAnswerAdvisor work in Spring AI?"`:

```bash
shell:>ask "How does QuestionAnswerAdvisor work in Spring AI?"
In the context of **Spring AI**, the **QuestionAnswerAdvisor** appears to function as a key component to enable intelligent question-and-answer workflows, especially when integrating AI models with external data sources like a **vector database**. Its primary role is to enhance the AI model's ability to generate accurate, context-aware responses by providing relevant external information that the model might not inherently "know."
```

Notice how the agent now knows about `QuestionAnswerAdvisor`:

## Unit Summary

In this unit, we successfully built a Retrieval Augmented Generation (RAG) application using Spring AI, Azure OpenAI, and `PGVectorStore`.
