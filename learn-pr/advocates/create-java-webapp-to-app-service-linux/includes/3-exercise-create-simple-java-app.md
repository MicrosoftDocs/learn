Web applications are widely used to handle real-world tasks such as inventory management, online forms, and customer-facing portals. In this module, you learn how to create and deploy a Java web application using Apache Tomcat, a popular open-source server.

Suppose you're a developer working on a project to build a dynamic web application where users can enter data and interact with your platform in real time. Your client wants this app to be available locally for testing, and on the cloud for easy access. This setup lets you test on your local machine first, and then deploys to a live environment as a seamless transition. Building this setup from scratch gives you flexibility for future updates and configurations.

In this module, you explore the essential steps for building and deploying a Java web app with Tomcat. You have two options: either clone an existing project repo for immediate deployment, or build a new project from scratch with Maven. This module covers setting up your Maven project, configuring Tomcat, deploying the app locally, and using tools like Maven to manage dependencies and packages.

By the end of this module, you'll be able to create and deploy Java-based web applications on Tomcat, preparing you to support web application deployment both locally and in cloud-hosted environments.

## Create a Java Tomcat web app

In this exercise, you create a minimal Java web application that takes an input and displays the result on the screen. You then deploy the web app locally on your computer using Tomcat. You have the following two options:

- Option 1: Clone the sample repo and immediately deploy your web app.
- Option 2: Create a Maven Tomcat project from scratch.

## Option 1: Clone the sample repo and immediately deploy your web app

To clone the repo, use the following steps:

1. Clone the sample project repo by using the following command:

    ```bash
    git clone https://github.com/MicrosoftDocs/simple-tomcat-maven-app.git

1. Navigate to the cloned project repo by using the following command:

    ```bash
    cd simple-tomcat-app
    ```

Use the following steps to configure your local Tomcat server so you can deploy locally to Tomcat:

> [!WARNING]
> Storing usernames and passwords directly in configuration files like **tomcat-users.xml** and Maven's **settings.xml** in plain text isn't considered secure, and we generally don't recommend this practice - especially for production environments. However, other alternatives are outside the scope of this training module. Don't use your real username and password!

1. Edit the Tomcat configuration file **conf/tomcat-users.xml** so that it looks like the following example:

    ```xml
    <tomcat-users>
        <user username="your-tomcat-username" password="your-tomcat-password" roles="manager-script"/>
    </tomcat-users>
    ```

1. Add your credentials to the Maven **~/.m2/settings.xml** file by using the following example, where you replace `your-tomcat-username` with a username, and `your-tomcat-password` with a password:

    ```xml
    <servers>
        <server>
            <id>TomcatServer</id>
            <username>your-tomcat-username</username>
            <password>your-tomcat-password</password>
        </server>
    </servers>
    ```

1. Use the following command to package and deploy your web app:

    ```bash
    mvn clean package cargo:deploy
    ```

After deployment, you can access your app at `http://localhost:8080/simple-tomcat-app`.

## Option 2: Create a Maven Tomcat project from scratch

To create a Maven Tomcat project from scratch, you work through multiple procedures, starting from creating the Maven project, and ending with deploying your web app to Tomcat.

### Create a Maven project

To create a Maven project for your Java web application, use the following command:

```bash
mvn archetype:generate \
    -DgroupId=com.example \
    -DartifactId=simple-tomcat-app \
    -DarchetypeArtifactId=maven-archetype-webapp \
    -DinteractiveMode=false
```

The following output is typical:

```output
[INFO] ----------------------------------------------------------------------------
[INFO] Parameter: basedir, Value: /home/XXXXXXXX/LearnProjects/simple-tomcat-maven-app
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

You now have a new Maven web project in a folder named **simple-tomcat-app**. The following files and directories are now available:

```
└── simple-tomcat-app
    ├── pom.xml
    └── src
        ├── main
        │   ├── java
        │   ├── resources
        │   └── webapp
        │       ├── index.jsp
        │       └── WEB-INF
        │           └── web.xml
        └── test
            ├── java
            └── resources
