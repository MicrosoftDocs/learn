In this unit, you'll learn about some of the factors to consider when you're choosing a build agent. You'll learn about some of the benefits and limitations of using a Microsoft-hosted agent, and what's involved when you set up your own private build agent.

## What are build agents and agent pools?

A _build agent_ is a system that performs build tasks. Think of it as a dedicated server that runs your build process.

Imagine that you have an Azure Pipelines project that receives build requests many times per day, or perhaps you have multiple projects that can each use the same type of build agent. You can organize build agents into _agent pools_ to help ensure that there's a server ready to process each build request.

When a build is triggered, Azure Pipelines selects an available build agent from the pool. If all agents are busy, the process waits for one to become available.

When you use a Microsoft-hosted agent, you specify the VM image to use from the pool. Here's an example from your existing build configuration that uses an Ubuntu 20.04 build agent:

```yml
pool:
  vmImage: 'ubuntu-20.04'
  demands:
  - npm
```

When you use a Microsoft-hosted agent, you use `vmImage` to specify which type of system you need. Microsoft provides many types of VM images, including ones that run Windows, macOS, and various flavors of Linux.

The `demands` section specifies which software or capabilities you require the build machine to have.

When you use a build agent from your own pool, also known as a _private pool_, you specify the name of your pool. Here's an example:

```yml
pool:
  name: 'MyAgentPool'
  demands:
  - npm
```

When you don't require a `demands` section, you can shorten the syntax like this:

```yml
pool: 'MyAgentPool'
```

You'll create a build agent and add it to a pool later in this module.

## What kind of agents can I use?

When you're choosing a build agent, there are two factors to consider:

* The operating system on which you want to build
* Whether you can use a Microsoft-hosted agent or you need to provide your own agent

Azure Pipelines supports these operating systems:

* [Windows](/azure/devops/pipelines/agents/windows-agent)
* [macOS](/azure/devops/pipelines/agents/osx-agent)
* [Linux](/azure/devops/pipelines/agents/linux-agent)

The build agent you choose depends mainly on what tools you use to build your code. For example, if you use Xcode to build your applications, you might choose a macOS agent. If you need Visual Studio, you'd likely choose a Windows agent.

Your existing build configuration uses a Microsoft-hosted agent. Hosted agents run on infrastructure that Microsoft provides for you.

A private agent uses infrastructure that you provide. Your agent can be a system that runs in the cloud or in your datacenter. Either system works, as long as the agent meets your requirements and can connect to Azure Pipelines. In this module, you'll use a VM that runs on Azure, which we provide.

## When should I use my own build agent?

For many build tasks, a Microsoft-hosted agent does everything you need. It's the easiest way to get started.

Microsoft takes care of all the security and other operating system updates for you. All you need to do is define the build configuration that you want to run.

Hosted agents also contain software for building many common types of applications. You can add any other software you need during the build process.

Microsoft-hosted agents have a few limitations, which include:

* **Build duration**: A build job can run for up to six hours.
* **Disk space**: Hosted agents provide a fixed amount of storage for your sources and your build outputs. This may not be enough storage.
* **CPU, memory, and network**: Hosted agents run on Microsoft Azure general purpose VMs. [Standard_DS2_v2](/azure/virtual-machines/dv2-dsv2-series#dsv2-series) describes the CPU, memory, and network characteristics you can expect.
* **Interactivity**: You can't sign in to a hosted agent.
* **File shares**: You can't drop build artifacts to Universal Naming Convention (UNC) file shares.

Although hosted agents are relatively easy to set up, there are some benefits to using your own build agents, keeping aside the limitations we just described.

For example, when you use hosted agents, you're sharing infrastructure with other Azure DevOps users. Although it ordinarily takes just seconds to start your build, it can take longer depending on the load on the Microsoft system.

Also, when you use hosted agents, you get a clean system with each build. When you bring your own build agent, you can decide whether to perform a clean build each time or perform an _incremental build_. With an incremental build, you build upon existing build tools and compiled code. An incremental build can take less time to complete, because the system already has many of the build tools and dependent components installed.

As a tradeoff, because the build infrastructure is yours, it's your responsibility to ensure that your build agents contain the latest software and security patches.

## How do you set up a private build agent?

A private build agent contains the software that's required to build your applications. It also contains agent software, which enables the system to connect to Azure Pipelines and receive build jobs.

When you set up a private agent, you provide the infrastructure on which the builds run. This gives you flexibility in how you bring up and maintain your agents.

For example, you can:

* **Set up the build agent manually**: You bring up the system, sign in, and interactively install your build tools and the agent software.
* **Automate the process**: You bring up the system and run a script or tool to install your build tools and the agent software. You can configure the agent after the system comes online or during the provisioning process.

    For example, when you run build agents on Azure, you can use an Azure Resource Manager template (ARM template) or Bicep to bring up the system and configure it to act as a build agent, all in one step. [Terraform](https://www.terraform.io?azure-portal=true) by HashiCorp is another way to automate the process. Terraform works with many types of infrastructure, including Azure.
* **Create an image**: You create an image—or snapshot—of a configured environment. You then use the image to create as many identical systems as you need in your pool.

Manual configuration is a good way to get started, because it enables you to understand the process. It's also the fastest way to get set up when you need just one build agent.

Automation is useful when you need many build agents, or you need to bring up and tear down build infrastructure on a regular basis. You can move from a manual process to an automated process when you need multiple agents.

Images are a form of automation. They can help save time, because all the software is preconfigured. As a tradeoff, you might need to periodically rebuild your images to incorporate the latest OS patches and build tools. [Packer](https://www.packer.io?azure-portal=true) by HashiCorp is a popular tool for creating images.

For your _Space Game_ scenario, you decide to use a private build agent.
