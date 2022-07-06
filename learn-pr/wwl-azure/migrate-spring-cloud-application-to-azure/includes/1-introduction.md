In the previous module, you established a plan for migrating the Spring Petclinic application to the Azure platform. It's now time to perform the actual migration of the first Spring Petclinic components.

The Spring Cloud service provides a config server for your sample apps to use.

In this module, you'll begin by creating a git repo. After you've created the git repo, you'll create a config server for your Spring Cloud instance to connect to your git repo. You'll then create a MySQL database service. After the MySQL database service in place, you can deploy the microservices to the Azure Spring Apps service. Lastly, you'll test the application through a publicly available endpoint to make sure everything is working.

## Learning objectives

After completing this module, you'll be able to:

 -  Create an Azure Spring Apps service.
 -  Configure your config server.
 -  Create an Azure MySQL Database service.
 -  Deploy your first components of the Spring Petclinic app to the Spring Cloud service.
 -  Provide a publicly available endpoint for the Spring Petclinic application.
 -  Test the application through the publicly available endpoint.

## Prerequisites

 -  Intermediate-level familiarity with and local installations of the following tools: Git, Java JDK 8 or later, and a Java IDE or text editor.
 -  Basic Git commands, including cloning, committing files, and pushing changes to GitHub.
 -  Intermediate-level familiarity with Azure.

> [!NOTE]
> The instructions provided in this exercise assume that you've successfully completed the previous exercises and are using the same lab environment, including your Git Bash session with the relevant environment variables already set.

To download the instructions for this module, see [Deploying and Running Java apps in Azure Spring Apps](https://github.com/MicrosoftLearning/Deploying-and-Running-Java-Applications-in-Azure-Spring-Apps) in GitHub.
