1. Follow the instructions in [Installing PowerShell on Windows](/powershell/scripting/install/installing-powershell-core-on-windows?azure-portal=true).
1. From Visual Studio Code, [install the PowerShell extension](https://code.visualstudio.com/docs/languages/powershell?azure-portal=true).  

### Download the test toolkit

The test toolkit is located in a GitHub repo. Choose one of the following actions:

- Run `git clone` to clone the repo:

   ```bash
   git clone https://github.com/Azure/arm-ttk.git
   ```

- From your browser, [download the repository as a .zip file](https://github.com/Azure/arm-ttk/archive/master.zip).

### Inspect the test toolkit

You've just downloaded the test toolkit to a directory of your choosing. Let's look at your directory structure. (Ensure that you've unzipped the file if you opted to download the .zip file instead of running the `git clone` command.) You should have a directory structure that looks like the following one if you go to the directory of the ARM test toolkit:

```output
-| arm-ttk\
-| unit-tests\
-| CODE_OF_CONDUCT.md
-| LICENCE.md
-| README.md
-| SECURITY.md
```

The test toolkit is in the subdirectory *\arm-ttk*.

### Create the template file

Create a file called *azuredeploy.json* in a directory of your choosing, such as *C:\Temp*.

> [!WARNING]
> Ensure that the selected directory is empty with no subdirectories.

Give it the following content:

```json
{
   "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
   "contentVersion": "1.0.0.0",
   "parameters": {
      "location": {
         "type": "string",
         "defaultValue": "[resourceGroup().location]",
         "metadata": {
            "description": "Location for the resources."
         }
      }
   },
   "resources": [{
      "location": "westus"
   }]
}
```

Note the location of your template file. You'll use this directory path (for example, *C:\Temp*) later as a parameter when running the test toolkit.

## Detect and fix issues on your template by running the test toolkit

We recommend that you start Visual Studio Code and an integrated terminal.

You'll run the test toolkit on a path that contains a deployment template and fix any errors that it detects by changing the template.

> [!WARNING]
> In this exercise, you scan one template file. The test toolkit scans all files beneath the directory that you specify. It does so because a deployment can contain several files. Be sure that there are no JSON files beneath the directory where *azuredeploy.json* is located.

1. In a terminal, go to the path where your *azuredeploy.json* file resides. Run the following command to start Visual Studio Code:

   ```bash
   code .
   ```

   > [!NOTE]
   > Open Visual Studio Code manually and open the template directory if Visual Studio Code isn't on the path.

1. From Visual Studio Code, bring up the command palette and select the command **PowerShell: Show Integrated Console**.

## Analyze the template

1. Run `Import-Module` in the PowerShell terminal:

   > [!NOTE]
   > Before you import the module, replace *path\to\arm-ttk\arm-ttk.psd1* with the path to the downloaded test toolkit.

   ```powershell
   Import-Module path\to\arm-ttk\arm-ttk.psd1
   ```

   The preceding command will point out the position of the test toolkit module.

   > [!TIP]
   > If you downloaded or cloned the tool to your *Downloads* directory, the path would look something like this: *C:\\Users\\<user\>\\Downloads\\arm-ttk\\arm-ttk\\arm-ttk.psd1*.  

   You're now ready to use the tool. As long as you're in the same PowerShell session, there's no need to run the import command again.

   > [!NOTE]
   > If you start a new PowerShell session, you'll need to run the `Import-Module` command again.
  
1. Run `Test-AzTemplate` in the PowerShell terminal, to start a test run:

   ```powershell
   Test-AzTemplate -TemplatePath .
   ```

   You see an output similar to the following in the terminal:

   ```output
   Validating deploy\azuredeploy.json
     JSONFiles Should Be Valid
       [+] JSONFiles Should Be Valid (16 ms)
   Fail  : 0
   Total : 1
   Pass  : 1



     adminUsername Should Not Be A Literal
       [+] adminUsername Should Not Be A Literal (6 ms)
     apiVersions Should Be Recent In Reference Functions
       [+] apiVersions Should Be Recent In Reference Functions (10 ms)
     apiVersions Should Be Recent
       [+] apiVersions Should Be Recent (7 ms)
     artifacts parameter
       [+] artifacts parameter (5 ms)
     CommandToExecute Must Use ProtectedSettings For Secrets
       [+] CommandToExecute Must Use ProtectedSettings For Secrets (7 ms)
     DependsOn Best Practices
       [+] DependsOn Best Practices (6 ms)
     Deployment Resources Must Not Be Debug
       [+] Deployment Resources Must Not Be Debug (5 ms)
     DeploymentTemplate Must Not Contain Hardcoded Uri
       [+] DeploymentTemplate Must Not Contain Hardcoded Uri (5 ms)
     DeploymentTemplate Schema Is Correct
       [+] DeploymentTemplate Schema Is Correct (4 ms)
     Dynamic Variable References Should Not Use Concat
       [+] Dynamic Variable References Should Not Use Concat (4 ms)
     IDs Should Be Derived From ResourceIDs
       [+] IDs Should Be Derived From ResourceIDs (6 ms)
     deploymentTemplate
       [-] Location Should Not Be Hardcoded (13 ms)
           Location value of 'westus' on resource '' must be an expression or 'global'. Line: 14, Column: 9    

     ManagedIdentityExtension must not be used
       [+] ManagedIdentityExtension must not be used (5 ms)
     Min And Max Value Are Numbers
       [+] Min And Max Value Are Numbers (5 ms)
     Outputs Must Not Contain Secrets
       [+] Outputs Must Not Contain Secrets (5 ms)
     Parameter Types Should Be Consistent
       [+] Parameter Types Should Be Consistent (9 ms)
     deploymentTemplate
       [-] Parameters Must Be Referenced (6 ms)
           Unreferenced parameter: location Line: 5, Column: 9

     Password params must be secure
       [+] Password params must be secure (11 ms)
     providers apiVersions Is Not Permitted
       [+] providers apiVersions Is Not Permitted (5 ms)
     ResourceIds should not contain
       [+] ResourceIds should not contain (5 ms)
     deploymentTemplate
       [-] Resources Should Have Location (5 ms)
           Resource  Location must be an expression or 'global'

     Resources Should Not Be Ambiguous
       [+] Resources Should Not Be Ambiguous (7 ms)
     Secure Params In Nested Deployments
       [+] Secure Params In Nested Deployments (10 ms)
     Secure String Parameters Cannot Have Default
       [+] Secure String Parameters Cannot Have Default (7 ms)
     Template Should Not Contain Blanks
       [+] Template Should Not Contain Blanks (5 ms)
     URIs Should Be Properly Constructed
       [+] URIs Should Be Properly Constructed (8 ms)
     Variables Must Be Referenced
       [+] Variables Must Be Referenced (5 ms)
     Virtual Machines Should Not Be Preview
       [+] Virtual Machines Should Not Be Preview (8 ms)
     VM Images Should Use Latest Version
       [+] VM Images Should Use Latest Version (5 ms)
     VM Size Should Be A Parameter
       [+] VM Size Should Be A Parameter (5 ms)
   Fail  : 3
   Total : 31
   Pass  : 28
   ```

   The preceding output shows how three tests are failing: **Location Should Not Be Hardcoded**, **Parameters Must Be Referenced**, and **Resources Should Have Location**. The prefix `[-]` indicates a failing test.

   To understand what's going on, open the *azuredeploy.json* file. It should look like this:

   ```json
   {
      "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
         "location": {
            "type": "string",
            "defaultValue": "[resourceGroup().location]",
            "metadata": {
               "description": "Location for the resources."
            }
         }
      },
      "resources": [{
         "location": "westus"
      }]
   }
   ```

   The tests are failing for two reasons:

   - **The location parameter isn't used**. This error message might, for example, indicate that we used the parameter in the past and forgot to clean it up. Or maybe it should be used but we forgot to update our code.
   - **The location property is set to the hardcoded string westus**. Using this option is not considered a good practice because you want to be able to control the location of a resource with input parameters when you're deploying.

## Apply a fix to the template

How do we fix the failing tests?

As the test indicates, we could try replacing **westus** with the text **global**. However, that would fix only one of the problems. Most likely, we want to use the **location** parameter and set the resource's location to that value. 

The reason is twofold. Not only can the location parameter be set as a parameter for deployment, it also has the reasonable fallback of being set to **resourceGroup().location** as **defaultValue** if you omit setting the **location** parameter when running the deployment.

1. Locate the first resource item in the **resources** array and replace the following content:

   ```json
   "resources": [{
      "location": "westus"
   }]
   ```

   with this content:

   ```json
   "resources": [{
      "location": "[parameters('location')]"
   }]
   ```

1. Run `Test-AzTemplate` to run the test tool once again:

   ```powershell
   Test-AzTemplate -TemplatePath .
   ```

   You now get an output where all tests pass:

   ```output
   Validating deploy\azuredeploy.json
     JSONFiles Should Be Valid
       [+] JSONFiles Should Be Valid (83 ms)
   Fail  : 0
   Total : 1
   Pass  : 1



     adminUsername Should Not Be A Literal
       [+] adminUsername Should Not Be A Literal (36 ms)
     apiVersions Should Be Recent In Reference Functions
       [+] apiVersions Should Be Recent In Reference Functions (57 ms)
     piVersions Should Be Recent
       [+] apiVersions Should Be Recent (67 ms)
     artifacts parameter
       [+] artifacts parameter (19 ms)
     CommandToExecute Must Use ProtectedSettings For Secrets
       [+] CommandToExecute Must Use ProtectedSettings For Secrets (93 ms)
     DependsOn Best Practices
       [+] DependsOn Best Practices (52 ms)
     Deployment Resources Must Not Be Debug
       [+] Deployment Resources Must Not Be Debug (77 ms)
     DeploymentTemplate Must Not Contain Hardcoded Uri
       [+] DeploymentTemplate Must Not Contain Hardcoded Uri (18 ms)
     DeploymentTemplate Schema Is Correct
       [+] DeploymentTemplate Schema Is Correct (73 ms)
     Dynamic Variable References Should Not Use Concat
       [+] Dynamic Variable References Should Not Use Concat (72 ms)
     IDs Should Be Derived From ResourceIDs
       [+] IDs Should Be Derived From ResourceIDs (15 ms)
     Location Should Not Be Hardcoded
       [+] Location Should Not Be Hardcoded (24 ms)
     ManagedIdentityExtension must not be used
       [+] ManagedIdentityExtension must not be used (143 ms)
     Min And Max Value Are Numbers
       [+] Min And Max Value Are Numbers (23 ms)
     Outputs Must Not Contain Secrets
       [+] Outputs Must Not Contain Secrets (160 ms)
     Parameter Types Should Be Consistent
       [+] Parameter Types Should Be Consistent (13 ms)
     Parameters Must Be Referenced
       [+] Parameters Must Be Referenced (13 ms)
     Password params must be secure
       [+] Password params must be secure (12 ms)
     providers apiVersions Is Not Permitted
       [+] providers apiVersions Is Not Permitted (79 ms)
     ResourceIds should not contain
       [+] ResourceIds should not contain (12 ms)
     Resources Should Have Location
       [+] Resources Should Have Location (17 ms)
     Resources Should Not Be Ambiguous
       [+] Resources Should Not Be Ambiguous (17 ms)
     Secure Params In Nested Deployments
       [+] Secure Params In Nested Deployments (17 ms)
     Secure String Parameters Cannot Have Default
       [+] Secure String Parameters Cannot Have Default (16 ms)
     Template Should Not Contain Blanks
       [+] Template Should Not Contain Blanks (83 ms)
     URIs Should Be Properly Constructed
       [+] URIs Should Be Properly Constructed (108 ms)
     Variables Must Be Referenced
       [+] Variables Must Be Referenced (111 ms)
     Virtual Machines Should Not Be Preview
       [+] Virtual Machines Should Not Be Preview (16 ms)
     VM Images Should Use Latest Version
       [+] VM Images Should Use Latest Version (22 ms)
     VM Size Should Be A Parameter
       [+] VM Size Should Be A Parameter (133 ms)
   Fail  : 0
   Total : 31
   Pass  : 31   
   ```

Success! You've run the test tool, located errors, and fixed them.