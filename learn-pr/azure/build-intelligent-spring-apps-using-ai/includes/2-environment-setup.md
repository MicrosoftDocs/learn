# Setting Up Your Development Environment

Before we start building our AI-powered application, let's set up our development environment and required Azure resources.

## Local Development Setup

1. **Java Development Kit (JDK) 17+**
   ```bash
   java -version  # Verify Java installation
   ```

2. **Maven or Gradle**
   ```bash
   mvn -version  # Verify Maven installation
   ```

3. **Azure CLI with Container Apps Extension**
   ```bash
   az extension add --name containerapp  # Install Container Apps extension
   az login  # Log in to Azure
   ```

## Project Dependencies

Our application requires these key Spring AI dependencies:

```xml
<dependencies>
    <!-- Spring AI Azure OpenAI -->
    <dependency>
        <groupId>org.springframework.ai</groupId>
        <artifactId>spring-ai-azure-openai-spring-boot-starter</artifactId>
    </dependency>
    
    <!-- PostgreSQL with Vector Support -->
    <dependency>
        <groupId>org.postgresql</groupId>
        <artifactId>postgresql</artifactId>
    </dependency>
</dependencies>
```

## Azure Resource Setup

1. **Create a Resource Group**
   ```bash
   az group create --name spring-ai-demo --location eastus
   ```

2. **Create Azure OpenAI Service**
   ```bash
   az cognitiveservices account create \
     --name spring-ai-openai \
     --resource-group spring-ai-demo \
     --kind OpenAI \
     --sku s0 \
     --location eastus
   ```

3. **Deploy Azure OpenAI Models**
   - Deploy a chat model (e.g., gpt-35-turbo)
   - Deploy an embedding model (e.g., text-embedding-ada-002)

## Project Structure

Our application follows this structure:
```
src/
├── main/
│   ├── java/
│   │   └── com/example/springaiapp/
│   │       ├── model/
│   │       ├── repository/
│   │       ├── service/
│   │       └── SpringAiApplication.java
│   └── resources/
│       ├── application.properties
│       └── schema.sql
```

## Environment Variables

Create a `.env` file with your Azure OpenAI configuration:
```properties
AZURE_OPENAI_API_KEY=your-api-key
AZURE_OPENAI_ENDPOINT=your-endpoint
AZURE_OPENAI_CHAT_DEPLOYMENT=your-chat-deployment
AZURE_OPENAI_EMBEDDING_DEPLOYMENT=your-embedding-deployment
```

## Next Steps

With our environment set up, we're ready to:
1. Create our PostgreSQL database with vector support
2. Implement our Spring AI application
3. Deploy to Azure Container Apps

🔧 Pro tip: Keep your Azure credentials secure and never commit them to version control! 
