# Module Design

## Title

Choose a compute provisioning solution for your application

## Role(s)

- Solution architect

## Level

- Beginner

## Product(s)

- Resource manager templates
- VM extensions (custom script and DSC extensions)
- Azure Automation State Configuration
- Discussion of third-party tools (Chef, Terraform, etc.)

## Prerequisites

- Basic knowledge of Azure virtual machines
- Basic knowledge of PowerShell

## Summary

Discover the services and tools available to automate the deployment and configuration of your Azure infrastructure.

## Learning objectives

1. Identify the solutions available to provision compute on Azure
2. Choose an appropriate provisioning platform based on your requirements

## Chunk your content into subtasks

Identify the subtasks of *Choose a compute provisioning solution for your application*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- |---|---|---|---|
|Identify the technology options | What tools are available on Azure to provision compute | Knowledge check | 1 | Yes  |
| Analyse the decision criteria | Choose an appropriate provisioning platform | Knowledge check | 1 & 2 | Yes |
| Analyse a scenario and map it to a technology option | Automating deployment to improve operational abilities | Exercise  | 1 & 2 | Yes |
||||||

## Outline the units

1. **Introduction**

    Suppose you are the solution architect for an organization that is moving several applications to Azure Virtual Machines (VMs). The company needs to scale out to a many VMs now and in the future. Their current manual process is time consuming and error prone. They want to automate the scale out process to improve operational abilities. They are unsure of what tools are available on Azure to provision compute resource, and where each fits in to the overall provisioning process.

1. **Identify the provisioning solutions for Azure compute infrastructure**

    There are several solutions available to provision compute on Azure. VM extensions provide post-deployment configuration, automation, software installation, or any other configuration or management task. There are few extensions available to help you systemize and automate VM deployment:

    - **Custom scripts** - The Custom Script Extension downloads and runs scripts on Azure VMs. This is useful for post deployment configuration, software installation, or any other configuration or management tasks.
    - **DSC extensions** – These extensions constitute a management platform that you can use to manage your IT and development infrastructure with configuration as code. The extension uploads and applies a PowerShell DSC Configuration on an Azure VM.
    - **Chef** – Chef is a powerful automation platform that transforms infrastructure into code. It supports cloud, on-premises, or hybrid environments. Chef automates how infrastructure is configured, deployed, and managed across your network, no matter its size. The Chef VM Extension enables Chef on VMs.
    - **Terraform** - Terraform is an open source infrastructure as code software tool. Terraform allows you to define and provision datacentre infrastructure using high level configuration language, also known as Hashicorp Configuration Language (HCL). This is created by Hashicorp. Alternately you can also use JSON (JavaScript Object Notation).
    - **Azure Automation State Configuration** - Azure Automation provides complete control of automation and configuration service. It is cloud-based automation and configuration service that provides consistent management across your Azure and non-Azure environments. Azure Automation State Configuration is an Azure service that enables you to write, manage, and compile PowerShell Desired State Configuration (DSC) configurations. It lets you import DSC Resources, and assign configurations to target nodes in the cloud. it also has built in templates that you can use. It lets you set up runbooks to respond to triggers.
    - **Azure Resource Manager templates** – Azure Resource Manager allows you to provision your applications by using a declarative template. ARM templates use a simple JSON file. JSON is an open-standard file format derived from JavaScript. In a single template, you can deploy multiple services along with their dependencies. You use the same template to repeatedly deploy your application during every stage of the application lifecycle.

