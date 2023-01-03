You're now running a version of the spring-petclinic microservice application in Azure. However you don't like that your application secrets live inside configuration code. Also, your GitHub config repo has recently been reporting that it contains secret values.

You would like to have a better way to protect application secrets like your database connection string. In this module, you'll better protect your application secrets.

## Learning objectives

After completing this module, you'll be able to:

 -  Create an Azure Key Vault service.
 -  Store your connection string elements as Azure Key Vault secrets.
 -  Create a Managed Identity for your microservices.
 -  Grant the Managed Identity permissions to access the Azure Key Vault secrets.
 -  Update application config.
 -  Update, rebuild, and redeploy each app.

## Prerequisites

 -  Intermediate-level familiarity with and local installations of the following tools: Git, Java JDK 8 or later, and a Java IDE or text editor.
 -  Basic Git commands, including cloning, committing files, and pushing changes to GitHub.
 -  Intermediate-level familiarity with Azure.

> [!NOTE]
> The instructions provided in this exercise assume that you've successfully completed the previous exercises and are using the same lab environment, including your Git Bash session with the relevant environment variables already set.

To download the instructions for this module, see [Deploying and Running Java apps in Azure Spring Apps](https://github.com/MicrosoftLearning/Deploying-and-Running-Java-Applications-in-Azure-Spring-Apps) in GitHub.
