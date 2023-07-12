Maven archetypes provide developers with the basic building blocks to create projects. There are a variety of archetypes available, and each different archetype provides specific functionality that developers can use in their application development. With that in mind, Microsoft has released an archetype to support working with Azure Functions: `azure-functions-archetype`.

In this unit, you'll learn what you need to get started with Maven archetypes. You'll see how you can use the `azure-functions-archetype` with Maven, and you'll explore creating a sample function.

## Getting started with Maven archetypes and Azure Functions

### Using Maven to automate building Java web apps

Maven is the most used Java build tool that can be used for building and managing any Java-based project. It helps streamline the processes for how developers build Java projects with a standard way to build the projects, a clear definition of what the project consisted of, an easy way to publish project information, and a way to share JARs across several projects. Maven's goals are to:

- Make the build process easier
- Transparently migrate to new features
- Provide a uniform build system
- Implement guidelines about best practice in development

As a Java developer, you're already familiar with using Maven to create and compile your applications. When you're setting up your development environment, you probably keep up with the latest versions of Maven. As you complete the exercises in this module, you'll use the Azure Cloud Shell in the Learn sandbox, which has all of the necessary pieces in place for you to build Java applications with Maven that are ready to deploy to Azure.

> [!NOTE]
>
>  If you were using your personal Azure account instead of the Cloud Shell in the Learn sandbox, you would need to make sure that you have the following items installed:
>  
>  | Item | Version |
>  |---|---|
>  | **Java JDK** | 1.8 |
>  | **Maven** | 3.0 or above |
>  | **Azure Functions Core Tools** | 2.7 or above |
>  

### What is the Maven plugin architecture

Maven is a framework for the execution of a series of plugins, and each Maven plugin has specific behaviors that are driven by the parameters that developers provide. For example, plugins govern whether to create a Web Application Archive (WAR) or Java Archive (JAR) file, how your code compiles, and running unit tests. Almost any action can be implemented through a Maven plugin.

Plugins define tasks as *goals*, and a plugin may have several goals. For example, the Maven Clean Plugin has one goal, which is to remove the target directory for your project.

A Maven Project Object Model (POM) file is an XML-based configuration file that is part of your application's project files. POM files are named *pom.xml*, and they contain the definitions for each of the plugins that your application needs, including the required parameters for each plugin.

When building or deploying an Azure function using Maven, you'll need to make sure to include the `azure-functions-maven-plugin` into your *pom.xml* file. The details for adding that plugin to your *pom.xml* file are in the **Using archetypes interactively** section of this unit.

### What are Maven archetypes?

In many ways, Maven archetypes are analogous to templates. An archetype is a model, or pattern, that you can use to speed up your development process. Archetypes can be customized using project-specific parameters, which you will provide during the generation process. Each archetype is built around best practices that can be configured to meet your organizational requirements.

#### Using archetypes interactively

To use Microsoft's archetype for Azure Functions to generate a project, you could use the `mvn archetype:generate` command, which enters the interactive mode that prompts you for values. For example:

```bash
mvn archetype:generate \
  -DarchetypeGroupId="com.microsoft.azure" \
  -DarchetypeArtifactId="azure-functions-archetype"
```

Where:

| Parameter | Description |
|---|---|
| `archetype:generate` | Instructs Maven to generate a project from an archetype. |
| `-DarchetypeGroupId` | Specifies the group ID of the archetype, which is usually the creator of the archetype. |
| `-DarchetypeArtifactId` | Specifies the ID of the archetype, which is the Azure Functions archetype in this example. |
| `-DjavaVersion=8` | Use `-DjavaVersion=11` if you want your functions to run on Java 11. |

When you create a project using the `mvn archetype:generate` command, Maven will create a folder for the project, and the root folder will contain your project's *pom.xml* file.

If you specify the `azure-functions-archetype` when you run the `mvn archetype:generate` command, your project's *pom.xml* file will have a section that contains the necessary information for the Azure Functions plugin. For example:

```xml
<project>
  . . .
  <build>
    . . .
    <plugins>
      . . .
        <plugin>
            <groupId>com.microsoft.azure</groupId>
            <artifactId>azure-functions-maven-plugin</artifactId>
            <version>${azure.functions.maven.plugin.version}</version>
            <configuration>
                <!-- function app name -->
                <appName>${functionAppName}</appName>
                <!-- function app resource group -->
                <resourceGroup>java-functions-group</resourceGroup>
                <!-- function app service plan name -->
                <appServicePlanName>java-functions-app-service-plan</appServicePlanName>
             . . .
         </configuration>
      </plugin>
    </plugins>
  </build>
</project>
```

### Creating a basic function using the Azure Cloud Shell

You can create a basic Azure Function directly from within the Azure Cloud Shell. Azure ensures that all the required libraries are available to create and build your project, including Maven and the Azure Functions plugin.

The following steps illustrate the basic process for creating an Azure Function using the Cloud Shell:

1. From the Cloud Shell, run `mvn archetype:generate` command, where you'll specify the `azure-functions-archetype`.

1. Maven prompts you to enter the `groupId` for your application, which you'll enter in reverse domain name format; for example: `com.microsoft.example`.

1. Maven prompts you to enter the name of the `artifactId` for your application, which should be a unique reference to your project; for example: `myapp`.

1. Maven might prompt you for other parameters, and you can accept the defaults values by pressing the Return/Enter key on your computer. Only the `groupId` and `artifactId` are necessary for now.

1. Maven creates a local Azure Function project. Once the `mvn archetype:generate` command has completed, you'll have a simple Java project that is ready to customize and build.

In the following exercise, you'll use this knowledge to create an Azure Function using Maven.
