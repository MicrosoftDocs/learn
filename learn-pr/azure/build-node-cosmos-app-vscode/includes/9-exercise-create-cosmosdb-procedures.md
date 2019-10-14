You can use stored procedures with Cosmos DB to perform bulk operations more efficiently than doing the same operations from a client application. For example, if you want to delete or update many documents, you can do so with a stored procedure invoked as a single request from a client. To perform the same actions without a stored procedure would require the client application to find all documents to be updated or deleted, and then send a request to Cosmos DB to change or remove each individual document in turn. 

In the sample scenario, you want to provide a feature that cleans out all documents for a specified year. The most efficient way to do this is with a stored procedure.

In this exercise, you'll create a stored procedure named **DeleteDocumentsForYear** that removes the documents for a specified year. You'll modify the JavaScript app that you wrote previously to call the stored procedure. You'll test the stored procedure using Visual Studio Code.

This exercise runs on your desktop computer.

## Upload sample data

1. 

## Create the stored procedure

1. Start Visual Studio Code if it isn't already running.

2. In the **Cosmos DB** pane, click **Sign in to Azure** and sign in, if you aren't already connected.

    ![Screenshot of Cosmos DB pane Visual Studio Code. The user is about to sign in to Azure](../media/9-azure-sign-in.png)