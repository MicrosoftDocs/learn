# Title

Build a Node.js app for Azure Cosmos DB in Visual Studio Code

## Role(s)

- Developer

## Level

- Beginner

## Product(s)

- Cosmos DB
- Visual Studio Code

## Prerequisites

- Visual Studio Code with Azure extensions installed
- Node.js installed

## Summary

Build a database app to store and query data in Azure Cosmos DB by using Visual Studio Code and Node.js.

## Learning objectives

1. Create a Cosmos DB instance for a Node.js app
2. Set up a new Node.js app in Visual Studio Code
3. Add JavaScript code to work with Cosmos DB
4. Create and run Cosmos DB stored procedures from your app

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Create a Cosmos DB instance | Create a Cosmos DB instance for a Node.js app | Exercise | Create a Cosmos DB instance for a Node.js app | Yes |
| Create a Node.js app in Visual Studio Code | Set up a new Node.js app in Visual Studio Code | Exercise | Set up a new Node.js app in Visual Studio Code | Yes |
| Add JavaScript code to work with Cosmos DB | Add JavaScript code to work with Cosmos DB | Exercise | Add JavaScript code to work with Cosmos DB | Yes |
| Create and run Cosmos DB stored procedures | Create and run Cosmos DB stored procedures from your app | Exercise | Create and run Cosmos DB stored procedures from your app | Yes |

## Outline the units

1. **Introduction**

    You work as a software developer for a systems house that builds applications for schools. You have been asked to develop a simple application that keeps track of students' grades for the various courses they have taken. You decide to use Cosmos DB to store the information about course grades. The application must be portable, so you decide to use JavaScript running in Node.js. You also decide to use Visual Studio Code as the development environment.

2. **Create a Cosmos DB instance**

    Cover the following points:

   - Describe Cosmos DB
          - Provide a very brief overview of Cosmos DB
          - Explain the hierarchy: Cosmos DB account, database, container
          - Briefly explain the concept of documents and partitions.
          - Summarize how throughput capacity works.
   - Create a database and documents with Visual Studio Code
          - Describe how to install the Azure Cosmos DB extension for Visual Studio Code.
          - Describe how to use the Azure Cosmos DB extension to create a Cosmos DB account, create a database, and create a container.
          - Describe how to use the Azure Cosmos DB extension to add, query, modify, and delete a document.

3. **Exercise - Create a Cosmos DB instance using Visual Studio Code**

    List the steps that apply the learning content from previous unit:

    1. Install the Azure Cosmos DB extension for Visual Studio Code.
    2. Create a Cosmos DB account (SQL API).
    3. Create a database in the account, for holding students' grade information.
    4. Create the `StudentCourseGrades` container. This container will hold `Course` and `Student` documents. Course grades will be held as an array of subdocuments with each student. The data will be partitioned by academic year.
    5. Insert a `Course` document.
    6. Insert two `Student` documents, each with a `Grade` subdocument that references a `Course` document.
    7. View the documents in Visual Studio Code.
    8. Update the course grade for a student and save the change.

4. **Create a Node.js app in Visual Studio Code**

    Cover the following points:

   - Describe how to create a new folder and JavaScript file using Explorer in Visual Studio Code.
   - Explain how to use JavaScript IntelliSense from Visual Studio Code. Include the use of `//@ts-check` to provide advanced type checking and error reporting when editing code.
   - Describe how to use the integrated terminal in Visual Studio Code to run a Node app.
   - Summarize how to use the Debugger in Visual Studio Code to set breakpoints, step through code, and view variables.

5. **Exercise - Create a Node.js app in Visual Studio Code**

    List the steps that apply the learning content from previous unit:

    1. Using Explorer in Visual Studio Code, create a new folder named `grades`.
    2. Create a new JavaScript code file named `studentgrades.js`.
    3. In the `studentgrades.js` code file, add code to perform the following tasks:
              1. Prompt the user for the details of a course, and use this information to create a new `course` JavaScript object, with properties `coursecode`, `coursename`, and `academicyear`.
              2. Prompt the user for the details of two students and create a pair of `student` JavaScript objects, with properties `studentid`, `academicyear`, `forename`, and `lastname`.
              3. For each student, prompt the user for a course grade, and add the grade details as a composite property of the `student` object.
    4. Run the app and test it.
    5. Use the debugger to single step through the application and observe the objects that get created.

    **Note:** This exercise does not store any data in Cosmos DB; this aspect is covered in the following units and exercises.

6. **Add JavaScript code to work with Cosmos DB**

    Cover the following points:

    - Summarize the purpose of the `@azure/cosmos` module.
    - Explain how to install the module using npm; `npm install @azure/cosmos`
    - Explain how to connect to a Cosmos DB account from JavaScript. (`CosmosClient` with the endpoint and primary key)
    - Describe how to create a document and add it to a container (`await client.database(databaseId).container(containerId).items.upsert(itemBody);`)
    - Describe how to fetch a single document from a container by using the document ID.
    - Describe how to use a query to retrieve documents from a container (`await client.database(databaseId).container(containerId).items.query(querySpec, {enableCrossPartitionQuery:true}).fetchAll();`)
    - Describe how to modify a document in a container (`await client.database(databaseId).container(containerId).item(itemBody.id, ...).replace(itemBody);`)
    - Describe how to delete a document (`await client.database(databaseId).container(containerId).item(itemBody.id, ...).delete(itemBody);`)
    - Describe how to handle exceptions raised by Cosmos DB.

