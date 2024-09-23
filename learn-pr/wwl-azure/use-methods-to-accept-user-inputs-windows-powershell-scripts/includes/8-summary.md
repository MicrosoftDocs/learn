In this module, you learned about various methods that allow you to accept user input in PowerShell scripts. The following are the key takeaways:

- Use the **Read-Host** cmdlet to obtain input from users while a script is running.

- The **Get-Credential** helps to use the administrative account while you're still signed in to a standard user account.

- To store credentials to a file, use **Export-Clixml**. For a credential object, **Export-Clixml** encrypts the credential object before storing it in an XML file. 

- Microsoft has released the **SecretManagement** module that you can use to store and retrieve credentials. The **SecretManagement** module is available in the PowerShell Gallery. 

- The **Out-GridView** cmdlet is primarily used to review data. However, you can also use **Out-GridView** to create a simple menu selection interface.

- To identify the variables that will store parameter values, you use a **Param()** block. The variable names are defined between the parentheses. 

## Additional reading

To learn more, go through the following documents:

- [About Assignment Operators](https://aka.ms/lewact)

- [Hosting your own NuGet Feeds](https://aka.ms/vm0ys1)

