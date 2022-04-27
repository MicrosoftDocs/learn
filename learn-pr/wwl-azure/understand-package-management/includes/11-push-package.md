For this exercise, use the full version of [PartsUnlimited](http://microsoft.github.io/PartsUnlimited/).

> [!IMPORTANT]
> Make source code for PartsUnlimited available in your Azure DevOps repo.

---

## Steps to create a NuGet package

1.  Go to Visual Studio and open your PartsUnlimited project.<br>*Here's an ASP.NET MVC application, where security-related parts have been isolated into a separate .NET standard project. Isolating gives you the option to create a package for this code and publish it to a feed. .NET standard has support for creating NuGet packages.*
2.  Build the project PartsUnlimited.Security.
3.  Go to Command prompt, use command `dir bin\debug.`*Here you see the .nupkg file for PartsUnlimited.Security*
4.  Open your team project in dev.azure.com and go to Artifacts.
    
    1.  Click **Connect to feed.**
    2.  Follow the dialog instructions.
        
         -  Copy the command for "Add this feed" by clicking the **Copy** icon.
    3.  Switch back to your command line.
        
         -  Look at the existing NuGet sources with the command: `NuGet sources`
        
        *You see two NuGet sources available now.*
        
         -  Paste and run the copied instructions.
         -  Look at the existing NuGet sources again with the command: `NuGet sources`
        
        *You see a third NuGet source available.*

---

## Steps to publish the package

1.  Go back to the dialog instructions.
2.  Copy the command for "Push a Package" by clicking the **Copy** icon.
3.  Switch back to your command line and paste the copied instructions. \* Change the folder and name `my_package.nupkg` to `bin\debug\PartsUnlimited.Security1.0.0.nupkg`
    
    ```
    * Run the command.
    
    _We have published the package to the feed, and it is pushed successfully._
    
    ```
4.  Check if the package is available in Azure Artifacts \* Close the dialog instructions.
    
    ```
    * Refresh the Artifacts page
    
    _You see the successfully published package._
    
    ```
