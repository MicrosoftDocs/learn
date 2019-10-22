You use PowerShell DSC to specify the desired state for a virtual machine (VM). In this unit, you'll learn more about PowerShell DSC and how to use it to control the state of your VMs. In the example scenario, you use PowerShell DSC to make sure that IIS for Windows Server is installed and configured consistently across all of your web servers.

By the end of this unit, you'll:

- Understand node and configuration blocks
- Understand credential assets
- Write PowerShell DSC code to install Microsoft IIS idempotently

## DSC resources

You've seen how PowerShell DSC is a declarative task-oriented scripting language. When you need to configure and deploy an Azure resource in a consistent way across a set of virtual machines, PowerShell DSC can help. You use PowerShell DSC even when you're not familiar with the technical steps involved to install and configure the  software and services.  

Windows Server has a set of built-in PowerShell DSC resources. You can see these resources by running the **Get-DSCResource** PowerShell cmdlet.

```powershell
Get-DscResource | select Name,Module,Properties
```

The following table lists some of the built-in PowerShell DSC resources.

| Resource               | Description                                        |
|------------------------|----------------------------------------------------|
| File                   | Manages files and folders on a node                |
| Archive                | Decompresses an archive in the .zip format         |
| Environment            | Manages system environment variables              |
| Log                    | Writes a message in the DSC event log              |
| Package                | Installs or removes a package                     |
| Registry               | Manages registry key of a node (except HKEY Users) |
| Script                 | Executes PowerShell commands on a node             |
| Service                | Manages Windows Services                           |
| User                   | Manages local users on a node                      |
| WindowsFeature         | Adds or removes a role/feature on a node           |
| WindowsOptionalFeature | Adds or removes an optional role/feature on a node |
| WindowsProcess         | Manages a windows process                          |

For more complex resources, like Active Directory integration, the DSC Resource Kit is updated monthly. You'll find the link to this resource at the end of the module.

The resource to be configured must already be part of the VM or part of the VM image. Otherwise, the job will fail to compile and run.

## Anatomy of a DSC code block

There are four sections of a DSC code block. Use the following example to take a closer look. The numbers refer to sections in the following discussion, and aren't part of the syntax:

```powershell
Configuration MyDscConfiguration {              ##1
    Node "localhost" {                           ##2
        WindowsFeature MyFeatureInstance {      ##3
            Ensure = 'Present'
            Name = 'Web-Server'
        }
    }
}
MyDscConfiguration -OutputPath C:\temp\                             ##4
```

### Configuration syntax

1. *Configuration* - The configuration block is the outermost script block. It starts with the `Configuration` keyword, and you provide a name. Here, the name of the configuration is *MyDscConfiguration*. The configuration block describes the desired configuration. Think of a configuration block like a function, except that it describes the resources to be installed rather than containing the code to install them. Like a PowerShell function, a configuration block can take parameters. For example, you could parameterize the node name.

    ```powershell
    Configuration MyDscConfiguration {
    param
    (
        [string] $ComputerName='localhost'
    )

    Node $ComputerName {
        ...
    }
    ```
  
2. *Node* - You can have one or more node blocks. The node block determines the names of .mof files that are generated when you compile the configuration. For example, the node name *localhost*, generates only one localhost.mof file. But you can send that .mof file to any server. You generate multiple .mof files when you use multiple node names.

    Use the array-notation in the node block to target multiple hosts. For example:

    ```powershell
    Node @('WEBSERVER1', 'WEBSERVER2', 'WEBSERVER3')
    ```

3. *Resource* - You can have one or more Resource blocks that specify the resources to be configured. In this case, there's one resource block, referencing the `WindowsFeature` resource. In this example, the `WindowsFeature` resource is used to ensure the Windows feature `Web-Server` is installed.

4. *MyDscConfiguration* - This call invokes the **MyDscConfiguration** block, much like running a function. When you run a configuration block, it's compiled into a Managed Object Format (MOF) document. MOF is a compiled language created by Desktop Management Task Force, based on Interface Definition Language. A .mof file is created for every node listed in the DSC script. The .mof file is created in the folder you specify with the `-OutputPath` parameter.

## Configuration data in the DSC script

You can provide data that might be required by the configuration process in a configuration data block. You apply this data to named nodes, or globally across all nodes. A configuration data block is a named block that contains an array of nodes. The array must be named **AllNodes**. Inside the **AllNodes** array, you specify the data for a node using the **NodeName** variable. For example, if you want to set the `SiteName` property of the webserver installed on each node in the previous example to different values, you could define a configuration data block like the one shown below:

```powershell
$datablock =
@{
    AllNodes =
    @(
        @{
            NodeName = "WEBSERVER1"
            SiteName = "WEBSERVER1-Site"
        },
        @{
            NodeName = "WEBSERVER2"
            SiteName = "WEBSERVER2-Site"
        },
        @{
            NodeName = "WEBSERVER3"
            SiteName = "WEBSERVER3-Site"
        }
    );
}
```

If you want to set a property to the same value in each node, specify `NodeName = "*"` in the `AllNodes` array.

## Secure credentials in a DSC script

A DSC script might need you to provide credential information to the configuration process. To avoid putting a credential in plaintext in your source code management tool, DSC configurations in Azure Automation can reference credentials stored in a `PSCredential` object. You define a parameter for the DSC script with the `PSCredential` type. Before running the script, obtain the credentials for the user, create a new `PSCredential` object with these credentials, and pass this object in as a parameter to the script.

Credentials aren't encrypted in .mof files by default, they are exposed as plain text. To encrypt credentials, you need to use a certificate in your Configuration data. The private key of the certificate needs to be present on the node on which you intend to apply the configuration. Certificates are configured through the node's Local Configuration Manager (LCM). Starting in PowerShell 5.1 .mof files on the node are encrypted at rest.

All credentials are encrypted in transit through WinRM.

## Push the configuration to node

When you've created a compiled .mof file for a configuration, you can push it to a node by running the  `Start-DscConfiguration` cmdlet. If you add the path to the directory, it applies any .mof file it finds in that directory to the node:

``` powershell
Start-DscConfiguration -path D:\
```

This step corresponds to *push mode*  that's described in the previous unit.

## Pull the configuration for nodes

If you have hundreds of VMs on Azure, then using *pull mode* is more appropriate than the *push mode*. 

You can configure an Azure Automation Account to act as a pull service. Upload the configuration to the Automation Account, then register your VMs with this account. 

Before you compile your configuration, import any PowerShell modules the DSC process needs into your automation account. These modules define how to complete the task to achieve the desired state. For example, a DSC script in the the previous unit used the xSmbShare PowerShell module to tell DSC *how* to check the state for a file share. DSC automatically pulls modules from the automation account to the node.

The following diagram shows how you set up Azure Automation State Configuration. We'll go through these steps in the next unit.

   ![Diagram that shows the steps to set up DSC](../media/3-user-sets-up-dsc.png)

By default, after 15 minutes, the LCM on the VM polls Azure Automation for any changes to the DSC configuration file. Any changes made to the VMs are recorded in the desired state configuration. If you modify a configuration, you can upload it to the Automation Account, and the VMs are reconfigured automatically. 

The following diagram shows the steps LCM takes to manage the desired state on the VM.

   ![Diagram that shows the steps when the VM polls Azure Automation](../media/3-vm-pulls-dsc.png)

Credentials are handled natively by your Automation account. This feature reduces the complexity of securing and working with credentials.


