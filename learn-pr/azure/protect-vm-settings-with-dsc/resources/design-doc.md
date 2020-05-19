# Module design

## Title

Protect your virtual machine settings with Azure Automation State Configuration

## Role(s)

Administrator

## Level

Beginner

## Product(s)

- Azure Automation State Configuration 
- Azure Virtual Machine

## Prerequisites

- Familiarity with Azure virtual machines (VMs)

## Summary

 Create a desired state configuration script that checks that IIS is installed. Onboard VMs for management by Azure Automation. Automatically install IIS on the virtual machine where that feature is missing.

## Learning objectives

- Automatically update virtual machines to match a desired state configuration (DSC)

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| What is Azure Automation State Configuration? | Explains the features available within Azure to achieve the desired state configuration in a declarative method | Knowledge Check | Identify the features and capabilities of Azure Automation | Yes |
| Use PowerShell DSC to achieve a desired state | Maintaining Consistency across Virtual Machines | Knowledge Check | USe PowerShell DSC to control Azure Automation to change and maintain machine state |  Yes |
| Setup a DSC configuration | Setting up Azure Automation State Configuration | Exercise | Use Azure Automation with DSC to set the state of a VM |  Implementing a desired state configuration  |

## Outline the units

### 1. Introduction

You're an administrator for a retail company that uses Azure virtual machines to host the company's website. Your organization recently had an issue with a virtual machine being redeployed without the Windows IIS feature installed. To reduce the time you spend troubleshooting and maintaining configuration consistency across these virtual machines, you decide to setup Azure Automation State Configuration.

### 2. What is Azure Automation State Configuration?

Azure Automation State Configuration enables you to ensure that a cluster of virtual machines intended to perform a set of tasks are in a consistent state, with specified software configured.

In this unit, you'll learn about the features and capabilities of Azure Automation. In particular, you'll be able to explain the declarative model of PowerShell DSC, and it's benefits.

Cover the following points:

- What is Azure Automation State Configuration
  - Democratized highly available engine built on PowerShell Workflow for consistently achieving the desired state.
  - Allows you to write, manage, and compile PowerShell DSC configurations,  import DSC resources and assign configurations to target nodes.  
