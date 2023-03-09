Desired State Configuration is a management platform in Windows PowerShell. Desired State Configuration enables deploying and managing configuration data for software services and managing the environment in which these services run. The platform also provides a means to maintain and manage existing configurations.

### Things to know about creating your Desired State Configuration

Review the following details about how to create a Desired State Configuration for your virtual machines.

- You can use Desired State Configuration when Custom Script Extensions don't satisfy the application requirements for your virtual machine.

- Desired State Configuration centers around creating specific _configurations_ by using scripts.

- A configuration is an easy-to-read script that describes an environment made up of computers (nodes) with specific characteristics. These characteristics can be as simple as ensuring a specific Windows feature is enabled or as complex as deploying SharePoint.
   
- The configuration script consists of a configuration block, node block, and one or more resource blocks.

   - The configuration block is the outermost script block. You define the block with the `Configuration` keyword and providing a name.
   
   - Node blocks define the computers or virtual machines that you're configuring. You define a node with the `Node` keyword and providing a name for the resource.
   
   - Resource blocks configure the resource (computers or virtual machines) properties. You provide the name of the Windows Role or Feature that you want to ensure is added or removed. The `Ensure` keyword is used to indicate if the Role or Feature is added.

- Desired State Configuration provides a set of Windows PowerShell language extensions, Windows PowerShell cmdlets, and resources. You can use these features to declaratively specify how you want your software environment to be configured. 

- The Windows PowerShell Desired State Configuration comes with a set of built-in configuration resources, such as `File Resource`, `Log Resource`, and `User Resource`.

### Things to consider when using Desired State Configuration

Let's look at an example implementation for a Desired State Configuration. The following PowerShell script installs IIS on the localhost and ensures the web server is present. The configuration is saved as a PS1 file.

- The configuration block is named **IISInstall**.

- There's one node block that targets a computer resource named **localhost**.

- There's one resource block that specifies the **Web-Server** Windows Feature for IIS. The `Ensure` value indicates the Windows Feature is **Present**.

```PowerShell
configuration IISInstall
{
   Node "localhost"
   {
      WindowsFeature IIS
      {
         Ensure = "Present"
         Name = "Web-Server"
      }
   }
}
```