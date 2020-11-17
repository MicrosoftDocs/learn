## Author and run a custom test

You'll author a custom test and use the test toolkit tool to run it. You'll also correct the deployment template to ensure that the test passes. The custom test will look to verify that all parameters follow a naming rule. This rule is a domain-specific requirement on the product the team where you're working.

We recommend that you have two text editors open for this exercise:

- **Author a custom test**. Locate the path of the subdirectory *arm-ttk/testcases/deploymentTemplate/* of the test toolkit's installation directory. From here, you'll run Visual Studio Code, where you'll create and edit a custom test.
- **Author a template file and run tests**. You select the location that you want for this path. We recommend that you start an instance of Visual Studio Code from this path so you can easily edit the *azuredeploy.json* file when asked. Start an integrated terminal with this Visual Studio Code instance to make it easy to run tests.

## Create the template file

Choose a directory and create a file called *azuredeploy.json*.

> [!WARNING]
> Ensure that the selected directory is empty with no subdirectories.

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

1. Open Visual Studio Code and go to your installation directory for the test toolkit. Place yourself in the subdirectory *arm-ttk/testcases/deploymentTemplate*. Run the following command:

   ```bash
   code .
   ```

   > [!NOTE]
   > Open Visual Studio Code manually and open the directory if Visual Studio Code isn't on the path.
1. Create a custom test file called *Custom-ParameterNaming.test.ps1*. Give the file the following content:

   ```powershell
   param(
   [Parameter(Mandatory=$false,Position=0)] #not mandatory for case of an empty resource array
   [PSObject]
   $MainTemplateResources
   )

   Write-Error "To be implemented"
   ```

   Leave the text editor open. You'll edit this file later.

## Run the custom test

Run the custom test by following these steps:

1. Open a new terminal window or reuse the old one.
1. Go to the directory where you created *azuredeploy.json*. Run the following command to start Visual Studio Code:

   ```bash
   code .
   ``` 

   > [!NOTE]
   > Open Visual Studio Code manually and open the template directory if Visual Studio Code isn't on the path.

1. From Visual Studio Code, open the integrated terminal by selecting **Terminal** > **New Terminal** from the top menu. Run the following command in the terminal to start a PowerShell shell:

   ```bash
   pwsh
   ```

   You see output that looks similar to this:

   ```output
   PowerShell 7.0.3
   Copyright (c) Microsoft Corporation. All rights reserved.

   https://aka.ms/powershell
   Type 'help' to get help.
   ```

1. Run `Import-Module` in the terminal.

   > [!NOTE] 
   > Before you import the module, replace *path/to/arm-ttk/arm-ttk.psd1* with the path to the downloaded test toolkit.

   ```powershell
   Import-Module path/to/arm-ttk/arm-ttk.psd1
   ```

   > [!TIP]
   > If you downloaded or cloned the tool to your *Downloads* directory, the path would look something like this: */Users/<user\>/Downloads/arm-ttk/arm-ttk/arm-ttk.psd1*.
    
   You're now ready to use the tool. As long as you're in the same PowerShell session, there's no need to run the import command again.

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

   In the preceding output, your test is fourth from the top and indicated with this line:

   ```output
   [-] Custom ParameterNaming (4 ms)  To be implemented
   ```

   Now that you've found the test, leave this terminal window open. You'll reuse it later.

## Refactor the custom test

Now you'll give the custom test a proper implementation.

1. Go back to the text editor that holds the file *Custom-ParameterNaming.test.ps1*. 

   > [!NOTE]
   > If you accidentally closed Visual Studio Code, go to the subdirectory *arm-ttk/testcases/deploymentTemplate* and open *Custom-ParameterNaming.test.ps1*.

1. Replace the file's content with the following code:

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

   The preceding code iterates through all the parameters. It inspects the name attribute and checks whether the name starts with the prefix **tailwind**. If the inspected parameter doesn't match the naming rule, the code then invokes the **Write-Error** cmdlet with a suitable error message.

## Update the template file

You'll now add a parameter to the template file.

1. Select the text editor that contains *azuredeploy.json* and change the file's content to the following content:

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

   The preceding template content defines a parameter **location** that doesn't fulfill the naming rule, because it lacks the **tailwind** prefix.

## Rerun the test toolkit

You have a custom test written at this point. However, your template file's naming doesn't fulfill the requirement. So you expect the upcoming test run to fail. Ensure that's the case by taking the following step.

Use the existing Visual Studio Code integrated terminal window where PowerShell has been started and the test toolkit has been imported.

In Visual Studio Code, run `Test-AzTemplate` from the integrated terminal:

```powershell
Test-AzTemplate -TemplatePath . -Test Custom-ParameterNaming
```

The preceding command is run with the parameter **-Test**, which takes a test name as input. You've provided **Custom-ParameterNaming** as an argument, which means _only_ your newly developed test will be run.

> [!TIP]
> Using the **-Test** parameter is a good practice when you're developing a test because it limits what's being run and the size of the terminal output.

This command results in the following output:

```output
Validating custom\azuredeploy.json
 deploymentTemplate

 [-] Custom ParameterNaming (2ms) Parameter 'location' must start with prefix 'tailwind'
```

The result indicates that your test works. Let's ensure that's the case by altering the deployment file.

## Correct the template file

At this point, you want to verify the correctness of your custom test by changing the template file to adhere to the rules that the custom test laid out.

1. In the same Visual Studio Code instance that shows the *azuredeploy.json* file, change the file's content to the following content:

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

   The parameter **location** has been renamed to **tailwindLocation**. In theory, this parameter should now pass the test. Let's verify.

1. Continue with the same Visual Studio Code instance and run `Test-AzTemplate` in the integrated terminal:

   ```powershell
   Test-AzTemplate -TemplatePath . -Test Custom-ParameterNaming
    ```

   Your output now looks like the following:

   ```output
   Validating custom\azuredeploy.json                                                        deploymentTemplate
   [+] Custom ParameterNaming (2 ms)
   ```

Success! You've implemented and run a custom test. You've also corrected a deployment template to match the test's condition.
