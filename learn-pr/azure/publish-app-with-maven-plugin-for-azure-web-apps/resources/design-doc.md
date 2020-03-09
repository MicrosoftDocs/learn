# Design Document

- **Requestor**: robmcm@microsoft.com
- **Subject matter expert**: andxu@microsoft.com
- **Product team contact**: yucwan@microsoft.com

## Title

Publish a web app to Azure by using Maven Plugin for Azure App Service

## Role(s)

- Developer

## Level

- Beginner

## Product(s)

- [Azure Web Apps](https://azure.microsoft.com/services/app-service/web/)
- [Maven Plugin for Azure App Service](https://docs.microsoft.com/java/api/overview/azure/maven/azure-webapp-maven-plugin/readme)

## Prerequisites

- Knowledge of building and deploying Java web apps with Maven
- [Apache Maven](https://maven.apache.org/)

## Summary

Use the Maven plugin for Azure App Service to develop a Java web app and deploy the app to Azure.

## Learning objectives

1. Develop a Java web app
1. Configure the Maven plugin for Azure App Service
1. Deploy the app to using the Maven Plugin

## Chunk your content into subtasks

Identify the subtasks of *Publish a web app to Azure by using Maven Plugin forAzure App Service*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|---|---|---|---|---|
| Build a maven maven-archetype-webapp web app | your job is to create a simple web app | Exercise | 1 | Yes |
| Run the web app locally | your job is to create a simple web app | Exercise | 1 | Yes |
| Configure the Maven plugin for Azure App Service | researching how to integrate the Maven Plugin for Azure Web Apps | Exercise | 2 | Yes |
| Deploy the app to using the Maven Plugin | automate the build process and automatically publish the web app to Azure | Exercise | 3 | Yes |
| Make updates to the app, and redeploy it | automate the build process and automatically publish the web app to Azure | Exercise | 2,3 | Yes |

## Outline the units

*Add or remove units as needed for the content*

1. **Introduction**

    Your company uses Apache Maven to automate its build process for Java applications. Your company is migrating its web apps to Azure App Service, and you have been tasked with researching how to integrate the Maven Plugin for Azure Web Apps into your existing build automation. With that in mind, your job is to create a simple web app, and create the necessary syntax to automate the build process and automatically publish the web app to Azure.

1. **Create a Java web app**

    - Introduce Maven
    - Review archetypes, focusing on maven-archetype-webapp
    - Explain plugin architecture, reviewing the contents of pom.xml
    - Adding Tomcat to enable web app to run locally

1. **Exercise - create a Java web app**

    Using the Cloud Shell:

    1. Create a directory
    1. Run mvn archetype:generate -DgroupId=example.demo -DartifactId=helloworld -DarchetypeArtifactId=maven-archetype-webapp
    1. Use the `code` editor to review the pom.xml file, and the index.jsp files
    1. Add Tomcat plugin to the pom
    1. Run the app locally from the Cloud Shell with Tomcat

1. **Deploy your web app to Azure App Service**

    - Introduce Azure App Service
    - Explore the Maven plugin for Azure App Service
    - How to configure the Maven plugin to run your Tomcat web app
    - Automatic with azure-webapp:config, or manually

1. **Exercise - deploy your web app to Azure App Service**

    Using the Cloud Shell:

    1. Use `code` to edit **pom.xml** to add the azure-webapp-maven-plugin:

    ```xml
    <plugin>
        <groupId>com.microsoft.azure</groupId>
        <artifactId>azure-webapp-maven-plugin</artifactId>
        <version>1.7.0</version>
    </plugin>
    ```

    1. Run azure-webapp:config to configure the Azure App Service plugin
    2. Using `code` to view **pom.xml**
    3. Deploy the hello world web app to Azure App Service with `mvn package azure-webapp:deploy`
    4. Visit the deployed app

1. **Redeploy your web app to Azure App Service**

    - Explain the Maven workflow, `mvn clean`, `mvn package`, `mvn install`, etc.
    - Explore more configuration options for azure-webapp plugin, like `allowTelemetry` and `authentication`

1. **Exercise - redeploy your web app to Azure App Service**

    Using the Cloud Shell:

    1. Using `code` edit **pom.xml** to change the app name to Server Status
    1. Using `code` edit **index.jsp** to create a Server Status page (see the resources folder for the final app)
    1. Run the app locally Tomcat
    1. Redeploy the app with `mvn package azure-webapp:deploy`

1. **Summary**

    - Reviewed Maven for Java apps, the archetypes, and running web apps locally
    - Reviewed the azure webapp maven plugin, how to configure it, and use it to deploy apps to Azure App Service
    - Edited, tested the changes locally and redeployed the app to the Azure App Service
    
## Notes

Why would a customer use the technology; that is, what type of problem does it solve?
- Meet Java customers where they are at their favorite build tool: Maven (around 70% Java developers use Maven as build tool).
- Help java developers get started with Azure App Service and demonstrate deploying web apps to Azure App Service without learning Azure specific technologies like Azure CLI.

## Personal notes

Environment setup and commands:

- guide: https://docs.microsoft.com/en-gb/java/azure/eclipse/azure-toolkit-for-eclipse-create-hello-world-web-app
- guide: https://docs.microsoft.com/en-gb/azure/app-service/app-service-web-get-started-java 
- Create a directory
- run: mvn archetype:generate -DgroupId=example.demo -DartifactId=helloworld -DarchetypeArtifactId=maven-archetype-webapp
- cd helloworld
- Add Tomcat and azure plugins to pom.xml
- curl -X POST http://localhost:8888/openPort/8000
- Maven run Tomcat
- test locally for example, https://gateway14.westeurope.console.azure.com/n/cc-a351ff51/cc-a351ff51/proxy/8000/
- mvn package azure-webapp:deploy
- test on azure
