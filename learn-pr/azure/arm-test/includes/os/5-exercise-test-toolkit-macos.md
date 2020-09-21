1. **Install PowerShell Core**. Follow the instructions in this [link](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-macos)

1. **Install `coreutils`**. You also need to download a library called `coreutils`. It can be fetched via `brew` with the following command typed in the terminal:

   ```bash
   brew install coreutils
   ```

1. Verify installation. Type the following command in the terminal:

   ```bash
   pwsh
   ```

   You should see an output similar to the below:

   ```output
   PowerShell 7.0.3
   Copyright (c) Microsoft Corporation. All rights reserved.

   https://aka.ms/powershell
   Type 'help' to get help.
   ```

### Download the Test toolkit

The test toolkit is located in a GitHub repo. You can either download the repository as a zip file or clone it using Git. Choose one of two actions below:

   - **Clone the repo**. Run the following command in a terminal:

      ```bash
      git clone https://github.com/Azure/arm-ttk.git
      ```

   - **Download the repo as a zip file**. In your browser, navigate to the following URL https://github.com/Azure/arm-ttk/archive/master.zip.  

### Inspect the Test toolkit

You've just downloaded the test toolkit to a directory of your choosing. Let's have a look at your directory structure (ensure you have unzipped the file if you have opted to download the zip instead of running the `git clone command`). You should have a directory structure looking like so:

```output
-| arm-ttk/
-| unit-tests/
-| CODE_OF_CONDUCT.md
-| LICENCE.md
-| README.md
-| SECURITY.md
```

The test tool is located in the sub directory `/arm-ttk`.

### Create the template file

Select a directory of your choosing and create a file called **azuredeploy.json**.

> [!WARNING]
> Ensure the selected directory is an empty one with no sub directories

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

Make a note of the location of your template file. You could run the command `pwd` in the terminal to output the path. You will use this path later as an argument to when running the test toolkit.

## Detect and fix issues on your template by running the Test toolkit

It's recommended that you have two different terminal windows open for this exercise.

- **The first terminal window**. One terminal should be at the sub directory `arm-ttk` of the installation directory. This is where you will be running the Test toolkit from.
- **The second terminal window**. The other terminal should point to the path of the template file `azuredeploy.json`. It's recommended that you start an instance of Visual Studio Code from this path so you can easily edit the `azuredeploy.json` file when asked.

You will run the Test toolkit on a path containing a deployment template and fix any errors it detects by changing the template.

> [!WARNING]
> In this exercise, you scan one template file. The Test Toolkit scans all files beneath the directory you specify. It does so because a deployment can be made up of several files. Be sure that there are no JSON files beneath the directory where *azuredeploy.json* is located.

