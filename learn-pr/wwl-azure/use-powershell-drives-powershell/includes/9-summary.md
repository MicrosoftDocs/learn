In this module, you learned how to work with PowerShell drives that are the primary interface for working with the underlying data. The following are the key takeaways:
- A PowerShell drive, or drive, is a connection to a data store. Each PowerShell drive uses a single PowerShell provider to connect to a data store. The PowerShell drive has all the capabilities of the PowerShell provider that it uses to make the connection.
- To create a new connection, use the New-PSDrive cmdlet.
- To review a list of drives, use the Get-PSDrive cmdlet.
- PowerShell drives contain items that contain child items or item properties. The Windows PowerShell cmdlet names that work with PowerShell drive objects use the nouns Item, ChildItem, and ItemProperty.
- In Windows PowerShell, the common cmd.exe commands such as **Dir**, **Move**, **Ren**, **RmDir**, **Del**, **Copy**, **MkDir**, and **Cd** are provided as aliases or functions that map to equivalent PowerShell drive cmdlets.
- To create PowerShell drives for any part of the registry, use the New-PSDrive cmdlet.
- The Windows PowerShell Certificates provider also allows you to review and manage security certificates. The Certificates provider creates a PowerShell drive named Cert. 
- Other PowerShell drives include Alias, Env, Function, Variable, and WSMan.

## Additional reading

To learn more, go through the following document:

[Push-Location](https://aka.ms/idat4p)
