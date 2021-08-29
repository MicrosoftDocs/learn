By validating and previewing your Bicep deployment, you were able to build up confidence that your Bicep files would successfully deploy. But this isn't the whole story. After the deployment completes, it's also helpful to check that your deployment did what you expected. In this unit, you'll learn about tests you can run after your deployment completes. You'll also learn about rolling back your deployment, if things don't turn out as you expected.

## Testing your resources after they're deployed

When you define resources in a Bicep file, your goal isn't just to create resources in Azure - it's to deliver some sort of value to your organization. When you validate and preview your Bicep files, you gain confidence that the resource definitions are valid. But you don't necessarily know that the resources will actually do what you want.

For example, imagine that you deploy a new Azure SQL server by using a Bicep deployment pipeline. Your Bicep definition for the SQL server is valid, so it passes the linter and preflight validation stages. The what-if command shows that a server will be created, which is what you expect. The deployment also completes successfully. But at the end of the deployment process, there are many reasons why you still might not have a working database server that's ready to use, such as:

- You haven't configured firewall rules to allow network traffic to reach your server.
- You have enabled Azure Active Directory authentication on your server when you shouldn't have, or vice versa.

Even when you're just deploying basic Bicep files, it's worth considering how you can validate that the resources you deploy actually work and meet your requirements. Here are some examples of how you can apply this principle:

- When you deploy a website, try to reach the web application from your pipeline. Verify that your pipeline connects to the website successfully and receives a valid response code.
- When you deploy a database server and database, try to connect to the database.

These tests are sometimes called *infrastructure smoke tests*. Smoke testing is a simple form of testing designed to uncover major issues in your deployment.

It's also a good idea to perform *negative testing*. Negative testing helps you to confirm that your resources don't have undesired behavior. For example, when you deploy a virtual machine, it's good practice to use Azure Bastion to access the virtual machine securely. You could add a negative test to your pipeline to verify that you can't connect to the virtual machine directly using Remote Desktop Connection or SSH.

> [!NOTE]
> The goal of these tests isn't to verify that Bicep has actually deployed your resources correctly. By using Bicep, you're making the assumption that it will deploy the resources that you specify in your Bicep files. Instead, the goal is to verify that the resources that you've defined will actually work for your requirements.

### Run tests from Azure Pipelines

There are many ways you can run tests in your pipeline. In this module, we use Pester, which is an open-source tool that runs tests written using PowerShell. You might choose to use a different test framework, or even to run your tests without a testing tool.

When you use a supported test framework, Azure Pipelines understands the results of each test. It displays the test results alongside the pipeline run information, and it tracks the history of each test over time. In the next exercise, you'll see how you can use Azure Pipelines with infrastructure smoke tests.

### Pass data between steps and stages

You sometimes need to pass data between pipeline stages. This is useful when you create a smoke test stage because your smoke tests need to know how to find the Azure resources to test. Your Bicep file deploys the resources, so it can access the resource properties and publish an `output` that your pipeline can access.

In Azure Pipelines, there's special syntax to publish variables that are available across stages, and to access them.

You first need to publish a pipeline stage output variable. You do this by echoing a specially formatted string in a script. In the following example, a variable named `myVariable` is set to the value `myValue`:

:::code language="bash" source="code/8-output-variable.yml" range="8" :::

Azure Pipelines reads and interprets the string from the pipeline log, and makes the variable's value available as an output. You can combine this with more scripting to publish a Bicep deployment output's value as a pipeline stage output variable. You'll see how to do this in the next exercise.

After you publish the output variable, you then need to make the variable available to your smoke test job. You do this by defining a variable for the job, and using another specially formatted YAML string:

:::code language="yaml" source="code/8-output-variable.yml" range="11-15" highlight="5" :::

Now, any steps within the smoke test job can access the `myVariable` value like any other variable, by using the syntax `$(myVariable)`. You'll try this out in the next exercise.

> [!NOTE]
> Passing variables between stages can be complex. We link to more information in the summary.

### Other test types

*Functional tests* and *integration tests* are often used to validate that the resources deployed are behaving as you expect and that they work correctly for the solution you're deploying. For example, an integration test might connect to your website and submit a test transaction, then wait to confirm the transaction completes successfully. By using integration tests, you can test the solution your team builds as well as the infrastructure it's running on. In a future module, you'll see how functional tests can be added to your pipeline.

It's also possible to run other types of tests from a deployment pipeline, including performance tests and security penetration tests. These are outside the scope of this module.

## Rolling back and rolling forward

Suppose your pipeline deploys your resources successfully, but your tests fail. What should you do then?

Earlier in this module, you learned that Azure Pipelines enables you to create *rollback stages* that execute when a previous stage fails. You can use this approach to create a rollback stage when your test stage reports an unexpected result. You also could manually roll back your changes, or re-execute your entire pipeline if you think the failure was a temporary issue.

> [!NOTE]
> When you submit a deployment to Azure Resource Manager, you can request that Resource Manager automatically re-run your last successful deployment if it fails. To do this, use the `--rollback-on-error` command.

However, it's often challenging to work out what steps a rollback stage should perform. Bicep deployments are generally quite complex, and it's not easy to roll back changes. It's especially difficult to roll back when your deployment includes other components. For example, imagine your pipeline deploys a Bicep file that defines an Azure SQL database, and then adds some data to the database. When your deployment is rolled back, should the data be deleted? Should the database be removed too? It's difficult to predict how every failure and every rollback could impact your running environment.

For this reason, many organizations now prefer to *roll forward*, which means they quickly fix the reason for the failure and then deploy again. By building a high-quality automated deployment process, and by following all of the best practices you've learned throughout these learning paths, you'll be able to quickly fix issues and redeploy your Bicep files while maintaining high quality.

> [!TIP]
> One of the principles of a DevOps mindset is to learn from mistakes. If you have to roll back a deployment, carefully consider why the error happened, and add automated testing before your deployment starts to detect the same issue if it happens in future.
