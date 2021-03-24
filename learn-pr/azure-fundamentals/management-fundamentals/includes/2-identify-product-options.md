At a high level, there are two broad categories of management tools: visual tools and code-based tools.  

Visual tools provide full, visually friendly access to all the functionality of Azure.  However, visual tools might be less useful when you're trying to set up a large deployment of resources with interdependencies and configuration options.

When you're attempting to quickly set up and configure Azure resources, a code-based tool is usually the better choice.  Although it might take time to understand the right commands and parameters at first, after they've been entered, they can be saved into files and used repeatedly as needed. Also, the code that performs setup and configuration can be stored, versioned, and maintained along with application source code in a source code-management tool such as Git.  This approach to managing hardware and cloud resources, which developers use when they write application code, is referred to as *infrastructure as code*.

There are two approaches to infrastructure as code: *imperative* code and *declarative* code.  Imperative code details each individual step that should be performed to achieve a desired outcome.  By contrast, declarative code details only a desired outcome, and it allows an interpreter to decide how to best achieve that outcome.  This distinction is important because tools that are based on declarative code can provide a more robust approach to deploying dozens or hundreds of resources simultaneously and reliably.

## Your product options

Microsoft offers a variety of tools and services to manage your cloud environment, each aimed at different scenarios and users.

### The Azure portal

By using the Azure portal, a web-based user interface, you can access virtually every feature of Azure. The Azure portal provides a friendly, graphical UI to view all the services you're using, create new services, configure your services, and view reports. The Azure portal is how most users first experience Azure. But, as your Azure usage grows, you'll likely choose a more repeatable code-centric approach to managing your Azure resources.

### The Azure mobile app

The Azure mobile app provides iOS and Android access to your Azure resources when you're away from your computer. With it, you can:

- Monitor the health and status of your Azure resources.
- Check for alerts, quickly diagnose and fix issues, and restart a web app or virtual machine (VM).
- Run the Azure CLI or Azure PowerShell commands to manage your Azure resources.

### Azure PowerShell

Azure PowerShell is a shell with which developers and DevOps and IT professionals can execute commands called cmdlets (pronounced *command-lets*).  These commands call the Azure Rest API to perform every possible management task in Azure. Cmdlets can be executed independently or combined into a script file and executed together to orchestrate:
- The routine setup, teardown, and maintenance of a single resource or multiple connected resources.
- The deployment of an entire infrastructure, which might contain dozens or hundreds of resources, from imperative code.  

Capturing the commands in a script makes the process repeatable and automatable.

Azure PowerShell is available for Windows, Linux, and Mac, and you can access it in a web browser via Azure Cloud Shell.

Windows PowerShell has helped Windows-centric IT organizations automate many of their on-premises operations for years, and these organizations have built up a large catalog of custom scripts and cmdlets, as well as expertise.

### The Azure CLI

The Azure CLI command-line interface is an executable program with which a developer, DevOps professional, or IT professional can execute commands in Bash. The commands call the Azure Rest API to perform every possible management task in Azure. You can run the commands independently or combined into a script and executed together for the routine setup, teardown, and maintenance of a single resource or an entire environment.

In many respects, the Azure CLI is almost identical to Azure PowerShell in what you can do with it.  Both run on Windows, Linux, and Mac, and can be accessed in a web browser via Cloud Shell.  The primary difference is the syntax you use. If you're already proficient in PowerShell or Bash, you can use the tool you prefer.

### ARM templates

Although it's possible to write imperative code in Azure PowerShell or the Azure CLI to set up and tear down one Azure resource or orchestrate an infrastructure comprising hundreds of resources, there's a better way to implement this functionality.  

By using Azure Resource Manager templates (ARM templates), you can describe the resources you want to use in a declarative JSON format.  The benefit is that the entire ARM template is verified before any code is executed to ensure that the resources will be created and connected correctly. The template then orchestrates the creation of those resources in parallel. That is, if you need 50 instances of the same resource, all 50 instances are created at the same time.  

Ultimately, the developer, DevOps professional, or IT professional needs only to define the desired state and configuration of each resource in the ARM template, and the template does the rest. Templates can even execute PowerShell and Bash scripts before or after the resource has been set up.