7. **Exercise - Add JavaScript code to work with Cosmos DB**

    List the steps that apply the learning content from previous unit:

    1. Install the `@azure/cosmos` module.
    2. Create a separate JavaScript code file (`config.js`) that encapsulates the configuration information for connecting to Cosmos DB as an object.
    3. In the `studentgrades.js` file, add code to perform the following tasks:
             1. Use the configuration object in `config.js` to connect to the Cosmos DB account and create a `CosmosClient` object.
             2. Create an async function that takes an object (a `course` or `student`), and a partition key, and inserts the document into the `StudentCourseGrades` container in Cosmos DB.
             3. Create an async function that fetches a student document from the database by using the student ID.
             4. Create an async function that retrieves the student names and grades for a specified course.
             5. Create an async function that can be used to change the grade of course for a `Student` document in the database.
             6. Create an async document that can be used to delete a `Student` document from the database.
    4. Add a test harness (another JavaScript code file) that exercises the async functions to test them.

8. **Create and run Cosmos DB stored procedures**

    Cover the following points:

    - Explain the purpose of stored procedures in Cosmos DB
    - Describe the considerations for implementing a stored procedure:
            - You write the code for a stored procedure using JavaScript.
            - All operations in a stored procedure are synchronous.
            - A stored procedure operates within the context of a single partition in a container; it cannot access data in other partitions.
            - A stored procedure is transactional; if an operation in a stored procedure fails (or the stored procedure times out), all the work performed by the stored procedure is undone.
            - A stored procedure can throw an exception back to the caller if it detects an error condition. This will also cause the transaction to be undone.
            - A stored procedure runs in an environment that restricts the amount of time and resources available (a *bounded execution* environment), to prevent a rogue stored procedure from adversely affected other users.
    - Briefly summarize the JavaScript integrated query API for Cosmos DB, used from within stored procedures (/azure/cosmos-db/javascript-query-api)
    - Describe how to return data as a response message from a stored procedure.
    - Explain how to handle bounded execution by structuring a stored procedure to support *resume* functionality; the stored procedure runs until it is complete or runs out of time. If the stored procedure exceeds the time available, it returns state information in the form of a *continuation* token to the caller. The caller invokes the stored procedure again with the data in the continuation token, and the stored procedure continues processing from where it left off.
    - Describe how to create a stored procedure from the Azure portal.
    - Describe how to test a stored procedure using the Azure portal.
    - Describe how to run a stored procedure from a Node application (see https://learn.microsoft.com/javascript/api/@azure/cosmos/storedprocedure?view=azure-node-latest#execute-any--any----requestoptions-).

9. **Exercise - Create and run Cosmos DB stored procedures**

    Scenario: As part of a cleanup process, you want to provide functionality that can remove all student and course documents for a specified academic year from the database. Cosmos DB does not provide an API that removes multiple documents, so you decide to write a stored procedure to perform this task instead.

    List the steps that apply the learning content from previous unit:

    1. Using the Azure portal, create a new stored procedure named `deleteRecords` for the container. The stored procedure should run in the partition containing the data for the academic year for which records should be removed. In the stored procedure, perform the following tasks:
             1. Run a query that finds all documents in the partition.
             2. Iterate through the documents returned by the query and delete each one. As each document is deleted, check whether the permitted execution time has been exhausted. If so, return the value `false` (to indicate that deletion is not yet finished), and the number of records deleted so far, in the response message.
             3. If the permitted execution time has not been exhausted when all records have been deleted, return `true`, together with the number of documents deleted, in the response message.
    2. Test the stored procedure using the Azure portal. This will require uploading some sample data first (*module author to generate this data*).
    3. In the Node app, add an async function that calls the `deleteRecords` stored procedure over a specified partition. The code should check the response. If the response contains the `false` indication, save the number of records deleted so far, and call the stored procedure again over the same partition. Add the number of records in the response to the number previously stored to calculate the total number of records deleted. Repeat these steps until the stored procedure returns `true`.
    4. Update the test harness from the previous exercise to test the function that calls the stored procedure.

10. **Summary**

    In this module, you learned how to use Node.js to write code that creates, queries, and manages data in a Cosmos DB database. The code consists of a set of functions that you can use to maintain student and course information for the Schools application. You built, ran, and tested the application from Visual Studio Code. Together, Visual Studio Code and Node.js provide a highly portable environment for building and running a Cosmos DB application.

## Notes

- This is effectively a port of https://learn.microsoft.com/training/modules/build-cosmos-db-app-with-vscode/, for which we are not adding a pivot for a few reasons. The content of this module should not be lifted straight from the other module, but I don't expect them to be substantially different, except around the differing concerns between Node and .NET.
  - Note that the other module was created prior to our "conceptual unit/exercise unit" structure, which should be followed for this new module.
- This module is for rank beginners. No real Node expertise is expected of the audience, but you don't need to explain what Node is - the assumption is that they've learned enough to want to create a Node app that uses real cloud infrastructure.
- Similar to the other module, create a console app that can be run in the cloud shell.
- Additional information is available at https://code.visualstudio.com/docs/nodejs/nodejs-tutorial and https://learn.microsoft.com/azure/cosmos-db/sql-api-nodejs-get-started
