After you improve your Bicep file during the refactor phase, you need to test your file and deploy it to your Azure environment. The fourth and fifth phases of the recommended workflow are the *test* phase and the *deploy* phase:

:::image type="content" source="../media/6-test-deploy-phases.png" alt-text="Diagram that shows the test and deploy phases of the recommended workflow for migrating Azure resources to Bicep." border="false":::

The main focus of these two phases is to test your Bicep file by using the available tools and then deploy your file to your Azure environment.

## Test phase

The goals of the test phase of migrating your resources to Bicep are to verify the integrity of your migrated templates and to do a test deployment.

The test phase consists of two steps that you complete in this order:

1. Run the ARM template deployment what-if operation.
1. Do a test deployment.

:::image type="content" source="../media/6-test.png" alt-text="Diagram that shows a Bicep file being tested and deployed to Azure." border="false":::

The what-if operation provides a preview of the changes that will be made when you deploy your Bicep file. You use a test deployment to compare your original resources with the newly deployed resources.

### What is the ARM template deployment what-if operation?

When you deploy new resources or modify existing resources, it's possible to introduce breaking changes to your environments. Your deployment might modify or delete existing resources, create incorrectly configured new resources, or affect the overall functionality of your application.

The [ARM template deployment what-if operation](/azure/azure-resource-manager/templates/deploy-what-if) can help you verify your converted templates before you deploy them. It compares the current state of your environment with the intended state that's defined in the template. The tool outputs the list of changes that will occur without applying the changes to your environment. This process can increase your confidence level in your deployments. You can use what-if with both incremental and complete mode deployments. Even if you plan to deploy your template by using incremental mode, it's a good idea to run your what-if operation in complete mode. Running the what-if operation helps you identify any resources you might have accidentally left out of your template.

> [!NOTE]
> The what-if operation might list some resource properties as deleted when they actually won't change. Those results are considered _noise_.

### Test deployment

Before you introduce your converted Bicep template to production, consider running multiple test deployments. If you have multiple environments (production, dev, test), you might first want to try deploying your template to one of your non-production environments. After the deployment, compare the original resources for consistency with the new resource deployments.

> [!TIP]
> If you don't have access to a non-production environment to test your deployment, deploy your Bicep template to a new environment instead.

## Deploy phase

The goal of the deploy phase of migrating your resources to Bicep is to deploy your final Bicep file to production. Before the production deployment, you should consider a few things.

The deploy phase consists of four steps, which you complete in this order:

1. Prepare a rollback plan.
1. Run the what-if operation against production.
1. Deploy the Bicep file manually.
1. Run smoke tests.

These steps help you prepare for any possible problems with production deployments.

:::image type="content" source="../media/6-deploy.png" alt-text="Diagram that shows a Bicep file being deployed to Azure." border="false":::

### Prepare a rollback plan

The ability to recover from a failed deployment is crucial. Spend time developing a rollback plan to use if any breaking changes are introduced into your environments. Your plan should take into account your organization's business continuity and disaster recovery (BCDR) strategy. Take inventory of the types of resources that are deployed, like virtual machines, web apps, and databases. You should also consider each resource's data plane. Do you have a way to recover a virtual machine and its data? Do you have a way to recover a database after it's deleted or to recover data from a storage account? A well-developed rollback plan helps keep your downtime to a minimum if any problems arise from a deployment.

### Run the what-if operation against production

You've already run the what-if operation against your other environments to verify that your new Bicep file won't cause any breaking changes. Before you deploy your final Bicep file to production, run the what-if operation against your production environment. Be sure to use production parameter values, and consider documenting the results.

### Deploy manually

If you'll use the converted template in a pipeline, like in Azure DevOps or GitHub Actions, consider running the deployment from your local machine first. It's better to verify the functionality of the template before you add the template to your production pipeline. After you see how the template functions, you can respond quickly if there's a problem.

### Run smoke tests

When your deployment is finished, it's a good idea to run a series of _smoke tests_. A smoke test is a simple check that validates that your application or workload functions. For example, test to see whether your web app is accessible through normal access channels, like the public internet or across a corporate VPN. For databases, try to make a database connection and run a series of queries. With virtual machines, sign in to the virtual machine and make sure that all services are running.
