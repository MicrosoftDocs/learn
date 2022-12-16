By validating and previewing your Bicep deployment, you've been able to build confidence that your Bicep files will successfully deploy. But deployment isn't the whole story. After the deployment finishes, it's also helpful to check that your deployment did what you expected.

In this unit, you'll learn about tests that you can run after your deployment finishes. You'll also learn about rolling back your deployment if things don't turn out as you expected.

## Run smoke tests and negative tests

When you define resources in a Bicep file, your goal isn't just to create resources in Azure. It's to deliver value to your organization while meeting your organization's requirements. When you validate and preview your Bicep files, you gain confidence that the resource definitions are valid, but you don't necessarily know that the resources will actually do what you want.

For example, imagine that you deploy a new Azure SQL logical server by using a Bicep deployment pipeline. Your Bicep definition for the server is valid, so it passes the linter and preflight validation stages. The what-if command shows that a server will be created, which is what you expect. The deployment also finishes successfully. But at the end of the deployment process, you still might not have a working database server that's ready to use. Reasons might include:

- You haven't configured firewall rules to allow network traffic to reach your server.
- You've enabled Azure Active Directory authentication on your server when you shouldn't have, or vice versa.

Even when you're just deploying basic Bicep files, it's worth considering how you can validate that the resources you deploy actually work and meet your requirements. Here are examples of how you can apply this principle:

- When you deploy a website, try to reach the web application from your pipeline. Verify that your pipeline connects to the website successfully and receives a valid response code.
- When you deploy a content delivery network (CDN), try to connect to a resource through the CDN. Verify that the pipeline connects to the CDN successfully and receives a valid response code.

These tests are sometimes called *infrastructure smoke tests*. Smoke testing is a simple form of testing designed to uncover major problems in your deployment.

> [!NOTE]
> Some Azure resources aren't easy to reach from a Microsoft-hosted pipeline agent. You might need to consider using a self-hosted agent to run smoke-test stages if they require access to resources through private networks.

It's also a good idea to perform *negative testing*. Negative testing helps you to confirm that your resources don't have undesired behavior. For example, when you deploy a virtual machine, it's good practice to use Azure Bastion to securely connect to the virtual machine. You could add a negative test to your pipeline to verify that you can't connect to a virtual machine directly by using Remote Desktop Connection or SSH.

> [!IMPORTANT]
> The goal of these tests is not to verify that Bicep has deployed your resources correctly. By using Bicep, you're making the assumption that it will deploy the resources that you specify in your Bicep files. Instead, the goal is to verify that the resources that you've defined will work for your situation and meet your requirements.

### Run tests from Azure Pipelines

There are many ways you can run tests in your pipeline. In this module, we'll use Pester, which is an open-source tool that runs tests written through PowerShell. You might choose to use a different test framework or even choose to run your tests without a test tool. For example, another test tool to consider is PSRule for Azure, which includes prebuilt rules and tests for Azure. It can run validation on your templates, and also run tests against your deployed Azure resources. We'll link to PSRule in the summary.

When you use a supported test framework, Azure Pipelines understands the results of each test. It displays the test results alongside the pipeline run information, and it tracks the history of each test over time. In the next exercise, you'll see how you can use Azure Pipelines with infrastructure smoke tests.

### Pass data between steps and stages

When you divide your pipeline into multiple stages, each with its own responsibility, you sometimes need to pass data between these stages. For example, one stage might create an Azure resource that another stage needs to work with. To be able to pass data, the second stage needs to know the name of the resource that was created. For example, our smoke test stage needs to access the resources that the deployment stage has deployed.

Your Bicep file deploys the resources, so it can access the resource properties and publish them as deployment outputs. You can access a deployment output in your pipeline. In Azure Pipelines, there's a special syntax for publishing variables to make them available across stages.

First, you need to publish an output variable for a pipeline stage. To output the variable, you'll write a specially formatted string to the pipeline log, which Azure Pipelines knows how to understand. In the following example, a variable named `myVariable` is set to the value `myValue`:

:::code language="bash" source="code/8-output-variable.yml" range="8" :::

Azure Pipelines reads and interprets the string from the pipeline log, and it makes the variable's value available as an output. You can combine this value with more scripting to publish a Bicep deployment output's value as an output variable for a pipeline stage. You'll see how to do this scripting in the next exercise.

Second, you need to make the variable available to your smoke test stage's job. You'll define a variable for the job and use another specially formatted YAML string:

:::code language="yaml" source="code/8-output-variable.yml" range="11-15" highlight="5" :::

Now, any steps within the smoke test job can access the `myVariable` value like any other variable, by using the syntax `$(myVariable)`. You'll use a variable in the next exercise.

### Other test types

*Functional tests* and *integration tests* are often used to validate that the deployed resources are behaving as you expect. For example, an integration test might connect to your website and submit a test transaction, and then wait to confirm that the transaction finishes successfully. By using integration tests, you can test the solution that your team builds, along with the infrastructure on which it's running. In a future module, you'll see how these types of tests can be added to your pipeline.

It's also possible to run other types of tests from a deployment pipeline, including performance tests and security penetration tests. These tests are outside the scope of this module, but they can add value to an automated deployment process.

## Roll back or roll forward

Suppose your pipeline deploys your resources successfully, but your tests fail. What should you do then?

Earlier in this module, you learned that Azure Pipelines enables you to create *rollback stages* that run when a previous stage fails. You can use this approach to create a rollback stage when your test stage reports an unexpected result. You also can manually roll back your changes, or rerun your entire pipeline, if you think the failure was due to a temporary problem that has since been resolved.

> [!NOTE]
> When you submit a deployment to Azure Resource Manager, you can request that Resource Manager automatically rerun your last successful deployment if it fails. To do this, you need to use the Azure CLI step to deploy your file, and add the `--rollback-on-error` parameter when you submit the deployment by using the `az deployment group create` command.

It's often challenging to work out the steps that a rollback stage should perform. In general, Bicep deployments are complex, and it's not easy to roll back changes. It's especially difficult to roll back when your deployment includes other components.

For example, imagine that your pipeline deploys a Bicep file that defines an Azure SQL database, then adds some data to the database. When your deployment is rolled back, should the data be deleted? Should the database be removed too? It's hard to predict how every failure and every rollback might affect your running environment.

For this reason, many organizations prefer to *roll forward*, which means they quickly fix the reason for the failure and then deploy again. By building a high-quality automated deployment process, and by following all of the best practices you've learned throughout these learning paths, you'll be able to quickly fix problems and redeploy your Bicep files while maintaining high quality.

> [!TIP]
> One of the principles of a DevOps mindset is to learn from mistakes. If you have to roll back a deployment, carefully consider why the error happened and add automated testing before your deployment starts to detect the same problem if it happens in the future.
