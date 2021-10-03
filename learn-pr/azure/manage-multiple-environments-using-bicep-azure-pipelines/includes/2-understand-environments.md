With _pipelines_ you can automate the steps in your process. This process might have a need for multiple environments. You may want to first review the changes in a pre-production environment before you move the changes to your production environment. 

In this unit, you'll learn about environments in Azure DevOps.

## Why do you have multiple environments?

When setting up and executing a deployment process, this process will make changes to the resources you already have up and running. This also involves a risk, since the changes you want to deploy may not behave as expected, or they might even break your current setup. To avoid this risk, it is a good practice to test out the changes you made in a different environment before you deploy them to your production environment. This is then called a pre-production environment. 

In a lot of cases you will even see that for better confidence in what is being deployed, people set up a couple of environments that get deployed to one after the other before they deploy to production. Each environment then serves a specific purpose. with each environment the deployment moves through, the confidence in what you're deploying gets higher. 

A couple of sample environments you may come across are: 

- _Development_: This environment is typically only for developers to iterate their changes in and to test things out. You might use this environment to test out a certain configuration setting on a resource or to set up a new website with backend database in a secure way. A lot of these changes and trials might not even make it to production, since developers are testing things out. Only once they are confident their changes serve a business feature correctly, will they give the go to push the changes through to the next environment. Sometimes, often in larger teams, you may see even a development environment per developer, so people don't get in each others' way while working on new features. 
- _Test_: A test environment is typically an environment being used in a continuous integration process. This environment can be used to run automated tests against. If all automated tests are successful, whatever change someone wants to integrate in the main branch of the project, is ok to be merged. You might for instance test whether there are no policy violations in the newly deployed resources. 
- _Integration_: This environment is typically used to run tests that have to do with integration with other systems. Often these tests are also run automatically. This environment is often also called System Integration Testing environment or SIT for short. 
- _User Acceptance Test (UAT)_: Used to run manual tests against, where someone goes through the application and approves the changes that were made comply with the business feature that was asked. 
- _Demo_: Your team might also want to use a demo environment that holds all the last features to show the application to end users, or to be used in trainings of the application, or a demo environment might be used by sales teams to show off certain capabilities. A demo environment is often a exact replica of your production environment, but without any real life production data. It might even be that you have multiple of these demo environments that serve different purposes.
- _Pre-production/Staging_: This is an environment that is often an exact mirror of the production environment. It is used to test how the deploy to production will behave and what the resulting environment will look like. It can also be used test out any expected downtime during deployment.
- _Production_: This is the environment that end users of the application will be using. It is your live environment that you want to protect and keep up and running as much as possible. 

You might see variations of the above and maybe more or less environments depending on the application, the size of the team involved, or the importance of the workload. Sometimes some of the roles of the above environments get combined into 1 environment, or they might even be split up further, for instance a production environment that exists in 2 different regions for high availability. 

The main goal of multiple environments is to enhance the confidence you have in a change when it moves from one environment to the next. Also, when a change does not make the bar, you want to be able to stop deployment of that change to any next environment in the chain. 

## Azure Pipelines environments concept and features

Azure pipelines also knows the concept of environments. You can use them to mimic in your pipeline the environments that you have in Azure. In your pipeline you link any deployment jobs that you have to a specific environment you have defined. When using environments, you can also add some additional features to your deployments.

### Checks and Approvals on environments

An environment in Azure DevOps can have checks and approvals on it. Each time the environment is used in a job in your pipeline, Azure DevOps will make sure these checks and approvals succeed before the job starts executing. 

You could require a manual approval on a job that deploys to your production environment. The approver will get an email notification before the job executes and can manually verify your policies and procedures are met before approving the deploy to your production environment. The approver can for instance look in the pre-deployment environment whether the deploy there looks as expected and if it does, approve the deploy to production. 

Or you could run an automated check to see whether the deployment to the pre-production environment didn't violate any policy assignments you might have before further deploying to production. 

Checks and approvals on environments are a way for you to stop further execution of a pipeline in case anything does not look as expected in a previous environment. 

### Security on environments

You can put additional security on environments in Azure DevOps. Security on environments can be done both with user permissions as well as with pipeline permissions. 

With **user permissions** you can control who can create, view, use and manage your environment. This is done through the respective Creator, Reader, User and Administrator roles: 

- _Creator_: This role allows its members to create environments. Contributors of your Azure DevOps projects are added as member to this role by default. 
- _Reader_: Members of this role can only view the environment.
- _User_: Members of this role can use the environment when authoring YAML pipelines. 
- _Administrator_: Members of this role get the same permissions as the _User_ role, additionally they can also manage all other permissions. 

You need to take extra care when creating environments through YAML pipelines. Environments that get created like this, automatically get contributors and project administrator added to the _Administrator_ role. This is not always the behavior you would like and you should only create environments through your YAML pipeline for development and test environments. For production environments you should create the environment through the Azure DevOps UI and set preferred security directly. 

Next to user permissions, you can also set **pipeline permissions**. These let you define which pipelines in your project (or even across projects) are allowed to use a specific environment. This can be used to lock down a certain environment to some well-defined pipelines that you have created. 


### View deployment history

When working with environments, you environment can show you a history of any deployments that happened towards that environment. This gives you a nice way to track back what happened in the environment overtime. It even allows you to track back a deployment to a certain feature request in your DevOps work items or a specific commit in your repository. 

This capability is very handy in case you see a problem with a certain deployment to track back which change led to that specific problem. 


## Service connections when you work with multiple environments

Once you start using multiple environments, you want to make each environment completely independent from each other environment. Your development environment shouldn't have any access to your production environment and vice versa. This principle also goes for any deployment pipeline resources you are using. The service connection you use to deploy to your development environment shouldn't be able to access your production environment. 

The above principle is needed, since you don't want a deployment to your development environment to potentially influence or even bring down your production environment. 

This is why you should always create completely separate service connections per environment and each of your service connections should use their own dedicated service principal with specific permissions to only deploy to the subscription and resource group it needs. 

> [!IMPORTANT]
> Use a service connection per environment you plan to deploy to. Each service connection should use its own service principal with specific (least privilege) permission. 

In your Azure setup you also may want to take this principle of separation of environments into account. In a minimal setup this means to use at least a separate resource group per environment and put proper RBAC in place on each resource group. In case you need network integrated resources, you also separate these on the networking layer so there is no connection between development and production or any other environments. 

When you want to have even better separation of environments, you use a different subscription for each environment. Since resources often get spread over multiple resource groups - you might have multiple applications you need to deploy, each residing in their own resource group - using a subscription for a specific environment gives you even better separation of concerns and better security. You can then limit access to your production subscription to a very limited set of people and roles. 

