## Create a simple Java web app

In this exercise, you create a minimal Java web application that serves a simple "Hello, Java on Azure!" message using Java 17 and Maven. This application runs on a built-in HTTP server and can be deployed to Azure App Service.

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
    -DgroupId=com.example \
    -DartifactId=hello-java-azure \
    -Dpackage=com.example \
    -DarchetypeArtifactId=maven-archetype-quickstart \
    -Dversion=1.0-SNAPSHOT \
    -DinteractiveMode=false
```

You should see the following output:

```output
[INFO] ----------------------------------------------------------------------------
[INFO] Parameter: basedir, Value: /home/ayangupta/LearnProjects/DeployHelloApp
[INFO] Parameter: package, Value: com.example
[INFO] Parameter: groupId, Value: com.example
[INFO] Parameter: artifactId, Value: hello-java-azure
[INFO] Parameter: packageName, Value: com.example
[INFO] Parameter: version, Value: 1.0-SNAPSHOT
[INFO] project created from Old (1.x) Archetype in dir: /home/ayangupta/LearnProjects/DeployHelloApp/hello-java-azure
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  1.657 s
[INFO] Finished at: 2024-10-18T12:39:41-07:00
[INFO] ------------------------------------------------------------------------
```

The following files and directories are now available:

```
└── hello-java-azure
    ├── .mvn
    │   ├── jvm.config
    │   └── maven.config
    ├── src
    │   ├── main
    │   │   └── java
    │   │       └── com
    │   │           └── example
    │   │               └── App.java
    │   └── test
    │       └── java
    │           └── com
    │               └── example
    │                   └── AppTest.java
    └── pom.xml
```

Use the following command to navigate to the generated project directory:

```bash
cd hello-java-azure
```

### Modify the Maven pom.xml file

Replace the contents of your **pom.xml** with the following code. This updated **pom.xml** configures Java 17 and creates an executable JAR with the application entry point in the manifest.

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="
            http://maven.apache.org/POM/4.0.0
            https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>hello-java-azure</artifactId>
    <version>1.0-SNAPSHOT</version>

    <name>hello-java-azure</name>
    <description>A simple Java web application without Spring</description>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <java.version>17</java.version>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
    </properties>

    <build>
        <plugins>
            <plugin>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.11.0</version>
                <configuration>
                    <release>${java.version}</release>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-shade-plugin</artifactId>
                <version>3.4.1</version>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>shade</goal>
                        </goals>
                        <configuration>
                            <transformers>
                                <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                                    <mainClass>com.example.HelloJavaAzureServer</mainClass>
                                </transformer>
                            </transformers>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
</project>
```

### Create the Main application class

The Maven archetype generates a sample test that refers to the original **App.java** class. Remove the generated test files because this module replaces the sample class with a web server:

```bash
rm -r src/test
```

Rename **App.java** to **HelloJavaAzureServer.java**:

```bash
mv src/main/java/com/example/App.java src/main/java/com/example/HelloJavaAzureServer.java
```

Edit **HelloJavaAzureServer.java** in the **src/main/java/com/example** directory to use the following code, which creates a simple HTTP server. The app reads the `PORT` environment variable that Azure App Service provides and uses port `8081` when you run it locally.

```java
package com.example;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;

public class HelloJavaAzureServer {

    public static void main(String[] args) throws IOException {
        int port = 8081;
        String portEnv = System.getenv("PORT");
        if (portEnv != null && !portEnv.isBlank()) {
            port = Integer.parseInt(portEnv);
        }

        HttpServer server = HttpServer.create(new InetSocketAddress(port), 0);
        server.createContext("/", new HelloHandler());
        server.setExecutor(null);
        server.start();
        System.out.println("Server started on port " + port);
    }

    static class HelloHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            byte[] response = "Hello, Java on Azure!".getBytes(StandardCharsets.UTF_8);
            exchange.sendResponseHeaders(200, response.length);

            try (OutputStream os = exchange.getResponseBody()) {
                os.write(response);
            }
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

1. Run the application. Use the following command:

   ```bash
   java -jar target/hello-java-azure-1.0-SNAPSHOT.jar
   ```

   You should see the following output, which indicates that the server started:

   ```output
   Server started on port 8081
   ```

1. Test your application. Open your web browser and go to: `http://localhost:8081/`.

   You should see the message: `Hello, Java on Azure!` on your screen.

1. When you're finished testing locally, stop the server by pressing `Ctrl+C` in the terminal where `java -jar` is running. If you open a new terminal for the deployment unit, change back to the `hello-java-azure` project directory before running the Maven or Azure CLI commands.
