At a high level, there are two types of management tools: visual tools and code-based tools.  The visual tools provide full access to all of the functionality of Azure in a friendly visual manner.  However, visual tools may be less useful when trying to set up a large deployment of resources with interdependencies and configuration options.

When attempting to quickly set up and configure Azure resources, a code-based tool is usually the better choice.  While it may take time to understand the right commands and parameters at first, once typed, they can be saved into files and used repeatedly as needed.  Furthermore, the code that performs setup and configuration can be stored, versioned, and maintained along with application source code in a source code management tool like git.  This approach to managing hardware and cloud resources using the same mindset that developers use when they write application code is referred to as "infrastructure as code".

There are two approaches to "infrastructure as code": imperative and declarative code.  Imperative code details each individual step that should be performed to achieve the desired outcome.  By contrast, declarative code details only the desired outcome, and allows an interpreter to decide how to best achieve that outcome.  This distinction is important because tools that are based on declarative code can provide a more robust approach to deploying dozens or hundreds of resources simultaneously and reliably.

## Product options

Microsoft offers several different tools and services to manage your cloud environment, each aimed at different scenarios and users.

### Azure portal

The Azure portal is a web-based user interface that allows you access virtually every feature of Azure. The Azure portal provides a friendly GUI to view all the services you're using, create new services, configure your services, and view reports. The Azure portal is how most users first experience Azure, though as your Azure usage grows, you'll likely choose a more repeatable code-centric approach to managing your Azure resources.

### Azure mobile app

The Azure mobile app provides iOS and Android access to your Azure resources when you're away from your computer. You can do things like:

- Monitor the health and status of your Azure resources
- Check for alerts, quickly diagnose and fix issues, restart a web app or VM
- Run Azure CLI or PowerShell commands to manage your Azure resources

### Azure PowerShell

Azure PowerShell is a shell that allows developers, DevOps and IT professionals execute commands called cmdlets, or "command-lets".  These commands call the Azure Rest API to perform every possible management task in Azure. The cmdlets can be executed independently or combined into a script file and executed together to orchestrate routine setup, tear-down, and maintenance of a single resource, multiple connected resources, or orchestrate the deployment of an entire infrastructure containing dozens or hundreds of resources from imperative code.  Capturing the commands in a script makes the process repeatable and automatable.

Azure PowerShell is available for Windows, Linux, and Mac, and can be accessed in a web browser via the Cloud Shell.

Windows PowerShell has helped Windows-centric IT organizations automate many of their on-prem operations for many years and have built up a large catalog of custom scripts and cmdlets, as well as expertise.

### Azure CLI

The Azure CLI (Command Line Interface) is an executable program that allows developers, DevOps, and IT professionals execute commands using bash.  The commands call the Azure Rest API to perform every possible management task in Azure.  The commands can be run independently or combined into a script and executed together to orchestrate routine setup, tear-down, and maintenance of a single resource or an entire environment.

In many respects, it is almost identical to Azure PowerShell in what you can do.  Both run on Windows, Linux, and Mac, and can be accessed in a web browser via the Cloud Shell.  The primary difference is the syntax.  Those users who are already proficient in PowerShell can remain productive using their PowerShell expertise, while those users proficient in bash can continue using it.

### Azure Resource Manager Templates

While it's possible to write imperative code in Azure PowerShell or the Azure CLI to setup and tear-down one Azure resource or orchestrate an entire infrastructure containing dozens or hundreds of resources, there's a better way implement this functionality.  Azure Resource Manager (ARM) Templates allow you to describe the resources you want to use in a declarative JSON format.  The benefit is that the entire ARM Template is verified first before any code is executed to ensure the resources will be created and connected correctly, then it orchestrates the creation of those resources in parallel, meaning, if you need 50 instances of the same resource, all 50 instances are created at the same time.  Ultimately, the developer, DevOps, or IT professional just needs to define the desired state and configuration of each resource in a template, and the Azure Resource Manager does the rest.  Templates can even execute PowerShell and Bash scripts before or after the setup of a resource.