You've been tasked with creating a simple Aapplication using the JavaServer Facess framework. 
The TODO application can add the new tasks and you can see the lists of all tasks and finally you can mark the task as finished.
As part of that evaluation in this module, you will build a web application and deploy it to Linux on Azure App Service Tomcat.

## Create a Simple JSF Web app on Tomcat

In the exercise, we will create a Maven Project for Java Web Application. After created the project, we need configure three configurations as follows. First one is to add the dependency libraries to pom.xml file. Second is to create a CDI configuration file as beans.xml to use the CDI. Third is to configure the JSF on web.xml file. After the configurations, we will be able to create a simple JSF Web Page and create the Backing Bean for server side backend operation. Finally, we will be able to evaluate it on local Tomcat environment.
This is the standard operation for creating and evaluating the Java Web Project on local environment and you can confirm it in this section.

### Creating Maven project

Execute the following command. This will create a Maven project for your Java web application. We specified the architect type as `maven-archetype-webapp` which is provided by Maven to create a Maven Webapp project.

   ```bash
   mvn archetype:generate \
   -DgroupId=com.microsoft.azure.samples \
   -DartifactId=azure-javaweb-app \
   -DarchetypeArtifactId=maven-archetype-webapp \
   -Dversion=1.0-SNAPSHOT \
   -DinteractiveMode=false
   ```

After executed the above command, you will see following result.

   ```text
   [INFO] Parameter: package, Value: com.microsoft.azure.samples
   [INFO] Parameter: groupId, Value: com.microsoft.azure.samples
   [INFO] Parameter: artifactId, Value: azure-javaweb-app
   [INFO] Parameter: packageName, Value: com.microsoft.azure.samples
   [INFO] Parameter: version, Value: 1.0-SNAPSHOT
   [INFO] project created from Old (1.x) Archetype in dir: /private/tmp/TMP/azure-javaweb-app
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD SUCCESS
   [INFO] ------------------------------------------------------------------------
   [INFO] Total time:  5.416 s
   [INFO] Finished at: 2020-11-02T11:12:58+09:00
   [INFO] ------------------------------------------------------------------------
   ```

When you create a Maven project, the following files and directories will be created.

   ```xml
├── pom.xml
└── src
    └── main
        ├── resources
        └── webapp
            ├── WEB-INF
            │   └── web.xml
            └── index.jsp
   ```

### Modify Maven pom.xml File

The Web application created the above will use the JavaServer Faces framework. Therefore, in order to use JSF, you need to add the following dependency libraries into the project.

Modify the `pom.xml` file as follows.
Replace below XML configurations by copy and paste.

   ```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.microsoft.azure.samples</groupId>
  <artifactId>azure-javaweb-app</artifactId>
  <packaging>war</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>azure-javaweb-app Maven Webapp</name>
  <url>http://maven.apache.org</url>
  <properties>
    <maven.compiler.source>8</maven.compiler.source>
    <maven.compiler.target>8</maven.compiler.target>
    <failOnMissingWebXml>false</failOnMissingWebXml>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
  </properties>
  <dependencies>
    <dependency>
      <groupId>javax.servlet</groupId>
      <artifactId>javax.servlet-api</artifactId>
      <version>4.0.1</version>
      <scope>provided</scope>
    </dependency>
    <dependency>
      <groupId>org.glassfish</groupId>
      <artifactId>javax.faces</artifactId>
      <version>2.4.0</version>
    </dependency>
    <dependency>
      <groupId>org.primefaces</groupId>
      <artifactId>primefaces</artifactId>
      <version>8.0</version>
    </dependency>
    <dependency>
      <groupId>org.jboss.weld.servlet</groupId>
      <artifactId>weld-servlet</artifactId>
      <version>2.4.8.Final</version>
    </dependency>
    <dependency>
      <groupId>org.projectlombok</groupId>
      <artifactId>lombok</artifactId>
      <version>1.18.12</version>
      <scope>provided</scope>
    </dependency>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.12</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>org.mockito</groupId>
      <artifactId>mockito-core</artifactId>
      <version>2.23.0</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
  <build>
    <finalName>azure-javaweb-app</finalName>
  </build>
</project>
   ```

If you would like to use the Java SE 11 instead of Java 8, please modify the following entry.

   ```xml
    <maven.compiler.source>11</maven.compiler.source>
    <maven.compiler.target>11</maven.compiler.target>
   ```

### Enable Contexts and Dependency Injection (CDI)

