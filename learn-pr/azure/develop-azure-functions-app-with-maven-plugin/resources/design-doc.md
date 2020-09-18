# Design Document

- **Requestor**: robmcm@microsoft.com 
- **Subject matter expert**: andxu@microsoft.com
- **Product team contact**: yucwan@microsoft.com

## Title

Develop your Azure Functions App by using Maven Plugin for Azure Functions

## Role(s)

- Developer

## Level

- Beginner

## Product(s)

- [Azure Functions](https://azure.microsoft.com/services/functions/)
- [Maven Plugin for Azure Functions](https://docs.microsoft.com/java/api/overview/azure/maven/azure-functions-maven-plugin/readme)

## Prerequisites

- [Apache Maven](https://maven.apache.org/)

## Summary

Use the Maven Plugin for Azure Functions to create a function project, run the function locally, and deploy the function to Azure.

## Learning objectives

Use the Maven Plugin for Azure Functions to:

1. Generate a function archetype / Create a function project
1. Run the function locally
1. Deploy the function to Azure
1. Make changes and redeploy

## Chunk your content into subtasks

Identify the subtasks of *Develop your Azure Functions App by using Maven Plugin for Azure Functions*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|---|---|---|---|---|
| Create a function project | Your company has been researching how to create serverless functions in Azure | Exercise | 1 | Yes |
| Run the function locally | You have been tasked with creating cloud-based function | Exercise | 2 | Yes |
| Deploy the function to Azure |  Use the Maven plugin goal to deploy to Azure | Exercise | 3 | Yes |
| Make changes and redeploy | You have been tasked with creating cloud-based function | Exercise | 4 | Yes |

## Outline the units

1. **Introduction**

    Your company uses Java as its primary development language, and your company has been researching how to create serverless functions in Azure in order to simplify event reporting. You have been tasked with creating a cloud-based function that is triggered when certain values are passed in the HTTP request, and outputs a log entry to track the activity. You will need to scaffold your Azure function with the Azure plugin for Maven, and then use the Maven plugin goal to deploy to Azure.

1. **Create an Azure function using the Maven archetype**

    - Discuss the prerequisites required to create a maven function
    - Review archetypes, focusing on azure-functions-archetype
    - Explain plugin architecture, reviewing the changes `azure-functions-maven-plugin` needed to pom.xml
    - Show how to create a function from scratch, or add a function to a package with mvn azure-functions:add

1. **Exercise - create an Azure function using the Maven archetype**

    Using the Cloud Shell:

    1. Check the prerequisites in the Cloud Shell
    1. Create a directory
    1. Run: mvn archetype:generate -DarchetypeGroupId=com.microsoft.azure -DarchetypeArtifactId=azure-functions-archetype
    1. Complete setup
    1. Enable extensions bundle in `host.json`

1. **Run and test an Azure function locally**

    - Explain how Azure Functions Core Tools lets you run and test functions locally
    - Open 7071 port with `curl -X POST http://localhost:8888/openPort/7071`
    - Run the java function in the Cloud Shell with mvn azure-functions:run
    - View https://gateway12.northeurope.console.azure.com/n/cc-b1b1d78b/cc-b1b1d78b/proxy/7071/api/HttpTrigger-Java?name=yoyo in a browser (curl doesn't work running from the Cloud Shell)

1. **Exercise - run and test an Azure function locally**

    Using the Cloud Shell:

    1. Run `curl -X POST http://localhost:8888/openPort/7071` copy returned URL
    1. Run `mvn clean package`
    1. Run `mvn azure-functions:run`
    1. Open a new browser tab for example, https://gateway12.northeurope.console.azure.com/n/cc-b1b1d78b/cc-b1b1d78b/proxy/7071/api/HttpTrigger-Java?name=exampleCall

1. **Deploy a function to Azure**

    - Explain the different Azure Function deployment options:
        - External package URL
        - Zip
        - Docker container
        - MSDeploy
        - Source control, git repos
        - Cloud Sync
    - Only some are relevant to maven azure-functions:deploy
    - Explore the different options for authentication, note that using Cloud Shell means no config is required

1. **Exercise - deploy a function to Azure**

    Using the Cloud Shell:

    1. Run `mvn azure-functions:deploy`
    1. Test the app in a new browser tab, for example, fabrikam-function-20170920120101928.azurewebsites.net/api/HttpTrigger-Java?name=exampleCall
    1. Test the app with curl -w "\n" https://`fabrikam-function-20170920120101928.azurewebsites.net/api/HttpTrigger-Java -d AzureFunctions`

1. **Add logging and monitor an Azure Function in the portal**

    - Explain how to monitor Azure Functions with App Insight, focusing on processing system-generated log files.
    - Adding instrumentation to Java project
    - Using the built-in getLogger to write to system logs
    - Viewing live logging on the portal

1. **Exercise - add logging and monitor an Azure Function in the portal**

    Using the Cloud Shell:

    1. Edit with `code` the `Function.java` to add new calls to `context.getLogger().warning`
    1. Add app insights and debugging options to `host.json`
    1. Save and redeploy the app

    Using the portal:

    1. Navigate to log streaming
    1. Open a new browser tab and call the function
    1. View the new warning messages in the live log

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module? 

## Notes

Why would a customer use the technology; that is, what type of problem does it solve?
- Meet Java customers where they are at their favorite build tool: Maven (around 70% Java developers use Maven as build tool).
- Help java developers get started with Azure Functions and demonstrate deploying web apps to Azure Functions without learning Azure-specific technologies like Azure CLI.

## Sample app

Example steps to follow: https://docs.microsoft.com/azure/azure-functions/functions-create-first-java-maven?view=azure-java-stable

Java development guide: https://docs.microsoft.com/azure/azure-functions/functions-reference-java?view=azure-java-stable

curl -w "\n" https://maven-functions-20190909142853162.azurewebsites.net/api/HttpTrigger-Java?code=L8PY4GfQ7jaemT57yyhhkvMAmUWmGa/eE5bILOA7qJ9kMGmlaSOcPw== -d AzureFunctions

All code will be written in `code` editor in the Cloud Shell and deployed from there.

### Useful links

- Maven Plugin for Azure functions: https://github.com/Microsoft/azure-maven-plugins/blob/master/azure-functions-maven-plugin/README.md


### RESOURCE LIST FOR SANDBOX

Microsoft.Storage/storageAccounts
Microsoft.Web/serverFarms
Microsoft.Web/sites