Maven archetypes provide developers with the basic building blocks to create projects. There are a variety of archetypes available, and each different archetype provides specific functionality that developers can use in their application development. With that in mind, Microsoft has released an archetype to support working with Azure Functions: `azure-functions-archetype`.

In this unit, you'll learn what you need to get started with Maven archetypes. You'll see how you can use the `azure-functions-archetype` with Maven, and you'll explore creating a sample function.

## Getting started with Maven archetypes and Azure Functions

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

A Maven Project Object Model (POM) file is an XML-based configuration file that is part of your application's project files. POM files are named *pom.xml*, and they contain the definitions for each of the plugins that your application needs, including the required parameters and goals for each plugin.

For example, the Maven Clean Plugin has one goal, which is to remove the target directory for your project.

When building or deploying an Azure function using Maven, you'll need to make sure to include the `azure-functions-maven-plugin` into your *pom.xml* file. The details for adding that plugin to your *pom.xml* file are in the **Updating your *pom.xml* file** section of this unit.

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
| `-DarchetypeGroupId` | Specifies the group ID of the archetype; this is usually the creator of the archetype. |
| `-DarchetypeArtifactId` | Specifies the ID of the archetype; which is the Azure Functions archetype in this example. |

#### Using archetypes in batch mode

You could run Maven in batch mode, where you provide all of the requisite information that is necessary to generate your project on the command line. For example:

```bash
mvn archetype:generate -B \
  -DarchetypeGroupId="com.microsoft.azure" \
  -DarchetypeArtifactId="azure-functions-archetype" \
  -Dversion="1.0-SNAPSHOT" \
  -DgroupId="com.contoso.functions" \
  -DartifactId="event-reporting"
```

Where:

| Parameter | Description |
|---|---|
| `archetype:generate` | Instructs Maven to generate a project from an archetype. |
| `-B` | Instructs Maven to run in batch (non-interactive) mode. |
| `-DarchetypeGroupId` | Specifies the group ID of the archetype. |
| `-DarchetypeArtifactId` | Specifies the ID of the archetype itself. |
| `-Dversion` | Specifies the version of your project. |
| `-DgroupId` | Specifies the group ID of your project. |
| `-DartifactId` | Specifies the artifact ID of your project. |

Using Maven in batch mode is great for automating your build processes, because Maven will build your applications without human interaction.

#### Sepcifying archetypes versions

While you should usually try to use the latest version of an archetype, if you need to specify a different version, you can add the version number to the command line. For example:

```bash
mvn archetype:generate \
  -DarchetypeGroupId="com.microsoft.azure" \
  -DarchetypeArtifactId="azure-functions-archetype" \
  -DarchetypeVersion="1.26"
```

Where:

| Parameter | Description |
|---|---|
| `archetype:generate` | Instructs Maven to generate a project from an archetype. |
| `-DarchetypeGroupId` | Specifies the group ID of the archetypee. |
| `-DarchetypeArtifactId` | Specifies the ID of the archetype. |
| `-DarchetypeVersion` | Specifies the version of the archetype. |

## Updating your *pom.xml* file

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
         <version>1.3.2</version>
         <configuration>
             . . .
         </configuration>
      </plugin>
    </plugins>
  </build>
</project>
```

## Creating a basic function using the Azure Cloud Shell

You can create a basic Azure Function directly from within the Azure Cloud Shell. Azure ensures that all the required libraries are available to create and build your project, including Maven and the Azure Functions plugin.

The following steps illustrate the basic process for creating an Azure Function using the Cloud Shell:

1. From the Cloud Shell, run `mvn archetype:generate` command, where you'll specify the `azure-functions-archetype`.

1. Maven prompts you to enter the `groupId` for your application, which you'll enter in reverse domain format; for example: `com.microsoft.example`.

1. Maven prompts you to enter the name of the `artifactId` for your application, which should be a unique reference to your project; for example: `myapp`.

1. Maven might prompt you for other parameters, and you can accept the defaults values by pressing the Return/Enter key on your computer. Only the `groupId` and `artifactId` are necessary for now.

1. Maven creates a local Azure Function project for your. Once the `mvn archetype:generate` command has completed, you'll have a simple Java project that is ready to customize and build.

In the following exercise, you'll use this knowledge to create an Azure Function using Maven.