Next, make CDI available to your web application.
Create a `beans.xml` file under the `src/main/WEB-INF` directory and describe the following contents.

   ```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://xmlns.jcp.org/xml/ns/javaee"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/beans_1_1.xsd"
  bean-discovery-mode="all">
</beans>
   ```

### Enable JSF

Next, in order to recognize all files with the `xhtml` extension as JSF Facelets, make the following settings for `web.xml` under the `WEB-INF` directory.

   ```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app version="4.0" xmlns="http://xmlns.jcp.org/xml/ns/javaee" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd">

  <servlet>
    <servlet-name>Faces Servlet</servlet-name>
    <servlet-class>javax.faces.webapp.FacesServlet</servlet-class>
    <load-on-startup>1</load-on-startup>
  </servlet>

  <context-param>
    <param-name>primefaces.THEME</param-name>
    <param-value>nova-light</param-value>
  </context-param>

  <servlet-mapping>
    <servlet-name>Faces Servlet</servlet-name>
    <url-pattern>*.xhtml</url-pattern>
  </servlet-mapping>

  <welcome-file-list>
    <welcome-file>index.xhtml</welcome-file>
  </welcome-file-list>
</web-app>
   ```

### Modify the name of index.jsp

Now that the environment settings for running JSF have been completed, it is time to create the JSF page.
JSF web pages are written in XHTML file format instead of JSP, as set in `web.xml` above. Therefore, change the name of the `index.jsp` file that was automatically generated when the project was created to `index.xhtml`.

   ```bash
mv index.jsp index.xhtml
   ```

### Creating a Basic Web Page for JSF

Please delete all the contents described in `index.xhtml` once and paste the following code by copy and paste.

   ```xml
<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:h="http://xmlns.jcp.org/jsf/html" xmlns:p="http://primefaces.org/ui">
<h:head>
    <title>Input Value Counter Sample</title>
</h:head>
<h:body>
    <h:form>
        <p:outputLabel value="Basic" /><br />
        <p:inputText value="#{indexcontroller.inputValue}" /><br />
        <p:commandButton update="ajaxUpdateText" value="Submit" action="#{indexcontroller.submitButtonAction()}" />
        <br />
        <p:outputLabel id="ajaxUpdateText" value="Input Value: #{indexcontroller.inputValue}" /><br />
    </h:form>
</h:body>
</html>
   ```

### Create JSF Backing Bean

Next, create a backing bean to implement server-side backend processing.
Create a new directory for Java package which will use to create the backing bean under the `src/main` directory.

```bash
mkdir src/main/java
mkdir src/main/java/com
mkdir src/main/java/com/microsoft/azure
mkdir src/main/java/com/microsoft/azure/samples
```

Then create a `IndexController.java` file and copy and paste the JSF Backing Bean code below.

```java
package com.microsoft.azure.samples;
import java.io.Serializable;

import javax.faces.view.ViewScoped;
import javax.inject.Named;
import lombok.Getter;
import lombok.Setter;

@Named("indexcontroller")
@ViewScoped
public class IndexController implements Serializable{

    private static final long serialVersionUID = 8485377386286855408L;

    @Setter @Getter
    private String inputValue;

    private int counter;

    public void submitButtonAction(){
        inputValue = inputValue + " : " + counter;
        counter++;
    }
}
```

This completes the program implementation.
The directory structure after implementing the program is as follows.

```text
├── pom.xml
└── src
    └── main
        ├── java
        │   └── com
        │       └── microsoft
        │           └── azure
        │               └── samples
        │                   └── IndexController.java
        ├── resources
        └── webapp
            ├── WEB-INF
            │   ├── beans.xml
            │   └── web.xml
            └── index.xhtml
```

### Run in local tomcat environment

Compile the source code and run it in a locally installed Tomcat environment.
Execute the following command.

#### Compile and Package the Java Project

Execute the following command to compile the code.

```bash
mvn clean package
```

#### Copy the artifact to the Deployment Directory on Tomcat

Copy the artifact war file to the directory in the Tomcat.

```bash
cp target/azure-javaweb-app.war /$INSTALL_DIR/apache-tomcat-9.0.39/webapps/
```

#### Start the Tomcat Server

Start the Tomcat Server.

```bash
$INSTALL_DIR/apache-tomcat-9.0.39/bin/startup.sh
```

After running Tomcat, access `http://localhost:8080/azure-javaweb-app/` and you will see the screen below.

:::image type="content" source="../media/jsf-helloworld.png" alt-text="JSF HelloWorld Page":::

You have successfully run your JSF web application in your local Tomcat environment.
