Desired State Configuration (DSC) is a management platform in Windows PowerShell. DSC enables deploying and managing configuration data for software services and managing the environment in which these services run. DSC provides a set of Windows PowerShell language extensions, Windows PowerShell cmdlets, and resources that you can use to declaratively specify how you want your software environment to be configured. DSC also provides a means to maintain and manage existing configurations.

DSC centers around creating *configurations*. A configuration is an easy-to-read script that describes an environment made up of computers (nodes) with specific characteristics. These characteristics can be as simple as ensuring a specific Windows feature is enabled or as complex as deploying SharePoint. Use DSC when the CSE will not work for your application.

In this example, we are installing IIS on the localhost. The configuration is saved as a PS1 file.

```PowerShell
configuration IISInstall
{
Node “localhost”
{
WindowsFeature IIS
{
Ensure = “Present”
Name = “Web-Server”
} } }

```

The DSC script consists of a Configuration block, Node block, and one or more resource blocks.

 -  The **Configuration** block. This is the outermost script block. You define it by using the **Configuration** keyword and providing a name. In the example, the name of the configuration is *IISInstall*.
 -  One or more **Node** blocks. Node blocks define the computers or VMs that you are configuring. In the example, there is one Node block that targets a computer named "localhost".
 -  One or more resource blocks. Resource blocks configure the resource properties. In the example, there is one resource block that uses **WindowsFeature**. WindowsFeature indicates the name (Web-Server) of the role or feature that you want to ensure is added or removed. Ensure indicates if the role or feature is added. Your choices are Present and Absent.

> [!NOTE]
> The Windows PowerShell DSC comes with a set of built-in configuration resources. For example, File Resource, Log Resource, and User Resource.
