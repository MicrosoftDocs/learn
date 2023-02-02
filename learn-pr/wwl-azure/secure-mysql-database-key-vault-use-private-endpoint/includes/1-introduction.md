You now have an Azure Spring Apps application deployed into a virtual network. All incoming application connection requests from the internet must pass through an Application Gateway instance using a Web Application Firewall. The apps communicate with the backend services, such Azure Database for MySQL Single Server and Key Vault using public endpoints.

In this exercise, you'll implement a configuration where connections that originate from within your virtual network are accepted.

## Learning objectives

After completing this module, you'll be able to:

 -  Lock down the Azure Database for MySQL Single Server instance by using a private endpoint.
 -  Lock down the Key Vault instance by using a private endpoint.
 -  Test your setup.

## Prerequisites

 -  Intermediate-level familiarity with and local installations of the following tools: Git, Java JDK 8 or later, and a Java IDE or text editor.
 -  Basic Git commands, including cloning, committing files, and pushing changes to GitHub.
 -  Intermediate-level familiarity with Azure.

> [!NOTE]
> The instructions provided in this exercise assume that you've successfully completed the previous exercises and are using the same lab environment, including your Git Bash session with the relevant environment variables already set.

To download the instructions for this module, see [Deploying and Running Java apps in Azure Spring Apps](https://github.com/MicrosoftLearning/Deploying-and-Running-Java-Applications-in-Azure-Spring-Apps) in GitHub.
