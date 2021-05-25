You now know how to deploy, configure, and utilize Azure SQL Database to build a strong foundation for a modern application. Application requirements are constantly evolving and changing, so the next step is to understand how to update your database when needed. Development Operations (DevOps) is a set of principles and practices that can help.

DevOps is the union of people, process, and technology to continually provide value to customers. Teams that adopt DevOps culture, practices, and tools become high-performing: building better products faster for greater customer satisfaction.

As database is one of the main parts of a solution, and the ability to have it working with your DevOps practices is a key piece of modern and agile application development.

With Azure SQL, there are several to include the database in the DevOps process. A CI/CD pipeline is the backbone of a DevOps environment, and Azure SQL can be fully integrated with any CI/CD tool you choose. Two of the most common and widely used in Azure are GitHub Actions and Azure DevOps.

## Implement CI/CD for databases

Having the database as part of a CI/CD pipeline means that you want to deploy to create or update the structure, and maybe even some of the data, in a fully automated, reproducible, and determinist manner. Once configured, you can run the process anytime and for any number of times and get consistent results.

There are three main approaches for databases that you will learn about:

- Desired State
- Code First Migrations
- Custom Scripts

### Use the Desired State approach with SqlPackage.exe

With this approach, you take a snapshot of the structure of a reference database, which represents the desired state.You can then use that snapshot to synchronize another target database, usually the test or production database, to the desired state. A tool like [SqlPackage.exe](/sql/tools/sqlpackage/sqlpackage) can be used to take the snapshot into a `.dacpac` file. When the `.dacpac` is applied to the target database, it will automatically find the differences, generate the correct script, and apply that script to sync the target schema with the reference.

This approach is used in the bus-catching scenario as it is probably the easiest and the simplest of the three approaches discussed.

### Implement Code First Migrations depending on your language

Another option is for when you don't want to write T-SQL scripts, but you want to let C#, Python, or Node and the entities defined in your solution (for example, a Book, a Customer)  automatically generate the database and schema. There is a specific tool that usually comes with the platform or framework being used, and you can find references at the end of the module. These tools ensure that every time you change any of the entities, for example, you add a new field or entity, the new structure will be reflected in the database.

### Use manual scripts for step-by-step deployments

With the manual scripting approach, the developer carefully writes and maintains the scripts needed to create and change the database over time. After a script has been deployed in production, it is never changed and a new one is created. Each script contains the code needed to evolve the database to the new schema. In those cases where a database needs to be deployed from scratch, all scripts must be executed in the correct sequence to make sure database is created and the evolved correctly. Tools like [DbUp](https://dbup.github.io/) help in making sure that once a script has been deployed, is not applied again to the same database in subsequent executions.

## Select a pipeline tool to implement CI/CD with ease

Once you have identified the approach you will use to update your database, you can select from two common solutions to implement the approach, Azure DevOps or GitHub Actions.

### Implement CI/CD with Azure DevOps

Azure DevOps is a suite of products that provides full support to all DevOps aspects, including a CI/CD pipeline. A pipeline is composed of Tasks that are used to define the steps of the pipeline. A Task can be almost anything, from the execution of an executable to the build of a .NET solution. A specific task named the **Azure SQL Database Deployment Task** can be used to deploy a `.dacpac` file or execute a .sql script.

### Implement CI/CD with GitHub Actions

GitHub Actions allow the definition of a CI/CD pipeline with the use of **Actions**, which are used to create the steps of the pipeline. An Action can be used to execute processes of almost any type. The Action **Azure SQL Deploy** allows you to deploy a `.dacpac` file.

Azure SQL Actions will be used in the following exercise to deploy and update the database's schema, giving you an opportunity to see it in action.
