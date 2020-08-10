For each product option, provide a 150-200 word overview, the product logo (optional), and a conceptual-explainer image (optional). The goal is to introduce what each product is and what it can do without describing how to use it.



## Azure Management Product Options


### Azure Portal

The Azure Portal is a web based user interface that allows you access virtually every feature of Azure. The Azure Portal allows provides a friendly GUI to view all the services you're using, create new services, configure your services, and view the   The Azure Portal is how most users first experience Azure, though as your Azure usage grows, you'll likely choose a more repeatable code-centric approach to managing your Azure resources.

<div style="background=yellow;">Add a pic here</div>

### Azure Mobile App

- Monitor the health and status of your Azure resources
- Quickly diagnose and fix issues
- Run commands to manage your Azure resources

Track the health and status of your Azure resources
With the Azure mobile app, you don't need to be in front of your computer to keep an eye on your Azure resources such as VMs and web apps. Stay connected no matter where you are from your iOS or Android mobile device.

Diagnose and fix issues quickly
Check for alerts, view metrics, and take corrective actions to fix common issues. Restart a web app or connect to a VM directly. Be agile and respond to issues faster with the Azure mobile app.

Run commands to manage your Azure resources
Want to use the command line? Run ad hoc Azure CLI or PowerShell commands from the Azure mobile app.

Data is secure and encrypted

Apple App Store
Google Play Store

<div style="background=yellow;">Add a pic here</div>


### Azure PowerShell

Azure PowerShell is a shell that allows developers, DevOps and IT professionals execute commands called cmdlets, or "command-lets".  These commands call the Azure Rest API to perform every possible management task in Azure. The cmdlets can be executed independently or combined into a script file and executed together to orchestrate routine setup, tear-down, and maintenance of a single resource, multiple connected resources, or orchestrate the deployment of an entire infrastrcture containing dozens or hundreds of resources from imperative code.  This makes the process repeatable and automatable.

Azure PowerShell is available for Windows, Linux, and Mac, and can be accessed in a web browser via the Cloud Shell.

Windows PowerShell has helped Windows-centric IT organizations automate much of their on-prem operations for many years and have built up a large catalog of custom scripts and cmdlets, as well as expertise.

<div style="background=yellow;">Create some example code here</div>

### Azure CLI

The Azure CLI (Command Line Interface) is an executable program that allows developers, DevOps and IT professionals execute commands using bash.  The commands call the Azure Rest API to perform every possible management task in Azure.  The commands can be run independently or combined into a script and executed together to orchestrate routine setup, tear-down, and maintenance of a single resource or an entire environment.

In many respects, it is almost identical to Azure Powershell in what you can do.  Both run on Windows, Linux, and Mac, and can be accessed in a web browser via the Cloud Shell.  The primary difference is the syntax.  Those who are already proficient in PowerShell can remain productive using their PowerShell expertise, while those proficient in bash can continue using it.

<div style="background=yellow;">Create some example code here</div>

### Azure Resource Manager Templates

While it's possible to write imperative code in Azure PowerShell or the Azure CLI to setup and tear-down one Azure resource or orchestrate an entire infrastructure containing dozens or hundreds of resources, there's a better way to do this.  Azure Resource Manager (ARM) Templates allow you to describe the resources you want to use in a declarative JSON format.  The benefit is that the entire ARM Template is verified first before any code is executed to ensure the resources will be created and connected correctly, then it orchestrates the .  Ultimately, the developer, DevOps or IT professional just needs to define the desired state and configuration of each resource in a template, and the Azure Resource Manager does the rest.  Templates can even execute PowerShell and Bash scripts before or after the setup of a resource.

<div style="background=yellow;">Create some example code here</div>