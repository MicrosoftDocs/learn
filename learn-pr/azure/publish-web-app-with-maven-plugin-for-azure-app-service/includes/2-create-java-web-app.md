Your company is currently running several Java web apps on internal servers. To reduce the high costs that are associated with maintaining those servers, your company wants to migrate your web apps to Azure App Service.

Your development team has experience using Maven to create desktop apps, and you already use Maven to automate the build process for your Java projects. You understand that Maven uses plugins for projects to add extra functionality, and you want to use an archetype to create a web app that you can deploy to Azure App Service.

In this unit, you'll revisit how Maven and archetypes can help create Java web apps. You'll learn how to create a small Java web app and run it locally, then you'll see what to add to the Project Object Model (POM) file to enable local testing for your new app.

## Using Maven to automate building Java web apps

Maven is the most used Java build tool that can be used for building and managing any Java-based project. It helps streamline the processes for how developers build Java projects with a standard way to build the projects, a clear definition of what the project consisted of, an easy way to publish project information, and a way to share JARs across several projects. Maven's goals are to:

- Make the build process easier
- Transparently migrate to new features
- Provide a uniform build system
- Implement guidelines about best practice in development

### What are archetypes?

The creators of Maven needed a way to provide a consistent best practice to follow when developers structure new projects, and they discovered that there are several similarities between different kinds of projects. The creators used this information to define these project types as templates - called _archetypes_ - which Maven uses to create the scaffolding for new projects quickly. Here are several examples of common archetypes:

| Archetype | Description |
|---|---|
| `maven-archetype-archetype` | Generates an archetype project |
| `maven-archetype-mojo`  | Generates a sample Maven plugin |
| `maven-archetype-plugin`  | Generates a Maven plugin |
| `maven-archetype-plugin-site` | Generates a Maven plugin site |
| `maven-archetype-quickstart`  | Generates a Maven project  |
| `maven-archetype-simple`  | Generates a simple Maven project |
| `maven-archetype-site`  | Generates a Maven site that demonstrates some of the supported document types like APT, XDoc, and FML |
| `maven-archetype-site-simple` | Generates a simple Maven site |
| **`maven-archetype-webapp`** |  Generates a Maven web app project |

In the next exercise, you'll create a web app that you can deploy to Azure. For example, to create a new Java web app using Maven, you would use the following syntax:

```bash
mvn archetype:generate \
  -DgroupId=com.microsoft.example \
  -DartifactId=MyWebApp \
  -DarchetypeArtifactId=maven-archetype-webapp \
  -DinteractiveMode=false
```

Running the above command creates a project directory structure with these contents:

:::image type="content" source="../media/2-project-tree.png" alt-text="Project folder and file hierarchy." loc-scope="other"::: <!-- no-loc -->

[//]: # (NOTE: The following code is used to generate the preceding image)

[//]: # (<p><big><nobr><strong>project</strong><br/>&#xA0;&#xA0;&#xA0;&#x251C;&#x2500;&#x2500;&#xA0;<em>pom.xml</em><br/>&#xA0;&#xA0;&#xA0;&#x2514;&#x2500;&#x2500;&#xA0;<strong>src</strong><br/>&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#x2514;&#x2500;&#x2500;&#xA0;<strong>main</strong><br/>&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#x2514;&#x2500;&#x2500;&#xA0;<strong>webapp</strong><br/>&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#x251C;&#x2500;&#x2500;&#xA0;<em>index.jsp</em><br/>&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#x2514;&#x2500;&#x2500;&#xA0;<strong>WEB-INF</strong><br/>&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#x2514;&#x2500;&#x2500;&#xA0;<em>web.xml</em></nobr></big></p>)

### What are Project Object Model (POM) files?

One of the core components of a Maven project is a Project Object Model (POM) file, which is an XML document named `pom.xml` that resides in the directory tree of a project. The POM file contains the properties, dependencies, build phases, plugins, and goals for a project. When you build your application, Maven will take care of the managing the dependencies for you.

Maven is built on a plugin framework, and adding plugins to a POM file is how developers define goals for their projects. When you run Maven, you can execute a specific goal by using the syntax `mvn [plugin-name]:[goal-name]`, and Maven will run all of the goals up to the `[goal-name]` that you specify.

The following example illustrates the `pom.xml` file contents that were generated by the `mvn archetype:generate` command with the `maven-archetype-webapp` archetype in the preceding section of this unit.

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.microsoft.example</groupId>
  <artifactId>MyWebApp</artifactId>
  <packaging>war</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>MyWebApp Maven Webapp</name>
  <url>http://maven.apache.org</url>
  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>3.8.1</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
  <build>
    <finalName>MyWebApp</finalName>
  </build>
</project>
```

### How to add plugins to a Maven project

To add a plugin to your Maven project, you need to add the specific XML for that plugin to the `pom.xml` file. There are two useful plugins that allow developers to run web apps locally on their machines: _Eclipse Jetty_ and _Apache Tomcat_. Both of these web servers are supported by the Azure App Service plugin. To add one of these servers to your project, you would add the requisite XML for the plugin to the `<build>` tag.

For example, to add the Tomcat plugin, you would add XML like the following example:

```xml
<plugins>
  <plugin>
    <groupId>org.apache.tomcat.maven</groupId>
    <artifactId>tomcat7-maven-plugin</artifactId>
    <version>2.2</version>
  </plugin>
</plugins>  
```
> [!NOTE]
> To find a plugin and its related information, you can search the Central Repository at <https://search.maven.org/>.)

When you add the XML for the Tomcat plugin to your `pom.xml` file, it should resemble the following example:

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.microsoft.example</groupId>
  <artifactId>MyWebApp</artifactId>
  <packaging>war</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>MyWebApp Maven Webapp</name>
  <url>http://maven.apache.org</url>
  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>3.8.1</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
  <build>
    <finalName>MyWebApp</finalName>
    <plugins>
      <plugin>
        <groupId>org.apache.tomcat.maven</groupId>
        <artifactId>tomcat7-maven-plugin</artifactId>
        <version>2.2</version>
      </plugin>
    </plugins>  
  </build>
</project>
```

After you've added the Tomcat plugin to your project, you can use the following Maven command to start the Tomcat server and test your web app:

```bash
mvn tomcat7:run
```

This command builds your app, starts a Tomcat server on the default port of 8080, and loads the `index.jsp` page from your project's `src\webapp` folder.

In the next exercise, you'll create a Java web app using Maven.
