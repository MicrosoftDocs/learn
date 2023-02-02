You have now set up your Spring Petclinic application in Azure and secured the secrets used by the microservices. However you're concerned with the public endpoints of the application that are exposed. You would like to add a Web Application Firewall to filter all incoming requests to your application.

In this challenge, you'll learn how to add a Web Application Firewall to your setup.

## Learning objectives

After completing this module, you'll be able to:

 -  Create networking resources.
 -  Recreate Azure Spring Apps service and apps in the virtual network.
 -  Configure internal DNS.
 -  Acquire a certificate and add it to Key Vault.
 -  Configure domain in Azure Spring Apps.
 -  Create the Application Gateway resources.
 -  Access the application by DNS name.
 -  Configure Web Application Firewall on Application Gateway.

## Prerequisites

 -  Intermediate-level familiarity with and local installations of the following tools: Git, Java JDK 8 or later, and a Java IDE or text editor.
 -  Basic Git commands, including cloning, committing files, and pushing changes to GitHub.
 -  Intermediate-level familiarity with Azure.

> [!NOTE]
> The instructions provided in this exercise assume that you've successfully completed the previous exercises and are using the same lab environment, including your Git Bash session with the relevant environment variables already set.

To download the instructions for this module, see [Deploying and Running Java apps in Azure Spring Apps](https://github.com/MicrosoftLearning/Deploying-and-Running-Java-Applications-in-Azure-Spring-Apps) in GitHub.