1. **Choose a native Azure solution**

    So, the big question now is how do you decide which tools to use to provision compute?

    The right provisioning tools depend on your problem, the size of your infrastructure and the outcome you want to achieve. As these criteria would vary from network to network, here are few fundamental metrics that we can use to determine which tool is more suitable for provisioning compute:

    - Scalability
    - Ease of set up
    - Management
    - Interoperability
    - Configuration language
    - Limitations/Drawbacks

    Consider each of the following tools and advantages or disadvantages under each of the above metrics:

    - Custom script:

        - Scalability – Not scalable, custom scripts are great for small networks but if you have to provision 500+ VMs they are not ideal.
        - Ease of set up - Easy to set up, the custom script extension is built into the Azure Portal.
        - Ease of management - Management of custom scripts can get tricky as your infrastructure grows and you accumulate different customer scripts for different resources.
        - Interoperability - The custom script extension integrates with Azure Resource Manager templates, and can be run using the Azure CLI, PowerShell, Azure portal, or the Azure Virtual Machine REST API.
        - Configuration language – PowerShell
        - Limitations/Drawbacks - There are 90 minutes allowed for each script to run. Anything longer will result in a failed provision of the extension. Don't put reboots inside the script - this action will cause issues with other extensions that are being installed. After a reboot, the extension won't continue. If you have a script that will cause a reboot, then install applications and run scripts, you can schedule the reboot using a Windows Scheduled Task, or use tools such as DSC or Chef extensions. The extension will only run a script once. If you want to run a script on every boot, then you need to use the extension to create a Windows Scheduled Task
        - Scenario - Present a short scenario, in which the best solution is to use custom scripts.
        - Summary - the custom script extension is useful for post-deployment configuration, software installation, or any other configuration or management task. It’s imperative for ad-hoc cross-platform scripting. But for large infrastructure deployment and automation, it is not ideal.  

    - Azure Desired State Configuration (DSC) extension:

        - Scalability – The DSC extension is more scalable than custom scripts.
        - Ease of set up – The primary use case for the DSC extension is to bootstrap a VM to the Azure Automation State Configuration (DSC) service. The setup is fairly easy.
        - Management – DSC democratizes configuration management across servers.
        - Interoperability – to deploy DSC you can use Azure portal or the Azure PowerShell SDK 
        - Configuration language - PowerShell
        - Limitations/Drawbacks – DSC is not automating continuance compliance checks and enforcing continuance compliance. It lacks the ability to track changes, compliance across environments or orchestrate configuration changes.
        - Scenario - Present a short scenario, in which the best solution is to use DSC.
        - Summary – DSC is a management platform that enables you to manage your IT and development infrastructure with configuration as code. But it lacks the ability to automate continuance compliance checks across environments or orchestrate configuration changes.

    - Azure Automation State Configuration

        - Scalability - Highly scalable
        - Ease of set up - It’s not difficult to set up but it requires the user to familiar with the Azure portal
        - Management - Very easy to manage. All Nodes that are managed with Azure Automation State Configuration send detailed reporting status data to the built-in pull server. You can configure Azure Automation State Configuration to send this data to your Log Analytics workspace.
        - Interoperability - Azure Automation State Configuration provides a DSC pull server similar to the Windows Feature DSC-Service so that target nodes automatically receive configurations, conform to the desired state, and report back on their compliance. Azure Automation can target virtual or physical Windows or Linux machines, in the cloud or on-premises.
        - Configuration language – PowerShell
        - Scenario - Present a short scenario, in which the best solution is to use Automation State Configuration.
        - Summary - The Azure Automation service allows you to manage DSC configurations, resources, and managed nodes from within Azure. Using PowerShell DSC is great when you have few VMs to administrate.  However, if you have many VMs, Azure Automation State Configuration is ideal for handling them and ensuring that all have uniform features and configurations. Azure Automation State Configuration is an Azure service that allows you to write, manage, and compile PowerShell Desired State Configuration (DSC) configurations, import DSC Resources, and assign configurations to target nodes, all in the cloud.

    - Azure resource manager templates

        - Scalability – Highly scalable for provisioning compute reousrces from small to large infrastructures.
        - Ease of set up - Creating ARM templates is really easy. You have various templates available from the GitHub community, which you can use or build upon. Alternatively, you can create your own from Azure.
        - Management – Managing ARM templates is very straight-forward as you are managing JavaScript Object Notation (JSON) files.
        - Interoperability - you can use other tools to provision ARM Templates – Azure Cli, Azure Portal, PowerShell and Terraform.
        - Configuration language – JSON
        - Limitation/drawbacks - Certain regions are not supported for certain resources.
        - Scenario - Present a short scenario, in which the best solution is to use resource manager templates.
        - Summary - ARM Templates are ideal for deploying large infrastructure with multiple services along with their dependencies. You use the same template to repeatedly deploy your application during every stage of the application lifecycle. 

    Knowledge check: include two questions at the end of this module that present simple scenarios and ask the student to select the most appropriate native Azure solution.

