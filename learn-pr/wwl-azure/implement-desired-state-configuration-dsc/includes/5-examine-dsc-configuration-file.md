**DSC configurations** are Windows PowerShell scripts that define a special type of function.

You can view some syntax examples and scenarios on the [Configuration syntax](/powershell/scripting/dsc/configurations/configurations) page.

## DSC configuration elements

We'll provide the example configurations and then discuss the elements within them. Let's start with the following example configuration:

```powershell
    configuration LabConfig
    {
        Node WebServer
        {
            WindowsFeature IIS
            {
                Ensure = 'Present'
                Name = 'Web-Server'
                IncludeAllSubFeature = $true
            }
        }
    }

```

 -  **Configuration block**. The **Configuration** block is the outermost script block. In this case, the name of the configuration is **LabConfig**. Notice the curly brackets to define the block.
 -  **Node block**. There can be one or more **Node** blocks. It defines the nodes (computers and VMs) that you're configuring. In this example, the node targets a computer called **WebServer**. You could also call it **localhost** and use it locally on any server.
 -  **Resource blocks**. There can be one or more resource blocks. It's where the configuration sets the properties for the resources. In this case, there's one resource block called **WindowsFeature**. Notice the parameters that are defined. (You can read more about resource blocks at [DSC resources](/powershell/scripting/dsc/resources/resources).

Here's another example:

```powershell
    Configuration MyDscConfiguration
    {
        param
        (
            [string[]]$ComputerName='localhost'
        )
   
        Node $ComputerName
        {
            WindowsFeature MyFeatureInstance
            {
                Ensure = 'Present'
                Name = 'RSAT'
            }
   
            WindowsFeature My2ndFeatureInstance
            {
                Ensure = 'Present'
                Name = 'Bitlocker'
            }
        }
    }
   
    MyDscConfiguration

```

In this example, you specify the node's name by passing it as the *ComputerName* parameter when you compile the configuration. The name defaults to "*localhost*."

Within a Configuration block, you can do almost anything that you normally could in a PowerShell function.

You can also create the configuration in any editor, such as PowerShell ISE, and save the file as a PowerShell script with a .ps1 file type extension.
