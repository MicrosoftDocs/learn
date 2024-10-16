Often, part of your deployment process requires that you connect to databases or storage services. This connection might be necessary to apply a database schema, to add some reference data to a database table, or to upload some blobs. In this unit, you'll learn about how you can extend your workflow to work with data and storage services.

## Configure your databases from a workflow

Many databases have _schemas_, which represent the structure of the data contained in the database. It's often a good practice to apply a schema to your database from your deployment workflow. This practice helps to ensure that everything your solution needs is deployed together. It also ensures that if there's a problem when the schema is applied, your workflow displays an error so that you can fix the issue and redeploy.

When you work with Azure SQL, you need to apply database schemas by connecting to the database server and executing commands by using SQL scripts. These commands are data-plane operations. Your workflow needs to authenticate to the database server and then execute the scripts. GitHub Actions provides the `azure/sql-action` action that can connect to an Azure SQL database server and execute commands.

Some other data and storage services don't need to be configured by using a data plane API. For example, when you work with Azure Cosmos DB, you store your data in a _container_. You can configure your containers by using the control plane, right from within your Bicep file. Similarly, you can deploy and manage most aspects of Azure Storage blob containers within Bicep, too. In the next exercise, you'll see an example of how to create a blob container from Bicep.

## Add data

Many solutions require reference data to be added to their databases or storage accounts before they work. Workflows can be a good place to add this data. This means that, after the workflow runs, your environment is fully configured and ready to use.

It's also helpful to have sample data in your databases, especially for nonproduction environments. Sample data helps testers and other people who use those environments to be able to test your solution immediately. This data might include sample products or things like fake user accounts. Generally, you don't want to add this data to your production environment.

The approach you use to add data depends on the service you use. For example:

- To add data to an Azure SQL database, you need to execute a script, much like configuring a schema.
- When you need to insert data to Azure Cosmos DB, you need to access its data plane API, which might require you to write some custom script code.
- To upload blobs to an Azure Storage blob container, you can use various tools from workflow scripts, including the AzCopy command-line application, Azure PowerShell, or Azure CLI. Each of these tools understands how to authenticate to Azure Storage on your behalf, and how to connect to the data plane API to upload blobs.

## Idempotence

One of the characteristics of deployment workflows and infrastructure as code is that you should be able to redeploy repeatedly without any adverse side effects. For example, when you redeploy a Bicep file that you've already deployed, Azure Resource Manager compares the file you submitted with the existing state of your Azure resources. If there are no changes, Resource Manager doesn't do anything. The ability to re-execute an operation repeatedly is called _idempotence_. It's a good practice to make sure your scripts and other workflow steps are idempotent.

Idempotence is especially important when you interact with data services, because they maintain state. Imagine you're inserting a sample user into a database table from your workflow. If you're not careful, a new sample user will be created every time you run your workflow. This result likely isn't what you want.

When you apply schemas to an Azure SQL database, you can use a data package, also called a DACPAC file, to deploy your schema. Your workflow builds a DACPAC file from source code and creates a workflow artifact, just like with an application. Then, the deployment job in your workflow publishes the DACPAC file to the database:

:::image type="content" source="../media/6-database-workflow-artifact.png" alt-text="Diagram showing a workflow uploading and then referring to an artifact named 'database'." border="false":::

When a DACPAC file is deployed, it behaves in an idempotent way by comparing the target state of your database to the state defined in the package. In many situations, this means you don't need to write scripts that follow the principle of idempotence, because the tooling handles it for you. Some of the tooling for Azure Cosmos DB and Azure Storage also behaves correctly.

However, when you create sample data in an Azure SQL database or another storage service that doesn't automatically work in an idempotent way, it's a good practice to write your script so that it creates the data only if it doesn't already exist.

It's also important to consider whether you might need to roll back deployments, such as by rerunning an older version of a deployment workflow. Rolling back to your data can become complicated, so carefully consider how your solution will work if you need to allow for rollbacks.

## Network security

Sometimes, you might apply network restrictions to some of your Azure resources. These restrictions can enforce rules about requests made to the data plane of a resource, such as:

- This database server is accessible only from a specified list of IP addresses.
- This storage account is accessible only from resources that are deployed within a specific virtual network.

Network restrictions are common with databases, because it might seem like there's no need for anything on the internet to connect to a database server.

However, network restrictions can also make it difficult for your deployment workflows to work with your resources' data planes, too. When you use a GitHub-hosted runner, its IP address isn't easily known in advance, and it might be assigned from a large pool of IP addresses. Additionally, GitHub-hosted runners can't be connected to your own virtual networks.

Some of the actions that help you to perform data-plane operations can work around these issues. For example, the `azure/sql-action` action:

:::image type="content" source="../media/6-firewall.png" alt-text="Diagram illustrating the firewall update process." border="false":::

When you use the `azure/sql-action` action to work with an Azure SQL logical server or database, it uses your workload identity:::image type="icon" source="../media/callout-01.png"::: to connect to the control plane for the Azure SQL logical server. It updates the firewall to allow the runner to access the server from its IP address:::image type="icon" source="../media/callout-02.png":::. Then, it can successfully submit the DACPAC file or script for execution:::image type="icon" source="../media/callout-03.png":::. The action then automatically removes the firewall rule when it's done.

In other situations, it's not possible to create exceptions like this. In these circumstances, consider using a _self-hosted runner_, which runs on a virtual machine or other compute resource that you control. You can then configure this runner however you need. It can use a known IP address, or it can connect to your own virtual network. We don't discuss self-hosted runners in this module, but we provide links to more information on the module's Summary page.

## Your deployment workflow

In the next exercise, you'll update your deployment workflow to add new jobs to build your website's database components, deploy the database, and add seed data:

:::image type="content" source="../media/6-workflow-database.svg" alt-text="Diagram showing the revised workflow, including a new database build job, a database deployment job, and data seeding jobs in the test environment." border="false":::