```

### Modify the Maven pom.xml file

Modify the **pom.xml** file by using the following steps:

1. Open **pom.xml** and set the Java version to 21 by using the following example:

    ```xml
    <java.version>21</java.version>
    <maven.compiler.source>21</maven.compiler.source>
    <maven.compiler.target>21</maven.compiler.target>
    ```

1. Add Tomcat and Azure deployment plugins by using the following example:

    ```xml
    <!-- Tomcat 10 Maven Plugin -->
    <plugin>
      <groupId>org.codehaus.cargo</groupId>
      <artifactId>cargo-maven3-plugin</artifactId>
      <version>1.9.9</version>
      <configuration>
        <!-- Container Configuration -->
        <container>
          <containerId>tomcat10x</containerId>
          <type>remote</type>
        </container>
        <!-- Configuration for Remote Deployment -->
        <configuration>
          <type>runtime</type>
          <properties>
            <cargo.remote.uri>http://localhost:8080/manager/text</cargo.remote.uri>
            <cargo.remote.username>cargo</cargo.remote.username>
            <cargo.remote.password>your-cargo-password</cargo.remote.password>
          </properties>
        </configuration>
        <!-- Deployable Artifact Configuration -->
        <deployables>
          <deployable>
            <groupId>${project.groupId}</groupId>
            <artifactId>${project.artifactId}</artifactId>
            <type>war</type>
            <properties>
              <context>${project.artifactId}</context>
            </properties>
          </deployable>
        </deployables>
      </configuration>
    </plugin>
    ```

Here's the full content of the **pom.xml** file:

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.example</groupId>
  <artifactId>simple-tomcat-app</artifactId>
  <version>1.0-SNAPSHOT</version>
  <packaging>war</packaging>
  <name>simple-tomcat-app</name>
  <properties>
    <java.version>21</java.version>
    <maven.compiler.source>21</maven.compiler.source>
    <maven.compiler.target>21</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>
  <dependencies>
    <dependency>
      <groupId>jakarta.servlet</groupId>
      <artifactId>jakarta.servlet-api</artifactId>
      <version>6.0.0</version>
      <scope>provided</scope>
    </dependency>
  </dependencies>
  <build>
    <finalName>simple-tomcat-app</finalName>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.10.1</version>
        <configuration>
          <source>${java.version}</source>
          <target>${java.version}</target>
        </configuration>
      </plugin>
      <!-- Tomcat 10 Maven Plugin -->
      <plugin>
        <groupId>org.codehaus.cargo</groupId>
        <artifactId>cargo-maven3-plugin</artifactId>
        <version>1.9.9</version>
        <configuration>
          <!-- Container Configuration -->
          <container>
            <containerId>tomcat10x</containerId>
            <type>remote</type>
          </container>
          <!-- Configuration for Remote Deployment -->
          <configuration>
            <type>runtime</type>
            <properties>
              <cargo.remote.uri>http://localhost:8080/manager/text</cargo.remote.uri>
              <cargo.remote.username>cargo</cargo.remote.username>
              <cargo.remote.password>your-cargo-password</cargo.remote.password>
            </properties>
          </configuration>
          <!-- Deployable Artifact Configuration -->
          <deployables>
            <deployable>
              <groupId>${project.groupId}</groupId>
              <artifactId>${project.artifactId}</artifactId>
              <type>war</type>
              <properties>
                <context>${project.artifactId}</context>
              </properties>
            </deployable>
          </deployables>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>
```

### Create a web interface

To add a web page, edit the **src/main/webapp/index.jsp** file by using the following example:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Simple Tomcat App</title>
</head>
<body>
    <h1>Welcome to the Simple Tomcat App</h1>
    <form action="hello" method="get">
        <label for="name">Enter your name:</label>
        <input type="text" id="name" name="name">
        <button type="submit">Submit</button>
    </form>
</body>
</html>
```

### Create a servlet

A servlet is a Java programming class used to extend the capabilities of a server by handling requests and generating dynamic content. Servlets run on the server side within a web container - such as Apache Tomcat - and are primarily used to process HTTP requests in web applications. When a client - for example, a web browser - sends a request to a web server, the servlet processes the request. The servlet performs any necessary business logic - for example, accessing databases or calling other services - and then generates a response - often in the form of HTML - to send back to the client. Servlets enable developers to create dynamic, platform-independent web applications using Java.

To create a servlet, use the following steps:

1. Update the file structure to add a servlet by using the following command:

    ```bash
    mkdir -p src/main/java/com/example && touch src/main/java/com/example/HelloServlet.java
    ```

1. Update the contents of the **HelloSeverlet.java** file by using the following code example:

    ```java
    package com.example;

    import jakarta.servlet.ServletException;
    import jakarta.servlet.annotation.WebServlet;
    import jakarta.servlet.http.HttpServlet;
    import jakarta.servlet.http.HttpServletRequest;
    import jakarta.servlet.http.HttpServletResponse;

    import java.io.IOException;

    @WebServlet("/hello")
    public class HelloServlet extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String name = request.getParameter("name");
            response.setContentType("text/html");
            response.getWriter().write("<h1>Hello, " + name + "!</h1>");
        }
    }
    ```

Your new file structure looks like this:

```
└── simple-tomcat-app
    ├── pom.xml
    └── src
        ├── main
        │   ├── java
        │   │   └── com
        │   │       └── example
        │   │           └── HelloServlet.java
        │   ├── resources
        │   └── webapp
        │       ├── index.jsp
        │       └── WEB-INF
        │           └── web.xml
        └── test
            ├── java
            └── resources
```

### Deploy locally to Tomcat

Use the following steps to configure your local Tomcat server so you can deploy to it:

> [!WARNING]
> Storing usernames and passwords directly in configuration files like **tomcat-users.xml** and Maven's **settings.xml** in plain text isn't secure and isn't generally recommended, especially for production environments. However, other alternatives are outside the scope of this training module. Don't use your real username and password!

1. Edit the Tomcat configuration file **conf/tomcat-users.xml** by using the following example:

    ```xml
    <tomcat-users>
        <user username="your-tomcat-username" password="your-tomcat-password" roles="manager-script"/>
    </tomcat-users>
    ```

1. Add your credentials to Maven's **~/.m2/settings.xml** file by using the following example, replacing `your-tomcat-username` with a username and `your-tomcat-password` with a password:

    ```xml
    <servers>
        <server>
            <id>TomcatServer</id>
            <username>your-tomcat-username</username>
            <password>your-tomcat-password</password>
        </server>
    </servers>
    ```

### Deploy your web app to Tomcat

Use the following command to package and deploy your web app:

```bash
mvn clean package cargo:deploy
```

After deployment, your app is available at `http://localhost:8080/simple-tomcat-app`.
