
One of the other server administrators at Contoso is experienced with Windows PowerShell and suggested you investigate using PowerShell DSC to configure your newly deployed Windows Server computers. You learn that with DSC, you can implement declarative configuration management through a combination of PowerShell scripts and operating system features. You decide to investigate further.

> [!NOTE]
> A declarative programming language separates intent (*what you want to do*) from execution (*how do you want to do it*).

## What is DSC?

DSC is a PowerShell-based management platform that you can use to manage your servers and related IT infrastructure. DSC consists of three components, described in the following table.

|Component|Description|
|--|--|
|Configurations|Declarative PowerShell scripts that configure and define your resources. When the configuration runs, DSC applies the configuration as defined. This ensures that the target resource, in this case, a server, is in the defined state. It is the Local Configuration Manager (LCM) which applies and maintains these configurations.|
|Resources|Contain the code that defines and applies the desired configuration state of the resource.|
|LCM|Is the engine that DSC uses to apply the configurations. Periodically, the LCM verifies the state of the system, and where necessary, calls to the code in resources to reapply the desired state.|

> [!NOTE]
> You don't need to install anything to use DSC; PowerShell DSC is included in Windows.

Windows-based DSC relies extensively on the LCM component. This component serves as the execution engine of the Windows PowerShell DSC scripts.

> [!NOTE]
> LCM is an integral part of all currently supported versions of Windows operating systems.

LCM is responsible for:

- Coordinating the implementation of settings defined in DSC scripts
- Monitoring the ongoing status of those settings
- Updating the state of a computer to match a desired state

Every time the LCM runs, it completes the following steps:

1. **Get**: Retrieves the current state of the computer.
2. **Test**: Compares the current state of the computer against the desired state by using a compiled DSC script ( a .mof file).
3. **Set**: Updates the computer's configuration to match the desired state described in the .mof file.

You can deploy DSC configuration in either push mode or pull mode, as described in the following table.

|Mode|Description|
|--|--|
|Push|In this mode, you manually send, or *push*, the desired configurations toward one or more managed computers. The LCM component makes sure that the state on each managed computer matches what your configuration specifies.|
|Pull|In this mode, a *pull server* holds your configuration information. The LCM component on each managed computer polls the pull server periodically (the default is 15 minutes intervals), to get the latest configuration details. The pull server then sends the details about any configuration changes back to each managed computer.|

> [!TIP]
> Although you can setup a Windows Server as a pull server, you can also use Azure Automation Desired State Configuration.

## Requirements for DSC with Windows

There are a number of requirements that your environment must meet in order to use DSC with Windows. These are:

- Operating system. The managed computers must be running Windows 8.1 or later, or Windows Server 2012 R2 or later.
- Windows Remote Management. Windows Remote Management (WinRM) must be enabled on managed computers.

With DSC, you can define the desired state of:

- An operating system
- An application

## Working with scripts

You can use a script to define your DSC. After you have created and compiled your configuration, you can assign it to computers, which then receive that configuration.

### Create a script

The DSC implementation often starts with creating a configuration script (.ps1) that describes that desired state. The following example is a simple example of a configuration. In this case, the script checks for the presence of Internet Information Service (IIS) and installs it if necessary.

```PowerShell
configuration IISInstall
{
    # Import the required module.
    Import-DscResource -ModuleName PsDesiredStateConfiguration
    node "localhost"
    {
        WindowsFeature IIS
        {
            Ensure = "Present"
            Name = "Web-Server"
        }
    }
}
```

After you create the script, save it. In this case, save it as **IISInstall.ps1**.

### Compile the configuration

After you create a configuration script, you must compile it. Compilation generates one or more .mof files that contain configurations applicable to target nodes. To compile a script, in a PowerShell console, locate the folder where you saved your configuration (script file) and run the following commands to compile the configuration into a MOF file:

```PowerShell
.\IISInstall.ps1
IISIinstall
```

### Apply the configuration

The next step is to apply the configuration. You do this by running the the `Start-DscConfiguration` cmdlet.

> [!IMPORTANT]
> To allow DSC to run, you must configure Windows for PowerShell remoting, even when you're running a localhost configuration.

For example, in a PowerShell console, navigate to the folder where the configuration is saved, and run the following PowerShell command:

```PowerShell
Start-DscConfiguration .\IISInstall
```

> [!TIP]
> You can verify the success of your configuration by running the `Get-DscConfigurationStatus` cmdlet.
