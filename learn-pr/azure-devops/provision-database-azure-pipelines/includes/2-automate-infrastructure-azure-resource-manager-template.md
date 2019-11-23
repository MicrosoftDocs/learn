The team would like to try using an *Azure Resource Manager template* to automate the deployment of the _Space Game_ web application. This includes the Azure SQL Server logical instance and the Azure SQL Database as well as the App Service Plan and App Service.

The web app is still in development and database schema changes will happen. The database administrator (DBA) is responsible for the integrity of the database and needs to approve any changes made to the schema before they are applied.

In the [Manage database changes in Azure Pipelines](https://docs.microsoft.com/learn/modules/manage-database-changes-in-azure-pipelines/?azure-pipelines=true) module, you created a pipeline with a stage that builds the .NET Core web app project and the SQL Server Data Tools database project. Then, you added a stage to discover changes to the database schema. The next stage that you added applied those schema changes if the DBA approved them. Then the web app was deployed.

As a reminder, here is the pipeline diagram from that previous module.

![Whiteboard image of the pipeline with the two database stages added](../media/2-whiteboard-pipeline.png)

The _Build_ stage has a job to build the web app and a job to build the database project. ![Callout 1](../../shared/media/callout-01.png) The database project build produces a _.dacpac_ file that is a build artifact.

The next stage ![Callout 2](../../shared/media/callout-02.png) scripts the database changes so that the ![Callout 3](../../shared/media/callout-03.png) DBA can verify the changes before the changes are applied.

An ![Callout 4](../../shared/media/callout-04.png) approval is added to the next stage that ![Callout 5](../../shared/media/callout-05.png) applies the database changes. The last three stages ![Callout 6](../../shared/media/callout-06.png) deploy to _Dev_, _Test_, and _Staging_ environments.

In that module, you created the infrastructure manually before you ran the pipeline. The _Dev_, _Test_, and _Staging_ stages all had identical infrastructure and shared a common database. As the web application project is maturing, the infrastructure needs for each of these stages is changing. The team is looking at Resource Manager templates to automate deploying infrastructure to each stage.

In this section you:

> [!div class="checklist"]
> * Learn about infrastructure as code using Resource Manager templates
> * Design a Resource Manager template for an Azure App Service and Azure SQL Database to use in Azure Pipelines.
> * Understand how to use Azure Key Vault to store and retrieve secrets using Resource Manager templates and Azure Pipelines.
> * Learn what is needed to add a Resource Manager template to Azure Pipelines.

Let's listen in on the morning meeting.

## The meeting

Andy has called the team together to discuss planning for the infrastructure changes that are the result of a maturing project.

**Andy:** Good morning everyone. We are getting closer to our release date and Tim and Amita have some concerns they want to talk about. Amita?

**Amita:** Tim and I have been talking about the current flow for our release and we believe it is time to push toward infrastructure that goes beyond development and is more like what the final product will need. For example, I need to test on machines with higher throughput and better redundancy. And staging needs to have data that is more real-world. Tim is concerned that this will slow down our release flow since he will have to provision all of these stages differently and maintain them. We are concerned how this will affect our pipeline.

**Mara:** I think I can help here. We have been trying out *infrastructure as code* with Terraform. Remember, infrastructure as code allows us to describe the infrastructure we need through code. This way we can maintain the application code and everything we need to deploy the application in our central code repository. It has been working well for us, but I have been wanting to try *Azure Resource Manager templates*. This might be a good time to try it as proof of concept. We could create a template with parameters for each stage so that each stage will be provisioned with what it requires. The pipeline can run the template and use a specific parameter file for the stage it is provisioning.

**Tim:** I was hoping you could do that. Automation to the rescue again. But what are *Resource Manager templates*?

### Infrastructure as code using Resource Manager templates

Recall that Resource Manager is the interface for managing and organizing cloud resources. A Resource Manager _template_ defines all the resources in a deployment, which enables you to deploy a Resource Manager template into a resource group as a single operation. We provide a link to a module on Resource Manager templates at the end of this module.

**Mara:** Resource Manager templates are JSON files that define all of the resources we need so that the Resource Manager can deploy the resources. We can get a *Quickstart template* to start with from the [Quickstart template gallery](https://azure.microsoft.com/resources/templates?azure-portal=true). These were created by the community with common infrastructure and would be a good place to start if we didn't already have infrastructure in place. Since we have infrastructure now, we can [export the entire resource group as a template from the Azure portal](https://docs.microsoft.com/azure/azure-resource-manager/export-template-portal?azure-portal=true), then just make any changes we need to make in that JSON file.

**Andy:** Let's start drawing out our plan.

*Andy moves to the whiteboard*

### Design a Resource Manager template for an Azure App Service and Azure SQL Database to use in Azure Pipelines

The template will need to have information passed in as parameters to have the reusability that the team needs. It will also need to output information from the created resources. For example, it may output the database connection string to use later in the pipeline. Let's listen in as the team decides what they will need in the template.

**Andy:** We will need to create template and parameter files and change the pipeline to use them. The only parameter so far is the resource name suffix representing the stage we are deploying to. For example, _dev_ for the development stage.

![Whiteboard image of the pipeline with the parameters and template files](../media/2-whiteboard-1.png)

What goes in the template?

*Mara pulls out her laptop and does a quick search.*

**Mara:** Everything we had to create manually the last time we worked with the database changes in the pipeline can now go in the template file. We can even deploy the database by using the *.bacpac* file. So that means we'll provision the SQL Server instance, the Azure SQL database, the App Service plan, and the App Service. I propose we create just the infrastructure we need for one stage. Let's start with the _Dev_ stage. Then we can reuse this template for the other stages; we just need to change the parameters we give the template.

**Andy:** Great. I'll draw that in.

![Whiteboard image of the pipeline with the parameters and template files and the bacpac file](../media/2-whiteboard-2.png)

**Tim:** But what about the administrator password for the SQL Server instance? I don't want that information to be stored in our repository.

*Andy does some typing on his laptop.*

### Use Azure Key Vault to store and retrieve secrets using Resource Manager templates and Azure Pipelines

*Azure Key Vault* enables you to securely store secrets. For example, you can store your API keys and passwords or anything that needs tight control over who has access to it.

**Andy:** It looks like we can store the administrator password in Azure Key Vault. The template parameter file can read from Key Vault.

*Andy draws on the whiteboard.* 

So now we have Key Vault and another parameter.

![Whiteboard image of the pipeline with the parameters and template files and key vault](../media/2-whiteboard-3.png)

**Tim:** Wait. The connection string to the database is sensitive data too, and we may need it again just like the administrator password. I suggest we add it to Key Vault as well.

**Mara:** Excellent idea! We can use the template to add the connection string to Key Vault. This means we will need the Key Vault name in the parameter file too. The template will need it.

*Andy updates the whiteboard.*

![Whiteboard image of the pipeline with the parameters and template files and key vault with connection string](../media/2-whiteboard-4.png)

**Tim:** Speaking of the pipeline, what changes do we need to make there?

### Add a Resource Manager template to Azure Pipelines

Adding a Resource Manager template to the pipeline is going to require a few changes to the current setup. The team needs to consider the new tasks that they need and how to work with Azure Key Vault. There is also a connection string to configure. Let's continue to listen in as they talk about pipeline changes.

**Mara:** Since we are only prototyping this for now, we are going to need unique names for the SQL Server and App Service instances. Let's add a variable to Azure Pipelines that specifies a unique suffix for the SQL Server name and App Service name. That way we can be sure that if we run the template again we have the same suffix. This ensures we don't break the idempotency of the template deployment. And we can use different variables for different deployments.

**Andy:** Right. I'll add pipeline variables to the diagram.

![Whiteboard image of the pipeline with the parameters and template files and key vault and pipeline variables](../media/2-whiteboard-5.png)

**Mara:** Now we need a task that will handle the template deployment. I found this one, [AzureResourceManagerTemplateDeployment@3](https://github.com/microsoft/azure-pipelines-tasks/blob/master/Tasks/AzureResourceManagerTemplateDeploymentV3/README.md?azure-pipelines=true). It has parameters for the template file and the template parameter file.

We also need to think about setting the connection string in the App Service. We could do that in the template, but then when we deploy the WebApp, it will get overwritten. So I think we need a task to set that after the web app is deployed.

**Andy:** I'm way ahead of you, Mara. I found the [AzureAppServiceSettings@1](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/azure-app-service-settings?view=azure-devops&azure-portal=true) task. But it needs the connection string. How do I get that out of the Key Vault?

**Tim:** We can get to it in the pipeline using the [AzureKeyVault@1](https://docs.microsoft.com/azure/devops/pipelines/tasks/deploy/azure-key-vault?view=azure-devops&azure-portal=true) task.

**Mara:** Excellent! This task will help us in a few stages.

*Andy updates the whiteboard.*

![Whiteboard image of the pipeline with the parameters and template files and key vault completed](../media/2-whiteboard-6.png)

**Andy:** If there are no other concerns, then I think we have a plan.

**Tim:** Let's start with a simple template and run it from Cloud Shell in the Azure portal. We can just pass in the parameters we need and create just the basic infrastructure. When we have that working, we can add the other pieces and deploy it from the pipeline. I'd like to lead on this part.

**Andy:** Great. Let me know how it turns out.
