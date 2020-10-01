## Author and run a Custom test

You will author a custom test and use the Test Toolkit tool to run it. Furthermore you will need to correct the deployment template to ensure the test passes. The custom test will be looking to verify that all parameters follow a naming rule. This rule is a domain-specific requirement on the product the team you are working on.

It's recommended that you have two text editors open for this exercise.

- **The first text editor, authoring custom test**. Locate the path of the subdirectory *arm-ttk/testcases/deploymentTemplate/* of the Testing toolkit installation directory. From here you want to run Visual Studio Code where you will be creating and editing a custom test.
- **The second text editor, authoring the template file and run tests**. You select the location of this path to your liking. The only thing you should be wary of is to ensure the path is empty and has no subdirectories. It's recommended that you start an instance of Visual Studio Code from this path so you can easily edit the *azuredeploy.json* file when asked. You also want to start an integrated terminal with this Visual Studio Code instance to make it easy to run tests.

## Create the template file

Select a directory of your choosing and create a file called *azuredeploy.json*.

> [!WARNING]
> Ensure the selected directory is an empty one with no sub directories

Give it the following content:

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {},
  "resources": []
}
```

## Create the custom test

1. **Open up Visual Studio Code**. Open up a terminal. Navigate to your installation directory for the Test Toolkit tool. Place yourself in the subdirectory *arm-ttk/testcases/deploymentTemplate*. Run the following command:

   ```bash
   code .
   ```

   > [!NOTE]
   > Open VS Code manually and open the  directory above if Visual Studio Code isn't on the path.
1. **Create a custom test file**. Create a file *Custom-ParameterNaming.test.ps1* and give the file the following content:

   ```powershell
   param(
   [Parameter(Mandatory=$false,Position=0)] #not mandatory for case of an empty resource array
   [PSObject]
   $MainTemplateResources
   )

   Write-Error "To be implemented"
   ```

   Leave the text editor open, you will edit this file later.

## Run the custom test

Run the custom test by following these steps:

1. Open up a new terminal window or reuse the old one.
1. Navigate to the directory of where you created *azuredeploy.json*. Run the following command to start Visual Studio Code:

   ```bash
   code .
   ``` 

   > [!NOTE]
   > Open VS Code manually and open the template directory if Visual Studio Code isn't on the path

1. From Visual Code, open the integrated terminal by selecting **Terminal > New Terminal** from the top menu. Run the following command in the terminal to start a PowerShell shell:

   ```bash
   pwsh
   ```

   You see an output looking similar to the below:

   ```output
   PowerShell 7.0.3
   Copyright (c) Microsoft Corporation. All rights reserved.

   https://aka.ms/powershell
   Type 'help' to get help.
   ```

1. Run `Import-Module` in the terminal:

   > [!NOTE] 
   > Before importing the module, replace *path/to/arm-ttk/arm-ttk.psd1* with the path to the downloaded Test toolkit.

   ```powershell
   Import-Module path/to/arm-ttk/arm-ttk.psd1
   ```

   > [!TIP]
   > If you downloaded or cloned the tool to your `Downloads` directory the path would look something like this */Users/<user\>/Downloads/arm-ttk/arm-ttk/arm-ttk.psd1*.
    
   You are now ready to use the tool. As long as you are in the same PowerShell session there's no need to run the import command again.

1. Run `Test-AzTemplate` in the terminal, to start a test run:

   ```powershell
   Test-AzTemplate -TemplatePath .
   ```

   Your output resembles this:

   ```output
    Validating deploy\azuredeploy.json                                                        deploymentTemplate
    [+] adminUsername Should Not Be A Literal (16 ms)
    [+] apiVersions Should Be Recent (4 ms)
    [+] artifacts parameter (1 ms)
    [-] Custom ParameterNaming (2 ms)  To be implemented
    [+] DependsOn Best Practices (2 ms)
    [+] Deployment Resources Must Not Be Debug (2 ms)
    [+] DeploymentTemplate Must Not Contain Hardcoded Uri (4 ms)
    [+] DeploymentTemplate Schema Is Correct (1 ms)
    [+] Dynamic Variable References Should Not Use Concat (1 ms)
    [+] IDs Should Be Derived From ResourceIDs (5 ms)
    [+] Location Should Not Be Hardcoded (7 ms)
    [+] ManagedIdentityExtension must not be used (1 ms)
    [+] Min And Max Value Are Numbers (1 ms)
    [+] Outputs Must Not Contain Secrets (2 ms)
    [+] Parameters Must Be Referenced (2 ms)                                                    Unreferenced parameter: location
    [+] Parameters Property Must Exist (1 ms)
    [+] providers apiVersions Is Not Permitted (1 ms)
    [+] ResourceIds should not contain (2 ms)
    [-] Resources Should Have Location (2 ms)                                                   Resource  Location must be an expression or 'global'
    [+] Secure String Parameters Cannot Have Default (1 ms)
    [+] Template Should Not Contain Blanks (2 ms)
    [+] Variables Must Be Referenced (1 ms)
    [+] Virtual Machines Should Not Be Preview (6 ms)
    [+] VM Images Should Use Latest Version (1 ms)
    [+] VM Size Should Be A Parameter (5 ms)
    ```

   In the above output your test is indicated, fourth from the top with this line:

   ```output
   [-] Custom ParameterNaming (4 ms)  To be implemented
   ```

   Great, the test is found. Leave this terminal window open, you will reuse it later.

