In this unit, we'll introduce Java EE applications and the modules learning goals.

## Introduction

Java EE applications are used in many enterprises such as purchase management, manufacturing, and CRM.

Take the example of a freight delivery system:

- Your service receives a package and captures the shipping address information and register the delivery address.
- Your service query and update data from a Relational database.

In a similar manner, in this module, you'll create a sample database on `Azure Database for MySQL`.
You'll then create and deploy a `Java EE (Jakarta EE) Application` to `JBoss EAP on Azure App Service`.
Finally you'll learn how to also manage your application's lifecycle.

## Learning Objectives

By the end of this module, you can:

- Create and manage an Azure Database for MySQL
- Deploy a Java EE app to JBoss EAP on Azure App Service
- Create a data source and bind your Java EE app to MySQL
- Access and manage the Java EE app on JBoss

## Prerequisites

- Azure Subscription
- [Azure CLI command]((https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&WT.mc_id=java-9121-yoterada))
- [Java SE 8 (or 11)]((https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html))
- [Git CLI](https://git-scm.com/downloads)
- [MySQL CLI](https://dev.mysql.com/downloads/shell/)
- [jq Utility](https://stedolan.github.io/jq/)
