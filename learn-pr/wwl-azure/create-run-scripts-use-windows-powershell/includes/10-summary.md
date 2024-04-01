In this module, you learned to create, modify, review, and run  PowerShell scripts. Additionally, you learned to set execution policy to the scripts and add a digital signature to them. The following are the key takeaways:

- Use scripts to standardize repetitive tasks. Standardizing a task reduces the risk of errors. If a script has been tested, you can run it multiple times without errors. 

- Reporting is one complex and repetitive task that you can do with Windows PowerShell. You can use Windows PowerShell to create text or HTML-based reports. 

- Windows PowerShell scripts have a .ps1 file extension. The most basic scripts are simply Windows PowerShell commands listed in a text file that's been saved with the .ps1 file extension.

- Microsoft provides an organized set of scripts and modules in the PowerShell Gallery. The PowerShell Gallery contains content published by Microsoft and PowerShell Gallery members. You can use modules from the PowerShell Gallery to simplify building your scripts.

- The **PowerShellGet** module includes cmdlets for accessing and publishing items in the PowerShell Gallery. 

- The PowerShell Gallery requires the use of Transport Layer Security (TLS) 1.2 to help secure communication. 

- You can implement a private PowerShell gallery for your organization by creating your own NuGet feed. You can create a NuGet feed with a file share or a web-based application. When you have a private PowerShell gallery, you must register the NuGet feed by using the **Register-PSRepository** cmdlet and specifying the source location. After the repository is registered, users can search it, just like the PowerShell Gallery.

- To run an executable file at a command prompt, enter its name to run it in the current directory.

- To control whether Windows PowerShell scripts can be run on Windows computers, set the execution policy on the computer. The options of the execution policy are **Restricted**, **AllSigned**, **RemoteSigned**, **Unrestricted**, and **Bypass**.

- To set the execution policy on a computer, use the **Set-ExecutionPolicy** cmdlet. 

- An alternative for controlling the use of Windows PowerShell scripts is AppLocker. With AppLocker, you can set various restrictions that limit the running of specific scripts or scripts in specific locations.

- ConstrainedLanguage mode allows all core Windows PowerShell functionality, such as scripting constructs. It also allows modules included in Windows to be loaded. However, it does limit access to running arbitrary code and accessing Microsoft .NET objects.

- To add a digital signature to a script, use the **Set-AuthenticodeSignature** cmdlet.


## Additional reading

To learn more, go through the following documents:

- [About Assignment Operators](https://aka.ms/lewact)

- [Hosting your own NuGet Feeds](https://aka.ms/vm0ys1)