## Refactor custom test

Now you will give the custom test a proper implementation.

1. Go back to the text editor holding the file *Custom-ParameterNaming.test.ps1*. 

   > [!NOTE]
   > If you accidentally closed Visual Studio Code, navigate to the subdirectory *arm-ttk/testcases/deploymentTemplate* and open up the file *Custom-ParameterNaming.test.ps1*.

1. Replace the file content with the following code:

   ```powershell
   <#
   .Synopsis
    Ensures that all parameters adheres to a naming standard
   .Description
    All parameters should start with the company specific prefix 'tailwind'
   #>
   param(
      # The Template Object
      [Parameter(Mandatory = $true, Position = 0)]
      [PSObject]
      $TemplateObject,

      # The Template JSON Text
      [Parameter(Mandatory = $true, Position = 0)]
      [PSObject]
      $TemplateText
   )

   foreach ($parameter in $TemplateObject.parameters.psobject.properties) {
     # If the parameter name starts with tailwind, then the parameter is correctly named
     if ($parameter.Name -notmatch 'tailwind*') {
        Write-Error "Parameter '$($parameter.Name)' must start with prefix 'tailwind'" -TargetObject $parameter
     }
   }
   ```

   The above code iterates through all the parameters and inspects its name attribute and checks whether the name starts with the prefix **tailwind**. If the inspected parameter does not match the naming rule, the code then invokes the **Write-Error** cmdlet with a suitable error message.

## Update the template file

You will now add a parameter to the template file.

1. Select the text editor containing *azuredeploy.json* and change the file's content to the following content:

   ```json
   {
     "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
     "contentVersion": "1.0.0.0",
     "parameters": {
       "location": {
         "type": "string",
         "metadata": {
           "description": "a deployment location"
         }
       }
     },
     "resources": []
   }
   ```

   The above template content defines a parameter **location** that doesn't fulfill the naming rule, as it lacks the **tailwind** prefix in its naming.

## Rerun the Test toolkit

You have a custom test written at this point. However your template file naming does not fulfill the requirement. You therefore expect the upcoming test-run to fail. Ensure that is the case by taking the below steps:

Use the existing Visual Studio Code integrated terminal window where Powershell has been started and the Test toolkit has been imported.

1. In the same Visual Studio Code instance, run `Test-AzTemplate` from the integrated terminal:

   ```powershell
   Test-AzTemplate -TemplatePath . -Test Custom-ParameterNaming
   ```

   The above command is run with the parameter `-Test`, which takes a test name as input. You've provided **Custom-ParameterNaming** as an argument, which means _only_ your newly developed test will be run.

   > [!TIP]
   > Using `-Test` parameter is a good practice when developing a test as it limits what is being run and the size of the terminal output.

   This command results in the following output:

   ```output
   Validating custom\azuredeploy.json
    deploymentTemplate

    [-] Custom ParameterNaming (2ms) Parameter 'location' must start with prefix 'tailwind'
   ```

   The result above indicates that your test works. Let's ensure that is the case by altering the deployment file.

## Correcting the template file

At this point you want to verify the correctness of your custom test by changing the template file to adhere to the rules laid out by the custom test.

1. In the same Visual Studio Code instance showing the *azuredeploy.json* file, change the file's content to the following content:

   ```json
   {
     "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
     "contentVersion": "1.0.0.0",
     "parameters": {
       "tailwindLocation": {
         "type": "string",
         "metadata": {
           "description": "a deployment location"
         }
       }
     },
     "resources": []
   }
   ```

   Above the parameter **location** has been renamed to **tailwindLocation**. In theory, this parameter should now pass the test. Let's verify.

1. Continue with the same Visual Studio Code instance and run `Test-AzTemplate` in the integrated terminal:

   ```powershell
   Test-AzTemplate -TemplatePath . -Test Custom-ParameterNaming
    ```

   Your output now looks like the following:

   ```output
   Validating custom\azuredeploy.json                                                        deploymentTemplate
   [+] Custom ParameterNaming (2 ms)
   ```

Success, you've managed to implement and run a custom test. Furthermore you've managed to correct a deployment template to match the tests condition.