1. **Start the shell**. Navigate to the sub directory *arm-ttk/*, of the Test toolkit installation directory, Type the following command in the terminal to start a PowerShell shell:

   ```bash
   pwsh
   ```

   You should see an output looking similar to the below:

   ```output
   PowerShell 7.0.3
   Copyright (c) Microsoft Corporation. All rights reserved.

   https://aka.ms/powershell
   Type 'help' to get help.
   ```

1. **Analyze template**.

   1. **Import the arm-ttk module**. Type the following command in the terminal that points to the install directory and the sub directory **arm-ttk**:

      ```powershell
      Import-Module ./arm-ttk.psd1
      ```
  
   1. **Run the tool**. Before running the below command, replace `path/to/template/directory` with the path to the directory of your `azuredeploy.json` file. Run the tool by typing the following command:

      ```powershell
      Test-AzTemplate -TemplatePath path/to/template/directory
      ```

       You should see an output similar to the following in the terminal:

      ```output
       Validating deploy\azuredeploy.json                                                        deploymentTemplate
       [+] adminUsername Should Not Be A Literal (4 ms)
       [+] apiVersions Should Be Recent (2 ms)
       [+] artifacts parameter (1 ms)
       [+] DependsOn Best Practices (2 ms)
       [+] Deployment Resources Must Not Be Debug (2 ms)
       [+] DeploymentTemplate Must Not Contain Hardcoded Uri (1 ms)
       [+] DeploymentTemplate Schema Is Correct (1 ms)
       [+] Dynamic Variable References Should Not Use Concat (1 ms)
       [+] IDs Should Be Derived From ResourceIDs (3 ms)
       [+] Location Should Not Be Hardcoded (1 ms)
       [+] ManagedIdentityExtension must not be used (2 ms)
       [+] Min And Max Value Are Numbers (1 ms)
       [+] Outputs Must Not Contain Secrets (4 ms)
       [-] Parameters Must Be Referenced (2 ms) Unreferenced parameter: location
       [+] Parameters Property Must Exist (1 ms)
       [+] providers apiVersions Is Not Permitted (1 ms)
       [+] ResourceIds should not contain (1 ms)
       [-] Resources Should Have Location (8 ms) Resource  Location must be an expression or 'global'                                                               [+] Secure String Parameters Cannot Have Default (1 ms)
       [+] Template Should Not Contain Blanks (1 ms)
       [+] Variables Must Be Referenced (1 ms)
       [+] Virtual Machines Should Not Be Preview (3 ms)
       [+] VM Images Should Use Latest Version (1 ms)
       [+] VM Size Should Be A Parameter (3 ms)
      ```

   1. **Analyze results**. Note above how two tests are failing,  **Resources Should have Location is failing** and  **Parameters Must Be Referenced**. A failing test is indicated by the prefix **[-]**.

      To understand what's going on, open the **azuredeploy.json** file, it should look like so:

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

         - **The location parameter isn't used**. This error message might, for example, indicate that we have used it in the past and forgot to clean it up. Or that it should be used but we forgot to update our code.
         - **The location property is set to the hardcoded string westus**. Using this option is not considered a good practice as you want to be able to control the location of a resource with input parameters when you are deploying.

1. **Apply fix to template**. So how to fix the above failing tests?

   As the test indicates, we could try replacing **westus** with the text **global**. However, that would only fix one of the problems. Most likely we want to use the **location** parameter and set the resources location to that value. The reason is two-fold, not only can the location parameter be set as an argument when deploying, it also has reasonable fallback of being set to the **resourceGroup().location** as *defaultValue* should you omit to set the **location** when running the deployment.

   1. **Change the template**. Locate the first resource item in the **resources** array and replace the following content:

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

1. **Verify the fix**. Before running the below command, replace `path/to/template/directory` with the path to the directory of your `azuredeploy.json` file. Run the test tool once again with the following command:

   ```powershell
   Test-AzTemplate -TemplatePath path/to/template/directory
   ```

   You now get an output where all tests pass:

   ```output
   Validating deploy\azuredeploy.json                                                        deploymentTemplate
   [+] adminUsername Should Not Be A Literal (6 ms)
   [+] apiVersions Should Be Recent (2 ms)
   [+] artifacts parameter (1 ms)
   [+] DependsOn Best Practices (1 ms)
   [+] Deployment Resources Must Not Be Debug (1 ms)
   [+] DeploymentTemplate Must Not Contain Hardcoded Uri (1 ms)
   [+] DeploymentTemplate Schema Is Correct (1 ms)
   [+] Dynamic Variable References Should Not Use Concat (1 ms)
   [+] IDs Should Be Derived From ResourceIDs (4 ms)
   [+] Location Should Not Be Hardcoded (1 ms)
   [+] ManagedIdentityExtension must not be used (1 ms)
   [+] Min And Max Value Are Numbers (1 ms)
   [+] Outputs Must Not Contain Secrets (1 ms)
   [+] Parameters Must Be Referenced (1 ms)
   [+] Parameters Property Must Exist (1 ms)
   [+] providers apiVersions Is Not Permitted (1 ms)
   [+] ResourceIds should not contain (1 ms)
   [+] Resources Should Have Location (1 ms)
   [+] Secure String Parameters Cannot Have Default (1 ms)
   [+] Template Should Not Contain Blanks (1 ms)
   [+] Variables Must Be Referenced (1 ms)
   [+] Virtual Machines Should Not Be Preview (4 ms)
   [+] VM Images Should Use Latest Version (1 ms)
   [+] VM Size Should Be A Parameter (4 ms)
   ```

Success, you've managed to run the test tool, locate, and fix errors.
