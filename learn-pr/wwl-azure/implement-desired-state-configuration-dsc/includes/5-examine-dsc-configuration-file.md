**DSC configurations** are **Windows PowerShell** scripts that define a special type of function. You can view some syntax examples and scenarios on the [Configuration syntax](/powershell/scripting/dsc/configurations/configurations) page.

## DSC configuration elements

Let's examine the elements within **DSC configurations**. We'll start with the following example configuration:

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

### Configuration block

The **Configuration** block is the outermost script block. In this case, the name of the configuration is **LabConfig**. Notice the curly brackets to define the block.

### Node block

There can be one or more **Node** blocks. The **Node** block defines the nodes (computers and VMs) that you're configuring. In this example, the node targets a computer called **WebServer**. You could also call it **localhost** and use it locally on any server.

### Resource blocks

There can be one or more **resource blocks**. The **resource block** is where the configuration sets the properties for the resources. In this case, there's one resource block called **WindowsFeature**. Notice the parameters that are defined. You can read more about resource blocks at [DSC resources](/powershell/scripting/dsc/resources/resources).

## Advanced DSC configuration example

Here's another example with parameters and multiple resource blocks:

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

In this example, you specify the node's name by passing it as the **ComputerName** parameter when you compile the configuration. The name defaults to **localhost**.

## Creating DSC configurations

Within a **Configuration** block, you can do almost anything that you normally could in a **PowerShell** function. This includes:

- **Variables:** Use variables to store values and make configurations more dynamic.
- **Parameters:** Pass parameters to configurations to make them reusable across different environments.
- **Conditional logic:** Use if/else statements to apply configurations based on conditions.
- **Loops:** Use loops to apply configurations to multiple resources.

You can create the configuration in any editor, such as **PowerShell ISE**, and save the file as a **PowerShell** script with a **.ps1** file type extension.