- What is PowerShell DSC
  - Explain declarative nature vs. PowerShell
  - Explain idempotency
  - Push and pull methodologies
  - Available resources for reuse, for example [Windows IIS Server Configuration on GitHub](https://github.com/Microsoft/WindowsIISServerConfig)
- What challenges does it address
  - Keeping the 1000's of servers running your services configured correctly is increasingly complicated and prone to error
  - Many servers and roles (like WebServer) which require consistent deployments with reusable code
  - Requirement to be able to scale with agility whilst matching it's brothers and sisters
  - Management of the desired state becomes challenging when independent tools or teams can drift the configuration away from the desired state.
  - Achieving a state of continual compliance for security & regulatory obligation
- Supported platforms & Operating Systems
  - Azure Cloud, on-premises, AWS or a Hybrid of all.
  - Operating Systems
    - Windows
      - Server 2019
      - Server 2016
      - Server 2012R2
      - Server 2012
      - Server 2008 R2 SP1
      - 10
      - 8.1
    - Linux
      - All excluding Debian (all) and Ubuntu 18.04
  - Windows hosts install Windows Management Framework (WMF) 5.1, Windows 7 & Windows Server 2012 will install WinRM. Windows Management Instrumentation (WMI) is required, and ships as part of WMF  
  - Linux will install PowerShell DSC and requires Open Management Infrastructure (OMI)
- Cost
  - [Pricing](https://azure.microsoft.com/pricing/details/automation/)

Add three knowledge check questions to verify the student's understanding of the content. Verify that the student understands the purpose of Azure Automation and the problem that it addresses (keeping 100/1000s of machines in the same state)

### 3. Use PowerShell DSC to achieve a desired state

You want to ensure that Microsoft IIS is installed on all your nodes when they are deployed or redeployed. By the end of this unit, you will be able to:

- Understand Node and Configuration blocks
- Understand Credential Assets
- Write PowerShell DSC code to install Microsoft IIS idempotently
- Understand Push/Pull models

Cover the following points:

- Task orientated scripting solution. Declarative syntax that enables people that don't have a level of knowledge of the Azure resource they want to deploy to be able to configure and deploy to configure and maintain the desired state even if from a technical perspective they do not know how to achieve that
- Windows Server has a set of  built-in PowerShell DSC resources
  - Files and Folders
  - Roles and Features
  - Registry Settings
  - Environment Variables
- DSC resource kit for more complex deployment scenarios
  - To configure a non-default resource
  - Import PowerShell module that sets up the resource.
  - Note: The resource must already be part of the VM, possibly as part of a VM image.
- Configuration for each host to ensure each time it is deployed it is in the same consistent way for the entire lifecycle of the machine
- Sample code snippet walk thru highlighting WindowsFeature sections and declarative nature 

``` PowerShell
Configuration MyDscConfiguration {
    Node "TEST-PC1" {
        WindowsFeature MyFeatureInstance {
            Ensure = 'Present'
            Name = 'Web-Server'
        }
      }
}
MyDscConfiguration
```

- Discuss Configuration Blocks. This is the outermost script block. You define it by using the Configuration keyword and providing a name. Within a Configuration block,  you can also perform anything you could in a PowerShell function, for example you could parameterize the node name. e.g
  
  ``` PowerShell
  param
  (
      [string[]]$ComputerName='localhost'
  )

  Node $ComputerName
  ```

  - Discuss Node Block.  These define the nodes (computers or VMs) that you are configuring. In the above configuration, there is one Node block that targets a computer named "TEST-PC1". It can also accept a comma-separated list of computers in an array-notation ```Node @('localhost', 'Server01')```
  - Discuss Credential/Secure Assets in Azure for accessing credentials, certificates, and encrypted variables. Secure Assets are stored in Azure Automation and are encrypted with a unique key that is generated for each automation account.  Discuss that credential assets can be referenced using Get-AutomationPSCredential or passed in via parameters at compilation
- Optional - compare to how it would look in standard PowerShell to highlight simplicity
- Deploying with configuration files, ensuring an identical deployment is maintained each time.
- What is Compilation
  - For a DSC configuration to be applied to a node it must be first compiled into a MOF file
  - A MOF (Managed Object Format) file is a compiled language created by Desktop Management Task Force (DMTF) and is based on Interface Definition Language (IDL). It is the language used to describe Common Information Model classes (CIM). Show an example.  
- Remediating drift.
- Push Model (Start-DscConfiguration)
  - Sends a configuration file to remote device and configuration is deployed by the local configuration manager
- Pull Model, more features but added complexity  
  - Each of the pull clients has a scheduled event that performs a periodic compliance check on the configuration of the node. When the event is triggered the first time, the Local Configuration Manager (LCM) on the pull client makes a request to the pull service to get the configuration specified in the LCM. If that configuration exists on the pull service, and it passes initial validation checks, the configuration is downloaded to the pull client, where it is then executed by the LCM.
  - The LCM checks that the client is in compliance with the configuration at regular intervals specified by the ConfigurationModeFrequencyMins property of the LCM. The LCM checks for updated configurations on the pull service at regular intervals specified by the RefreshModeFrequency property of the LCM. For information about configuring the LCM, see Configuring the Local Configuration Manager.
  - REST-based protocol for retrieval
  - The chosen method for AASC
  - Show some complete examples of configurations (composite, partial, parameterized)

Add three knowledge check questions to verify the student's understanding of the content. Verify that the student understands the role of PowerShell DSC in describing machine state, and how it interacts with Azure Automation.

### 4. Setup a DSC configuration and configure a desired state

To run your Microsoft IIS PowerShell DSC code, you need first to create an Azure Automation Account. By the end of this unit you will be able to:

- Create an Azure Automation Account via the Portal
- Add an existing VM to the Automation Account
- Explain the components  (Config file, compilation, mof, resources, staging, registration, deployment, configuration, reporting)
- Upload the IIS PowerShell DSC to Azure.
  
In this unit, you will create an Azure Automation account, upload a PowerShell DSC configuration, onboard an existing Virtual Machine into Azure Automation and run code to install and configure IIS on that virtual machine if it is currently missing.

Before the exercise starts, run a setup script that creates the VM but without IIS installed. This exercise also requires a DSC script that checks for IIS.

Create an Azure Automation account

1. Log into the Azure portal
2. Create an Azure Automation account, entering the name, subscription, resource group, location, and default option for 'Create Azure Run as Account'

Upload DSC script to the account

1. Review the DSC script (this script specifies IIS as part of the desired state)
2. Click Add Configuration
3. Click Folder icon, locate the DSC script
4. Upload and take reference of name of the configuration

Add VM to the configuration

1. Select State Configuration (DSC) -> Add
2. Select node to add
3. If the machine does not have the PowerShell desired state extension installed and the power state is running, click Connect.
4. Node Configuration Name - select from stage 6
5. Allow Module Override - select
6. Reboot Node if required - select
7. select OK
8. Select Create

Verify VM is registered with Azure Automation extension

1. Go to main Azure automation page and account and refresh from tile on the dashboard
2. Validate DSC nodes set to 1
3. Select Node, ensure node is compliant.

Verify that IIS is installed on the VM

1. Attempt to connect to public IP of machine `http://<public-ip>`

### Unit 5: Summary + Cleanup

How did you solve the problem in the initial scenario with the knowledge learned in the module?

- Explained the purpose of Azure Automation State Configuration.
- Used PowerShell DSC to automatically install and configure missing software.

## Notes

- As this is admin, show steps in the Azure portal where you can.
- Config in GitHub that matches the scenario: https://github.com/Microsoft/WindowsIISServerConfig
- Need to still figure out whether user needs to use their own account or if they can use the sandbox.

## Resources

- [Azure Automation State Configuration Overview](https://docs.microsoft.com/en-us/azure/automation/automation-dsc-overview)
- [Introduction to the Azure Desired State Configuration extension handler](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/dsc-overview)
- [Windows IIS Server Configuration on GitHub](https://github.com/Microsoft/WindowsIISServerConfig)
- [Pricing](https://azure.microsoft.com/en-us/pricing/details/automation/)

### Related modules

- [Keep your VMs updated](https://docs.microsoft.com/en-us/learn/modules/keep-your-virtual-machines-updated/1-introduction) 
- [Design for efficiency and operations in Azure](https://docs.microsoft.com/en-us/learn/modules/design-for-efficiency-and-operations-in-azure/4-use-automation-to-reduce-effort-and-error)