1. **Choose a third party solution**

    Consider Chef and Terraform against the same criteria as in the previous module:

    - Chef
        - Scalability – Highly scalable for provisioning compute resources from small to large infrastructure.
        - Ease of set up - Master/agent set up. The Chef server runs on the master machine and the Chef clients run as agents on each client machine. Once the Chef extension on the Azure portal is provisioned, VMs are ready to be managed by a Chef server.
        - Ease of management – The management of Chef can be difficult as it uses its own configuration language called Ruby. So, you may need a programmer to manage the configuration.
        - Interoperability - Chef server only works under Linux/Unix, but the Chef client can be on Windows.
        - Configuration language – Ruby
        - Limitation/drawbacks - Templating language can be hard to learn, especially for those not already familiar with the Ruby programming language. Other platforms have better pre-configured deployment scripts.
        - Scenario - Present a short scenario, in which the best solution is to use Chef.
        - Summary - Chef provides a powerful DevOps automation platform that transforms VM infrastructure on Azure into code. Chef automates how infrastructure is configured, deployed, and managed across your network, no matter its size.

    - Terraform
        - Scalability – Highly scalable for provisioning compute resources from small to large infrastructure.
        - Ease of set up - To install Terraform, download the appropriate package for your operating system.
        - Management - Terraform is very easy to manage.
        - Interoperability - Supports Amazon Web Services, Microsoft Azure, and Google cloud platform.
        - Configuration language – Terraform uses Hashicorp Configuration Language (HCL). Alternately you can also use JSON (JavaScript Object Notation).
        - Limitation/Drawbacks - Resources in Terraform are created by Hashicorp, so there is potential for a delay between Azure resources being released by Microsoft and them being available to create in Terraform. Terraform uses the state files to monitor the IAAS and only deploy things that have changed. However, there are some downsides too. Firstly, you have an extra file that is critical to your deployments that you need to manage and keep safe. If you lose your state file or it gets overwritten, you are really in a lot of trouble. You can use the “Terraform Refresh” command to refresh your state file against the existing infrastructure, which can fix accidental changes, but you can’t get a whole new state file with this approach. The metadata that Terraform records in the state file is stored nowhere else but in the state file. You can work with this by storing your state file in a central location that is backed up. Additionally, state is tied to your environment, so each time you want to deploy another instance of your infrastructure you are going to need to manage another state file.
        - Scenario - Present a short scenario, in which the best solution is to use Terrform.
        - Summary - Terraform allows you to plan the infrastructure as code, and gives you a preview of what the code will create. You can have that code peer-reviewed, so it helps to minimize errors in configuration. Terraform provides an easy way to define, preview, and deploy cloud infrastructure.

        Knowledge check: include two questions at the end of this module that present simple scenarios and ask the student to select from Chef, Terrform, or a native Azure solution.

1. **Exercise - Analyse a scenario and map it to a technology option**

   Your business grows, and the demand rises in Europe and Asia. Most of your infrastructure is cloud based. Users are reporting a slow website. Your company is based in USA. To provide the customers in Europe and Asia a better service, your company has decided to replicate the infrastructure.

   Which provisioning tool will allow you to replicate your current infrastructure and redeploy into Europe and Asia after tweaking the relevant parameters (Location, Resource groups and subscription)?

   ARM Templates are ideal for deploying large infrastructure. ARM templates enable you to download your USA datacentre cpnfiguration as a JSON file, tweak the necessary parameters, and deploy the same infrastructure for Europe and Asia customers in a few minutes.

     1. Create the virtual network
     1. Add subnets (frontend & backend)
     1. Create the first VM and assign to frontend
     1. Create the 2nd VM and assign to backend
     1. Export the config File (JSON) with the Azure portal
     1. Edit the config File (JSON) and change the resource group, subnet ID, and location
     1. Import the file into Azure with the Azure portal
     1. Deploy the network from the ARM template

   **Knowledge check**

    I'm removing this as a standalone unit, but leaving the question notes here for use in the other units if needed. We don't need a KC at the end of this unit since it's an exercise.

    - What can be used to deploy an entire 3 tier infrastructure into Azure?
    - What Azure features can you use to create event driven tasks?
    - What can you do to automate post deployment tasks?

1. **Summary**

    In this module we looked at the VM extensions (custom script and DSC extensions) and their purposes. We learned how they can help us automate manual processes and post deployment tasks. The primary goal for automation is to be able to deploy and operate infrastructure and services in Azure. We identified the tools available to do automation.

## Notes

State configuration - https://docs.microsoft.com/azure/automation/automation-dsc-overview

Terraform - https://docs.microsoft.com/azure/terraform/

Chef - https://docs.microsoft.com/azure/virtual-machines/extensions/chef
