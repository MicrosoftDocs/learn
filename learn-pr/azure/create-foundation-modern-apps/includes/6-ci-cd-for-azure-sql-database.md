You now know how to deploy, configure, and use Azure SQL Database to build a strong foundation for a modern application. Application requirements are constantly evolving and changing, so the next step is to understand how to update your database when needed. Development Operations (DevOps) is a set of principles and practices that can help.

DevOps is the union of people, process, and technology to continually provide value to customers. Teams that adopt DevOps culture, practices, and tools become high-performing, building better products faster for greater customer satisfaction.

A database is one of the main parts of a solution; therefore, the ability to have your database integrated with your DevOps practices is a key piece of modern and agile application development.

With Azure SQL, there are several approaches to include your database in your DevOps process. A continuous integration (CI) and continuous delivery (CD) pipeline is the backbone of a DevOps environment, and Azure SQL can be fully integrated with any CI/CD tool you choose. Two of the most common and widely used tools in Azure are GitHub Actions and Azure DevOps.

## Implement CI/CD for databases

Having the database as part of a CI/CD pipeline means that you want to configure and deploy the structure—and maybe even some of the data—in a fully automated, reproducible, and determinist manner. Once configured, you can run the deployment or update process anytime, for any number of times, and get consistent results.

In this unit, you'll learn about the three main approaches for implementing a CI/CD pipeline for databases:

- Desired State
- Code First Migrations
- Custom Scripts

### Use the Desired State approach with SqlPackage.exe

In a Desired State approach, you take a snapshot of the structure of a reference database to represent the desired state. You can then use that snapshot to synchronize another target database, usually the test or production database, to the desired state. You can use a tool like [SqlPackage.exe](/sql/tools/sqlpackage/sqlpackage) to take the snapshot into a `.dacpac` file. When the `.dacpac` is applied to the target database, it'll automatically find the differences, generate the correct script, and apply that script to sync the target schema with the reference.

We use the Desired State approach in the bus-catching scenario; it's probably the easiest and the simplest of the three approaches discussed.

### Implement Code First Migrations depending on your language

There's another option when you don't want to write T-SQL scripts; instead, you want to let C#, Python, or Node and the entities defined in your solution (for example, a Book, a Customer) automatically generate the database and schema. There's usually a specific tool that comes with or applies to a platform or framework. These tools ensure that every time you change or add a field or entity, the new structure will be reflected in the database. You can find references to tools for specific platforms and frameworks at the end of this module.

### Use manual scripts for step-by-step deployments

In the manual scripting approach, a developer carefully writes and maintains scripts needed to create and change the database over time. After a script has been deployed in production, it's never changed; rather, a new one is created. Each script contains the code needed to evolve the database to the new schema. In cases where a database needs to be deployed from scratch, all scripts must be executed in the correct sequence to ensure database is created and the evolved correctly. Tools like [DbUp](https://dbup.github.io/) help ensure that, once a script has been deployed, it isn't applied again to the same database in subsequent executions.

## Select a pipeline tool to implement CI/CD with ease

Once you've identified the approach that best addresses how you'll update your database, you can select from two common solutions, Azure DevOps or GitHub Actions, to implement that approach.

### Implement CI/CD with Azure DevOps

Azure DevOps is a suite of products that provides full support to all DevOps aspects, including a CI/CD pipeline. A pipeline is composed of Tasks that define the steps of the pipeline. A Task can be almost anything, from the execution of an executable to the build of a .NET solution. You can use a specific task named **Azure SQL Database Deployment Task** to deploy a `.dacpac` file or execute a .sql script.

### Implement CI/CD with GitHub Actions

GitHub **Actions** allow the definition of a CI/CD pipeline. You use **Actions** to create the steps of the pipeline. You can use an Action to execute a process of almost any type. The Action **Azure SQL Deploy** allows you to deploy a `.dacpac` file.

In the next exercise, Azure SQL Actions will be used to deploy and update the database schema, giving you an opportunity to see it in action.
