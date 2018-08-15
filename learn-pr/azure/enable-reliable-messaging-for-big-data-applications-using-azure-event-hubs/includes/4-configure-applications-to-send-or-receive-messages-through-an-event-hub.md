## Motivation

After you have created and configured your Event Hub, you'll need to configure applications to send and receive event data streams.

For example, a payment processing solution will use some form of sender application to collect customer's credit card data, and a receiver application to verify that the credit card is valid.

Although there are differences in how a Java application is configured, compared to a .NET application, there are general principles for enabling applications to connect to an Event Hub, and to successfully send or receive messages. So, although the process of editing Java configuration text files is different to preparing a .NET application using Visual Studio, the principles are the same.

## What are the minimum Event Hub application requirements?

To configure an application to send messages to an Event Hub, you must provide the following information, so that the application can create connection credentials:

- Event Hub Namespace name
- Event Hub name
- Shared Access policy name
- Primary Shared Access key

To configure an application to receive messages from an Event Hub, you must provide the following information, so that the application can create connection credentials:

- Event Hub Namespace name
- Event Hub name
- Shared Access policy name
- Primary Shared Access key
- Storage account name
- Storage account connection string
- Storage account container name

If you have a receiver application that stores messages in Blob Storage, you'll also need to first configure a Storage account.

## Azure CLI commands for creating a general purpose standard storage account

1. Create the Storage account (general purpose V2) in your resource group, and the same Azure datacenter location that you used when creating the resource group.

    ```azurecli
    az storage account create --name <storage account name> --resource-group <resource group name> --location <location> --sku Standard_RAGRS --encryption blob
    ```

2. To access this storage, you'll need a storage account access key. View the access keys that are associated with the storage account.

    ```azurecli
    az storage account keys list --account-name <storage account name> --resource-group <resource group name>
    ```

3. Save the value associated with **key1**.

4. You will also need the connection details for the storage account.View the connection string for the storage account.

    ```azurecli
    az storage account show-connection-string -n <storage account name> -g <resource group name>
    ```

5. Save the value associated with the **connectionString**.

6. Messages will be stored in a container within your storage account. Create a container in your storage account, using `<connection string>` with the connection string from the previous step.

    ```azurecli
    az storage container create -n <container> --connection-string "<connection string>"
    ```

## Shell command for cloning an application GitHub repository

Git is a collaboration tool that uses a distributed version control model, and is specifically designed for collaborative working on software and documentation projects. Git clients are available for multiple platforms, including Windows, and the git commmand-line is included in the Azure Bash cloud shell. GitHub is a web-based hosting service for Git repositories. If you have an application that is hosted as a project in GitHub, you can make a local copy of the project, by cloning its repository using the **git clone** command.

1. Clone a repository to your home directory.

    ```azurecli
      git clone https://github.com/<project repository>
    ```

## Shell commands for preparing an application

1. You can now use an editor, such as **nano** to edit the application and add your Event Hub namespace, Event Hub name, shared access policy name and primary key. Nano is a simple text editor, available for Linux and other Unix-like operating systems; it is also available in the Azure Bash cloud shell. For example, use this command to open a Java application file in the **nano** editor.

    ```azurecli
    nano <application>.java
    ```

1. Depending on how your applications have been developed, you may need to compile or build the application after you have added the Event Hub configuration information. For example, the Java applications used in the next unit need to be built using a tool such as Apache **Maven**. Maven compiles .java files into .class files or packages them into .jar files. Maven is available from the Bash cloud shell; to build the Java application, you use **mvn** commands. Use this mvn command to build a Java  application.

    ```azurecli
    mvn clean package -DskipTests
    ```

## Summary

Sender and receiver applications must be configured with specific information about the Event Hub environment. In the next unit, you will use your knowledge of Event Hub publishing requirements to configure a sender and a receiver application, ready to relay messages through your Event Hub.
