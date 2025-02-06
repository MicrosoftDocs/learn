Web applications are widely used to handle real-world tasks such as inventory management, online forms, and customer-facing portals. In this module, you'll learn to create and deploy a simple Java web application using Apache Tomcat, a popular open-source server.

Suppose you're a developer working on a project to build a dynamic web application where users can enter data and interact with your platform in real time. Your client wants this app to be available locally for testing, as well as on the cloud for easy access. This setup lets you test on your local machine first, then deploy to a live environment as a seamless transition. Building this setup from scratch gives you flexibility for future updates and configurations.

In this module, you’ll explore the essential steps for building and deploying a Java web app with Tomcat. You’ll have two options: either clone an existing project from Azure Samples for immediate deployment or build a new project from scratch with Maven. Topics include setting up your Maven project, configuring Tomcat, deploying the app locally, and using tools like Maven to manage dependencies and packages.

By the end of this module, you’ll be able to create and deploy Java-based web applications on Tomcat, preparing you to support web application deployment both locally and in cloud-hosted environments.

## Create a simple Java Tomcat web app 

In this exercise, we'll create a minimal Java web application that will take an input and display the result on the screen. We will then deploy it locally on our conputer using Tomcat.
You have two options in this module 
1. **Option 1:** Clone the Repo from Azure Samples and Directly Jump to Deploying Your Web App 
2. **Option 2:** Create a Maven Tomcat Project from Scratch 

## Option 1: Clone the Repo from Azure samples and directly jump to deploying your web app 

### Clone Project Repo from Azure Samples 
Within your directory of choice clone the sample project repo: 

```bash
git clone https://github.com/MicrosoftDocs/simple-tomcat-maven-app.git
```

Now navigate to inside the cloned project repo:

```bash
cd simple-tomcat-app
```
### Deploy locally to Tomcat: configure local Tomcat server
> [!WARNING]
> Storing usernames and passwords directly in configuration files like tomcat-users.xml and Maven's settings.xml in plaintext is not considered secure and is generally not recommended, especially for production environments. However, as this is just a learn module, other alternatives are outside the scope of this module. Do not use your real username and password!

Edit the Tomcat configuration file `conf/tomcat-users.xml`:

```xml
<tomcat-users>
    <user username="your-tomcat-username" password="your-tomcat-password" roles="manager-script"/>
</tomcat-users>
```

Add your credentials to Maven's `settings.xml` in `~/.m2/settings.xml`:

```xml
<servers>
    <server>
        <id>TomcatServer</id>
        <username>your-tomcat-username</username>
        <password>your-tomcat-password</password>
    </server>
</servers>
```
Replace `your-tomcat-username` with a username and `your-tomcat-password`with a password. 


### Deploy your web app to Tomcat 
Run the following command to package and deploy your web app: 

```bash
mvn clean package cargo:deploy
```

Success! Your app will be available at `http://localhost:8080/simple-tomcat-app`.


 
## Option 2: Create a Maven Tomcat project from scratch 


### Create a Maven project

Execute the following Maven archetype command. This command will create a Maven project for your Java web application.

   ```bash
   mvn archetype:generate\
    -DgroupId=com.example\
    -DartifactId=simple-tomcat-app\
    -DarchetypeArtifactId=maven-archetype-webapp\
    -DinteractiveMode=false
   ```

You'll see the following output:

   ```text
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

This creates a new Maven web project in a folder named `simple-tomcat-app`.
The following files and directories are now available.

   ```xml
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
   Open the `pom.xml` file and make the following updates:

   Set the Java version to 21.
  ```xml
       <java.version>21</java.version>
       <maven.compiler.source>21</maven.compiler.source>
       <maven.compiler.target>21</maven.compiler.target>
  ```
  Add Tomcat and Azure deployment plugins.
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

   Here’s the full content of the `pom.xml`:

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

### Create a simple web interface 
Edit `index.jsp` in the `src/main/webapp/index.jsp` directory to add a simple web page.

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

## Create a Servlet 
A servlet is a Java programming class used to extend the capabilities of a server by handling requests and generating dynamic content. Servlets run on server-side within a web container (such as Apache Tomcat) and are primarily used to process HTTP requests in web applications. When a client (like a web browser) sends a request to a web server, the servlet processes the request, performs any necessary business logic (like accessing databases or calling other services), and generates a response—often in the form of HTML—to send back to the client. Servlets enable developers to create dynamic, platform-independent web applications using the Java programming language.

Update file structure to add Servlet: 
```bash
mkdir -p src/main/java/com/example && touch src/main/java/com/example/HelloServlet.java
```

Update the contents of HelloSeverlet.java

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

    Your new file structure will look like this: 
    
```xml
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

### Deploy locally to Tomcat: configure local Tomcat server
> [!WARNING]
> Storing usernames and passwords directly in configuration files like tomcat-users.xml and Maven's settings.xml in plaintext is not considered secure and is generally not recommended, especially for production environments. However, as this is just a learn module, other alternatives are outside the scope of this module. Do not use your real username and password!

Edit the Tomcat configuration file `conf/tomcat-users.xml`:

```xml
<tomcat-users>
    <user username="your-tomcat-username" password="your-tomcat-password" roles="manager-script"/>
</tomcat-users>
```

Add your credentials to Maven's `settings.xml` in `~/.m2/settings.xml`:

```xml
<servers>
    <server>
        <id>TomcatServer</id>
        <username>your-tomcat-username</username>
        <password>your-tomcat-password</password>
    </server>
</servers>
```
Replace `your-tomcat-username` with a username and `your-tomcat-password`with a password. 


### Deploy your web app to Tomcat 
Run the following command to package and deploy your web app: 

```bash
mvn clean package cargo:deploy
```

Success! Your app will be available at `http://localhost:8080/simple-tomcat-app`.
