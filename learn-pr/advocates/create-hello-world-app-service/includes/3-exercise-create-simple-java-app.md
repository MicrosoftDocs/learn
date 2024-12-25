## Create a simple Java web app

In this exercise, you create a minimal Java web application that serves a simple "Hello, World!" message using Java 17 and Maven. This application runs on a built-in HTTP server and can be deployed to Azure App Service.

You have two options to proceed. Select the relevant tab based on your preference.

### [Option 1: Pull code from the Azure samples repo](#tab/option-1)

### Clone the project repo

Within your directory of choice, use the following command to clone the sample project repo:

```bash
git clone https://github.com/MicrosoftDocs/hello-java-azure.git
```

Now, use the following command to navigate to inside the cloned project repo:

```bash
cd hello-java-azure
```

### [Option 2: Create the code sample from scratch](#tab/option-2)

### Create a Maven project

Use the following Maven archetype command to create a Maven project for your Java web application:

```bash
mvn archetype:generate \
    -DgroupId=com.microsoft.azure.samples \
    -DartifactId=azure-javaweb-app-simple \
    -DarchetypeArtifactId=maven-archetype-quickstart \
    -Dversion=1.0-SNAPSHOT \
    -DinteractiveMode=false
```

You should see the following output:

```output
[INFO] ----------------------------------------------------------------------------
[INFO] Parameter: basedir, Value: /home/ayangupta/LearnProjects/DeployHelloApp
[INFO] Parameter: package, Value: com.microsoft.azure.samples
[INFO] Parameter: groupId, Value: com.microsoft.azure.samples
[INFO] Parameter: artifactId, Value: azure-javaweb-app-simple
[INFO] Parameter: packageName, Value: com.microsoft.azure.samples
[INFO] Parameter: version, Value: 1.0-SNAPSHOT
[INFO] project created from Old (1.x) Archetype in dir: /private/tmp/TMP/azure-javaweb-app
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  1.657 s
[INFO] Finished at: 2024-10-18T12:39:41-07:00
[INFO] ------------------------------------------------------------------------
```

The following files and directories are now available:

```
└── azure-javaweb-app-simple
    ├── src
    │   ├── main
    │   │   └── java
    │   │       └── com
    │   │           └── microsoft
    │   │               └── azure
    │   │                   └── samples
    │   │                       └── App.java
    │   └── test
    │       └── java
    │           └── com
    │               └── microsoft
    │                   └── azure
    │                       └── samples
    │                           └── AppTest.java
    └── pom.xml
```

### Modify the Maven pom.xml file

Replace the contents of your **pom.xml** with the following code. This updated **pom.xml** introduces the correct versions of dependencies needed for this web app.

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.microsoft.azure.samples</groupId>
    <artifactId>azure-javaweb-app-simple</artifactId>
    <version>1.0-SNAPSHOT</version>
    <properties>
            <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-api</artifactId>
            <version>1.7.30</version>
        </dependency>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.13.2</version>
            <scope>test</scope>
        </dependency>
    </dependencies>
</project>
```

### Create the Main application class

Edit the **App.java** file in the **src/main/java/com/microsoft/azure/samples** directory to use the following code, which creates a simple HTTP server:

```java
package com.microsoft.azure.samples;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpExchange;

public class App {

    public static void main(String[] args) throws IOException {
        HttpServer server = HttpServer.create(new InetSocketAddress(8080), 0);
        server.createContext("/", new HelloHandler());
        server.setExecutor(null); // creates a default executor
        server.start();
        System.out.println("Server started on http://localhost:8080/");
    }

    static class HelloHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            String response = "Hello, World!";
            exchange.sendResponseHeaders(200, response.length());
            OutputStream os = exchange.getResponseBody();
            os.write(response.getBytes());
            os.close();
        }
    }

}
```

---

## Run your application locally

You can run your application by using the following steps:

1. Compile and package the Java project. Use the following command to compile the code:

   ```bash
   mvn clean package
   ```

1. Run the application. Use the following command to compile the code:

   ```bash
   java -jar target/hello-java-azure-1.0-SNAPSHOT.jar
   ```

   You should see the following output, which indicates that the server started:

   ```output
   Server started on http://localhost:8080/
   ```

1. Test your application. Open your web browser and go to: `http://localhost:8080/`.

   You should see the message: `Hello, World!` on your screen.
