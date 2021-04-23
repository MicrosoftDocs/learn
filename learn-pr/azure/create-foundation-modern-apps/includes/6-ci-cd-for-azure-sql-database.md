DevOps is a combination of development (Dev) and operations (Ops). DevOps is the union of people, process, and technology to continually provide value to customers. Teams that adopt DevOps culture, practices, and tools become high-performing: building better products faster for greater customer satisfaction. 

As database is one of the main parts of a solution, and the ability to have it working with your DevOps practices is a key piece of the modern and agile application solution.

With Azure SQL, there are several ways in which the database can be included in the DevOps process. A CI/CD pipeline is the backbone of a DevOps environment, and Azure SQL can be fully integrated with any CI/CD tool you choose. Two of the most common and widely used in Azure are GitHub Actions and Azure DevOps.

## CI/CD for databases

Having the database part of a CI/CD pipeline means that you want to deploy to create or update the structure, and maybe even some of the data, of your database as a fully automated, reproducible, and determinist manner, so that you can do this process anytime you need, even many times per day, and get consistent results.

To achieve that, there are usually three main approaches:

- Desired State
- Code First Migrations
- Custom Scripts

### Desired State

With this approach, you take a snapshot of the structure, referred to as the desired state, of a reference database. Take the `bus-db` you deployed in an earlier exercise as an example. You can then use that snapshot to synchronize another target database, usually the test and the production database, to the desired state. A tool like [SqlPackage.exe](https://docs.microsoft.com/sql/tools/sqlpackage/sqlpackage?view=sql-server-ver15) can be used to take the snapshot into a `.dacpac` file. When applied to the target database, it will automatically find the differences, generate the correct script, and apply that script to sync the target schema with the one captured in the snapshot.

This approach is used in this scenario as it is probably the easiest and the simplest of the three.

### Code First Migrations

Another option is for when you don't actually write T-SQL code, but use C#, Python, or Node and the entities defined in your solution (for example, a Book, a Customer) to automatically generate the database for you. There is a specific tool that usually comes with the platform or framework being used, and you can find references at the end of the module. These tools ensure that every time you change any of the entities, for example, you add a new field or entity altogether, the new structure will be reflected in the database.

### Manual Scripts

With this approach, the developer takes care of writing and maintaining all the scripts needed to create and change the database over time. After a script has been deployed in production, it is never changed and a new one is created. Each script contains the code needed to evolve the database to the new schema. In those cases where a database needs to be deployed from scratch, all scripts must be executed in the correct sequence to make sure database is created and the evolved correctly. Tools like [DbUp](https://dbup.github.io/) help in making sure that once a script has been deployed, is not applied again to the same database in subsequent executions.

## Azure DevOps

Azure DevOps is a suite of products that provides full support to all DevOps aspects, including a CI/CD pipeline. A pipeline is composed of Tasks that are used to define the steps of the pipeline. A Task can be almost anything, from the execution of an executable to the build of a .NET solution. A specific task named the **Azure SQL Database Deployment Task** can be used to deploy a `.dacpac` file or execute a .sql script.

## GitHub Actions

GitHub Actions allow the definition of a CI/CD pipeline with the use of **Actions**, which are used to create the steps of the pipeline. An Action can be used to execute processes of almost any type. The Action **Azure SQL Deploy** allows you to deploy a `.dacpac` file.

Azure SQL Actions will be used in this scenario due to their ease of use and implementation.
