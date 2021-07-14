With _pipelines_ you can automate the steps in your process. Each time you make a change to code and you check it into your shared repository, you want a fixed process to be run. This process can check certain standards you want to have in place and can automate the deployment steps. You can describe this process with an Azure DevOps pipeline. 

Pipelines are part of the Azure DevOps service. This service also contains repositories to store and share your code with all colaborators in your project. Pipelines are then the next step to automate the process that needs to run once new code gets checked into your repository.

In this unit, you'll learn about Azure DevOps pipelines.


## What are pipelines in Azure DevOps

_Pipelines_ in Azure DevOps can be used to automate your process. They contain all the steps you want to have executed to build and deploy your code changes. 

In Azure DevOps you describe a pipeline through a YAML file, which is a text file in the YAML format. The Azure DevOps service does provide a graphical interface for interacting with these YAML files to make their creation easier. Visual Studio Code provides an extension for editing Azure DevOps YAML pipeline files. 

> [NOTE!]
> Azure Pipelines also has classic pipelines, which are an older version of the pipelines feature. YAML-based pipelines have replaced classic pipelines, and in this module, we're only going to discuss YAML pipelines.

The big advantage of YAML pipelines is that they can be versioned together with the rest of your code, they are just part of your source code. You can thus follow up on all changes that were made to your pipeline through source control. They also contain more advanced features, like pipeline templates, which makes them highly reusable. 


### Pipelines use Agents and Pools

Now that you know what an Azure DevOps pipeline is, the question becomes how you can run such a pipeline. The pipeline itself needs some kind of compute to be able to run. This is similar to what you did locally in the previous modules for deploying your Bicep templates, you probably used your local computer or something similar. 

An Azure DevOps pipeline also needs some kind of compute to run on. In Azure DevOps this compute power is called an _agent machine_ or an _agent_ for short. It is a predefined virtual machine with pre-installed software on it that is able to run a YAML pipeline. The pre-installed software also includes all the Bicep and ARM tooling you already used in the previous modules. 

Azure DevOps has multiple types of these built-in agents, called Microsoft hosted agents. These Microsft hosted agents are available in an agent pool. An agent pool contains agents of the same type. The type of an agent can be a Windows based agent, an Ubuntu based agent and so on. The agents in the pool are waiting for pipelines that need to run. 


### Agents use Service Connections

You now know what a pipeline is and that it runs on an agent inside of an agent pool. Now, what if your pipeline needs to deploy Bicep code to Azure, for doing this, it will have to, somehow, authenticate to Azure. This is where Service Principals, which we covered in a previous module come in, as well as Service Connections. 

As we discussed in the previous module, a Service Principal is a means for an application to authenticate to Azure Active Directory and to get certain permissions for a specific scope in your Azure environment. For instance a Service Principal can get the Contributor permission within a certain Azure resource group to be able to deploy a Bicep template to this resource group. 

In Azure DevOps a Service Connection will wrap such a Service Principal for usage in a pipeline. You create a Service Connection by giving it a name and the details of your Service Principal: Subscription ID, Resource Group name, Service Principal ID and Secret. In your pipeline you can now reference the Service Connection by its name for usage in your pipeline. Your pipeline YAML code itself will hold no secret information, just the name of your service connection.

Once your pipeline executes, the agent machine it is executing on, will use this Service Connection and underlying Service Principal information to securely connect to Azure and to execute any scripts towards your Azure environment. It is a means of having your agent machine authenticate towards external resources, of which Azure can be one. 


### Creating a first YAML pipeline

Now that you know the basic concepts that live within Azure DevOps pipelines, let's look at a first sample pipeline. 

A YAML pipeline is a file in YAML syntax that contains the steps you want to execute in your pipeline. To create a first YAML pipeline you can create a file called first_pipeline.yml. 

Here is some sample YAML code, similar to the code Azure DevOps puts in a starter pipeline: 

```yaml
trigger: none

pool:
  vmImage: ubuntu-latest

jobs:
- job: 
  steps:
  - script: echo Hello, world!
    displayName: 'Run a one-line script'

  - script: |
      echo Add other tasks to build, test, and deploy your project.
      echo See https://aka.ms/yaml
    displayName: 'Run a multi-line script'
```

Let's look at each part in detail: 

- `trigger`: A pipeline always executes based on a certain event, called a trigger. A trigger is what triggers the execution of the pipeline. In the above example the pipeline will get executed when someone manually triggers the execution. You can automatically trigger a pipeline when your code changes or on a schedule, which you'll learn later in this module.
- `pool`: As we mentioned, a pipeline always executes on a certain machine, called an agent. In the above example we indicate that we want to execute our pipeline on an Ubuntu agent machine from the pool of Microsoft hosted agents.
- `steps`: A pipeline consists of several steps or tasks you would like to execute. The steps statement indicates the beginning of a list of these steps. 
- `script`: The two steps in the example are of type script. This means they execute script statements. In this example both script steps issue echo statements, which will write output to the Azure DevOps logging console. The `displayName` is a human readable name for the step, it will also be shown in the output once you run your pipeline.  
- `jobs`: A `step` in a pipeline is always part of a `job`. Each job in a pipeline runs on an `agent`, but a job can also be `agentless`. The steps within a job run in sequence and they all use the same agent machine to run on. If you have steps that need to run on a different type of agent machine, you should place them in a separate job and indicate the other agent machine type you would like to use. 

> [!NOTE]
> In YAML files there is one utterly important concept and that is indentation. As you can see in the above example, some lines are indented by a tab. These tabs are important for the YAML file to be properly interpreted. The Azure DevOps pipeline editor as well as the Visual Studio Code YAML pipeline extension will help you in finding and fixing errors in indentation.


## Brief overview of some important pipeline concepts 

Now that you've seen a first starter pipeline, let's bring all the concepts you've seen in this module together.

[insert image](https://docs.microsoft.com/en-us/azure/devops/pipelines/get-started/media/key-concepts-overview.svg?view=azure-devops)

A pipeline gets triggered by a certain event, called a `trigger`. This will start execution of the pipeline, wich is a `run`. The pipeline itself will consist of one or more `jobs`, each containing one or more `steps` that need to be executed. 

Each job will run an an `agent` machine taken from a `pool` of agent machines. 

A `step` in a pipeline indicates something you want to execute. It can either be a `script` or a `task`. A `task` is simply a pre-created script offered as a convenience for you. There are different types of predefined tasks available in Azure DevOps, like the dotnet build task or the Deploy ARM Template task. The build-in tasks allow you to run certain commands based on configuration instead of writing out the actual script statements. 

> [!NOTE]
> Some people prefer script statements to the build-in tasks, because they give you a better view and control of what is going on. With pre-defined tasks that you configure there is always a certain assumption on how they operate. 

A `step` in a pipeline might need to connect to some external system, like Azure. For making this possible a task can can indicate which `service connection` it wants to use for this. A `service connection` contains connection information for the external system. For connecting to Azure a service connection makes use of a `service principal`. The `service connection` and `service principal` are used by the `agent` machine running your `task`.


