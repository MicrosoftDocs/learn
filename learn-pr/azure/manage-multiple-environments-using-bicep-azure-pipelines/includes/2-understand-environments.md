Deployment pipelines enable you to automate the steps in your deployment process. Often, you need to run the process in multiple separate environments. For example, you might want to first review the changes in a pre-production environment before you deploy the changes to your production environment.

In this unit, you'll learn about environments in Azure DevOps.

## Why do you have multiple environments?

Deployment processes make changes to your Azure resources, including those that are in use. Changing resources involve some risk, because the changes you deploy may not behave as you expect. You might even discover that the changes break your current setup. To minimize the risk of this happening, it's a good practice to try out your changes in a safe way before you deploy them to your production environment. You do this by deploying the changes to a *pre-production* or *non-production environment*.

Many organizations take this further, and set up multiple non-production environments that they progressively deploy their changes to before releasing to production. Each non-production environment serves a specific purpose. As your deployment moves through each environment, your confidence in the changes gets higher.

Some common non-production environments include the following:

- **Development**: A development environment is typically used by developers to try their changes in, and to quickly iterate on their work. Development environments often have minimal controls applied to them to help make it easy and quick to try out ideas. You might use a development environment to test out a certain configuration setting on a resource, or to see how you can set up a new website with backend database in a secure way. A lot of these changes and trials might not even make it further in your deployment process, since you're just testing things out and excluding the ideas that don't succeed. After you're confident that a change serves its purpose, you'll allow it to progress to the next environment. In some teams, you might even set up a separate development environment for each team member so that they don't get in each other's way while they're working on new features. Development environments are sometimes also called *sandbox* environments.
- **Test**: A test environment is generally used in a continuous integration process. After a change is deployed to a test environment, automated tests can be run against it. If all of the automated tests pass, then the change is safe to merge into the main branch of the project. Automated tests usually check for the core system functionality, as well as things like policy violations in the newly deployed resources.
- **Integration**: An integration environment is used to run automated or manual tests that have to do with integration with other systems. Often these tests are also run automatically, but many organizations also perform manual testing against this environment. Integration environments are sometimes also called *System Integration Test* or *SIT* environments.
- **User Acceptance Test**: A user acceptance test (UAT) environment is used for manual validation. Manual validation is where someone goes through the solution and verifies it behaves as they expect, including that it achieves the necessary business requirements. They then approve the changes that were made so that the deployment can continue.
- **Pre-production**: The pre-production environment is often a mirror of the production environment, with the same resource SKUs and configuration. It's used as a final check to verify how the production deployment will behave and what the resulting environment will look like. It can also be used verify whether to expect any downtime during the production deployment. Pre-production environments are sometimes also called *staging* environments.
- **Production**: Your production environment is the one that end users of the application use. It is your live environment that you want to protect and keep up and running as much as possible. In some organizations you might have multiple production environments, such as in different geographic regions or to serve different groups of customers.
- **Demo**: Your team might also create demo environments to show the application to end users, to be used in training, or for sales teams to show certain capabilities to potential customers. A demo environment is often a slimmed down replica of your production environment, but without any real production data. It might even be that you have multiple of these demo environments that serve different purposes.

You might see variations of these environments. Many organizations only use a few environments, and some use many more. The number and type of environments you use depend on the solution you're deploying, the size of the team building the solution, and the importance of the workload. Sometimes, some of the roles of the above environments get combined into a single environment.

Whatever your organization chooses as their list of environments, the goal is to enhance the confidence you have in a change as it progresses through your deployment pipeline. When a change does not meet your quality requirements, you want to be able to stop the deployment of that change to any subsequent environments in the chain.

In your toy company, you decide you'll start with a basic set of environments for your website. In addition to your production environment, you'll create one non-production environment:

:::image type="content" source="../media/2-environments.png" alt-text="Diagram showing two environments - non-production and production." border="false":::

You'll update your pipeline to deploy to your non-production environment. If that succeeds, you'll deploy to your production environment.

Your pipeline will use several stages to deploy to each environment:

:::image type="content" source="../media/2-stages.png" alt-text="Diagram showing a series of pipeline stages, including those for non-production and production deployments." border="false":::

## Pipeline environments

Azure Pipelines also has the concept of an environment. You create an Azure Pipelines environment to represent the environment you have in Azure. When you define your pipeline in a YAML file, you link your deployment jobs to a specific environment. By using environments, you get a few benefits and additional features in your pipeline.

### Checks and approvals

An environment in Azure DevOps can have checks and approvals on it. Each time the environment is used in a job in your pipeline, Azure DevOps will make sure these checks and approvals succeed before the job starts executing.

Manual approvals can be applied to the job that deploys to your production environment. The approver will get an email notification before the job executes and can manually verify your policies and procedures are met before approving the deployment to your production environment. For example, the approver might check that everything is working as they expect in the pre-production environment before they approve the deployment.

Or, you could run an automated check to see whether the deployment to the pre-production environment hasn't resulted in an increase in the number of errors reported to Azure Monitor. After the check validates the number of errors hasn't substantially increased, it can allow the deployment to proceed.

### Deployment history

Azure Pipelines tracks the history of an environment, including the list of deployments that happened. This gives you a nice way to track back what happened in the environment overtime. It even allows you to track back a deployment to a certain feature request in your DevOps work items or a specific commit in your repository. 

This capability is very handy in case you see a problem with a certain deployment to track back which change led to that specific problem. 

### Security

You can apply additional security controls to environments. You can restrict the pipelines that are allowed to use a specific environment, to avoid someone accidentally creating a secondary pipeline that interacts with your production environment.

You can also apply user permissions to control the users who can manage environments. There are different permissions that allow users to create new environments, to modify environments, and to view environments and the history of deployments to them.

> [!NOTE]
> When your pipeline refers to an environment that doesn't exist yet, Azure Pipelines automatically creates it for you. This can affect the security of your Azure DevOps project because you will automatically be given administrative permissions to the environment. It's best to create environments yourself through the Azure DevOps web interface, so that you don't accidentally get permissions you don't need.

## Service connections when you work with multiple environments

When you use multiple environments, you should make each environment independent from all others. For example, your development environment shouldn't have any access to resources within your production environment. This principle also applies to the deployment pipeline's resources. The service connection you use to deploy to your development environment shouldn't be able to access your production environment. This adds another layer of protection to ensure that your non-production deployments don't affect your production environment.

You should create separate service connections for each environment. Each service connection should use its own dedicated service principal, with specific permissions to only deploy to the subscription and resource group used by that environment.

:::image type="content" source="../media/2-service-connections.png" alt-text="Diagram showing a service connection, service principal, and Azure resource group for non-production and another set for production." border="false":::

> [!IMPORTANT]
> Use a separate service principal and service connection for each environment you plan to deploy to. Grant the service principal the least permissions it needs to be able to deploy to its environment.

In your Azure configuration, it's also a good idea to separate your environments. At the very least, you should create a separate resource group for each environment. In many situations, it's better to create separate Azure subscriptions for each environment so that you can create multiple resource groups within each environment's subscription.

Apply Azure role assignments so that users and service principals can only access the environments they need. In particular, limit the access to your production subscription to a very small set of people and the deployment service principal for your production environment.
