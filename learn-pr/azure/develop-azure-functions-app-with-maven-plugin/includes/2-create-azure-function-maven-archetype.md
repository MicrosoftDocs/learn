You've used Java and Maven for some time now. But you've not explored the Maven archetypes before.

A Maven archetype represents a specific type of functionality that you want your developers to get up to speed on fast. There are different archetypes to support different kinds of projects. Microsoft has released an archetype to support working with functions in Azure called the `azure-functions-archetype`.

In this unit, you'll understand what you need to get started. You'll learn what a Maven archetype is, focused on how you can use the `azure-functions-archetype`. You'll see how you can use the archetype with Maven, and you'll explore creating a sample application.

## Getting started with Maven archetypes

As a developer within your organization, you're familiar with using an IDE for your Java coding, compiling, and package your applications. You can also call Maven from the command line.

Before you get started building a Maven project, you need to check your development environment. Your project requires the following to be set up.

| Item | Version |
| ---- | ---- |
| **Java JDK** | 1.8 |
| **Maven** | 3.0 or above |
| **Azure Functions Core Tools** | 2.6.666 or above |

If you are going to use the Azure Cloud Shell to develop and deploy your function, it provides you with the latest versions of each these.

## What are Maven archetypes

An archetype is a model, or pattern, you can use to speed up the development process. Archetypes can be customized using project-specific parameters, which are requested during the generation process.

Each archetype is built around best practices and can be configured to meet your organizational requirements. Archetypes can be used to allow developers to quickly explore new features.

To use this archetype, use the following command:

```bash
mvn archetype:generate "-DarchetypeGroupId=com.microsoft.azure" "-DarchetypeArtifactId=azure-functions-archetype"
```

## What is the Maven plugin architecture

Maven is a framework for the execution of a series of plugins. Plugins govern whether to create a WAR or JAR file, how your code compiles, or running unit tests. Almost any action can be implemented through a Maven plugin.

Each plugin has a specific behavior that is driven by the parameters supplied when it's executed.

A Maven Project Object Model (POM) file holds the definition of each of the plugins, including the required parameters and any goals.

For example, the Clean plugin has one goal, which is to remove the target directory for your project.

When building or deploying an Azure function using Maven, you'll need to make sure to include the `azure-functions-maven-plugin` into your pom.xml file.

## Updating your pom.xml

Once the project has been created using the mvn archetype:generate command, you should check the pom.xml file. The file is in the root of the project folder created when you ran the generate step the archetype.

By default the archetype will have added the Azure Function plugin.

```xml
<project>
  ...
  <build>
    ...
    <plugins>
      ...
      <plugin>
         <groupId>com.microsoft.azure</groupId>
         <artifactId>azure-functions-maven-plugin</artifactId>
         <version>1.3.2</version>
         <configuration>
             ...
         </configuration>
      </plugin>
    </plugins>
  </build>
</project>
```

## Creating a basic function

You can create a basic function directly from within the Cloud Shell. Azure ensures that all the libraries required are available, including Maven and the plugin. From the  Cloud Shell, you'll run the `mvn archetype:generate` step. Maven will build a local Azure function for you. You'll be prompted to enter the name of the groupId, which would be a reverse domain, for example, com.contoso.funcs. You'll then enter the artifactId, which  should be a unique reference to the project, like javaFuncs. While there are a number of parameters, the first two are key. For the rest, you can accept the defaults values by pressing return.

Once the `mvn archetype:generate` step has completed, you'll have a simple Java project ready to build.
