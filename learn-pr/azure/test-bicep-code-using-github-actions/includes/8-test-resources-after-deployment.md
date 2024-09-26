By validating and previewing your Bicep deployment, you were able to build confidence that your Bicep files will successfully deploy. But deployment isn't the whole story. After the deployment finishes, it's also helpful to check that your deployment did what you expected.

In this unit, you'll learn about tests that you can run after your deployment finishes. You'll also learn about rolling back your deployment, if things don't turn out as you expected.

## Run smoke tests and negative tests

When you define resources in a Bicep file, your goal isn't just to create resources in Azure. It's to deliver value to your organization, while meeting your organization's requirements. When you validate and preview your Bicep files, you gain confidence that the resource definitions are valid. But you don't necessarily know that the resources actually do what you want.

For example, imagine that you deploy a new Azure SQL logical server by using a Bicep deployment workflow. Your Bicep definition for the server is valid, so it passes the linter and preflight validation jobs. The what-if command shows that a server will be created, which is what you expect. The deployment also finishes successfully. But at the end of the deployment process, you still might not have a working database server that's ready to use. Reasons might include:

- You didn't configure firewall rules to allow network traffic to reach your server.
- You enabled Microsoft Entra authentication on your server when you shouldn't have, or vice versa.

Even when you're just deploying basic Bicep files, it's worth considering how you can validate that the resources you deploy actually work and meet your requirements. Here are examples of how you can apply this principle:

- When you deploy a website, try to reach the web application from your workflow. Verify that your workflow connects to the website successfully and receives a valid response code.
- When you deploy a content delivery network (CDN), try to connect to a resource through the CDN. Verify that the workflow connects to the CDN successfully and receives a valid response code.

These tests are sometimes called _infrastructure smoke tests_. Smoke testing is a simple form of testing designed to uncover major problems in your deployment.

> [!NOTE]
> Some Azure resources aren't easy to reach from GitHub-hosted runners. You might need to consider using a self-hosted runner to run smoke test jobs if they require access to resources through private networks.

It's also a good idea to perform _negative testing_. Negative testing helps you to confirm that your resources don't have undesired behavior. For example, when you deploy a virtual machine, it's good practice to use Azure Bastion to securely connect to the virtual machine. You could add a negative test to your workflow to verify that you can't connect to a virtual machine directly by using Remote Desktop Connection or SSH.

> [!IMPORTANT]
> The goal of these tests isn't to verify that Bicep has deployed your resources correctly. By using Bicep, you're making the assumption that it will deploy the resources that you specify in your Bicep files. Instead, the goal is to verify that the resources that you defined work for your situation and meet your requirements.

### Run tests from GitHub workflows

There are many ways you can run tests in your workflow. In this module, we use Pester, which is an open-source tool that runs tests written through PowerShell. Pester is preinstalled on GitHub-hosted runners. You don't need to do anything special to use it in a script step.

You might choose to use a different test framework or even choose to run your tests without a test tool. For example, another test tool to consider is PSRule for Azure, which includes prebuilt rules and tests for Azure. It can run validation on your templates and also run tests against your deployed Azure resources. We link to PSRule in the summary.

When you run tests from a workflow, any test failures should stop the workflow from continuing. In the next exercise, you'll see how you can use workflows with infrastructure smoke tests.

Test results are written to the workflow log. The GitHub Marketplace also contains non-Microsoft actions that can display and track test results over time.

### Pass data between jobs

When you divide your workflow into multiple jobs, each with its own responsibility, you sometimes need to pass data between these jobs. For example, one job might create an Azure resource that another job needs to work with. To be able to pass data, the second job needs to know the name of the resource that was created. For example, our smoke test job needs to access the resources that the deployment job deployed.

Your Bicep file deploys the resources, so it can access the resource properties and publish them as deployment outputs. When you run your Bicep deployment through the `arm-deploy` action, this action stores these Bicep deployment outputs in its step outputs. Next, the job holding the `arm-deploy` action can now publish these step outputs as job outputs. The job references the step's `id` property, which we set to `deploy`:

:::code language="yaml" source="code/8-output-variable.yml" range="67-88" highlight="5-6, 16" :::

You can access a job's output in any subsequent job, as long as it depends on the job that produces the output:

:::code language="yaml" source="code/8-output-variable.yml" range="90-103" highlight="3, 9" :::

You can also pass outputs from a workflow script by using a special syntax. We link to more information in the summary.

### Other test types

_Functional tests_ and _integration tests_ are often used to validate that the deployed resources behave as you expect. For example, an integration test might connect to your website and submit a test transaction, and then wait to confirm that the transaction finishes successfully. By using integration tests, you can test the solution that your team builds, along with the infrastructure it's running on. In a future module, you'll see how these types of tests can be added to your workflow.

It's also possible to run other types of tests from a deployment workflow, including performance tests and security penetration tests. These tests are outside the scope of this module, but they can add value to an automated deployment process.

## Roll back or roll forward

Suppose your workflow deploys your resources successfully, but your tests fail. What should you do then?

Earlier in this module, you learned that GitHub Actions enables you to create _rollback jobs_ that run when a previous job fails. You can use this approach to create a rollback job when your test job reports an unexpected result. You also can manually roll back your changes, or rerun your entire workflow, if you think the failure was due to a temporary problem that was already resolved.

> [!NOTE]
> When you submit a deployment to Azure Resource Manager, you can request that Resource Manager automatically reruns your last successful deployment if it fails. To do this, use the `--rollback-on-error` parameter when you submit the deployment by using the Azure CLI `az deployment group create` command.

For example, you might add a rollback job to your workflow. The rollback job runs when the smoke test job fails:

:::code language="yaml" source="code/8-rollback.yml" :::

The job depends on the smoke test job. It only runs when the smoke test fails. By default, GitHub Actions stops the workflow whenever a previous job fails. The `if` condition includes an `always()` check to override this behavior. Without the `always()` in the expression, the rollback job is skipped whenever a prior job fails.

It's often challenging to work out the steps that a rollback job should perform. In general, Bicep deployments are complex, and it's not easy to roll back changes. It's especially difficult to roll back when your deployment includes other components.

For example, imagine that your workflow deploys a Bicep file that defines an Azure SQL database, and then adds some data to the database. When your deployment is rolled back, should the data be deleted? Should the database be removed too? It's hard to predict how every failure and every rollback might affect your running environment.

For this reason, many organizations prefer to _roll forward_, which means they quickly fix the reason for the failure and then deploy again. By building a high-quality automated deployment process, and by following all of the best practices you learned throughout these learning paths, you'll be able to quickly fix problems and redeploy your Bicep files while maintaining high quality.

> [!TIP]
> One of the principles of a DevOps mindset is to learn from mistakes. If you need to roll back a deployment, carefully consider why the error happened, and add automated testing before your deployment starts in order to detect the same problem if it happens in the future.
