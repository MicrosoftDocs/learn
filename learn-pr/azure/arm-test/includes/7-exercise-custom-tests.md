As a member of a product team it's important to be able to implement some team or domain-specific rules. A way to do so is to implement the rules as tests that you can run with the test tool **arm-ttk**.

## Author and run a Custom test

You will author a custom test and use the **arm-ttk** tool to run it. Furthermore you will need to correct the deployment template to ensure the test passes. The custom test will be looking to verify that any deployed resources are being deployed in **westeurope**. This rule is a domain-specific requirement on the product the team you are working on.

1. Open a terminal window
1. Clone the `ADDRESS` repo by running this command:

   ```bash
   git clone <repo url>
   ```

1. Go to your files by running the command:

   ```bash
   cd <url>
   ```

1. You should now have access to these files:

   ```bash
   azuredeploy.json
   ```

1. Locate your installation directory for the **arm-ttk** tool.
1. Place yourself in the sub directory **testcases/deploymentTemplate**
1. Create a file **Custom-Location.test.ps1** and give the file the following content:

   ```powershell
   param(
   [Parameter(Mandatory=$false,Position=0)] #not mandatory for case of an empty resource array
   [PSObject]
   $MainTemplateResources
   )

   Write-Error "To be implemented"
   ```

1. Ensure the **arm-ttk** tool runs this file by starting a test run with the following command at the root of the installation directory:

   1. Start the PowerShell shell:

      ```bash
      pwsh
      ```

   1. Import the **arm-ttk** module.

      ```powershell-interactive
      Import-Module ./arm-ttk.psd1
      ```

   1. Run the **arm-ttk** tool by typing the following command in the terminal, don't forget to change the **-TemplatePath** argument to your path:

      ```powershell-interactive
      Test-AzTemplate -TemplatePath /path/to/deployment/template
      ```

   You should see the following output:

      ```output
      Validating deploy\azuredeploy.json                                                        deploymentTemplate
       [+] adminUsername Should Not Be A Literal (16 ms)
       [+] apiVersions Should Be Recent (4 ms)
       [+] artifacts parameter (1 ms)
       [-] Custom Location (4 ms)  To be implemented
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
      [-] Custom Location (4 ms)  To be implemented
      ```

   Great, the test is found.

   There's also another test output with the following appearance:

      ```output
      [-] Resources Should Have Location (2 ms)                                                   Resource  Location must be an expression or 'global'
      ```

   This test indicates that a resources location should either be the value **global** or an expression. The test you are about to write will, when implemented, override the behavior of this test. Domain-specific rules may do that. In such a case, it's recommended that you delete that test from the **testcases/deploymentTemplate** sub directory.

1. Inspect the **azuredeploy.json** file located in your cloned directory. The file should have the following content:

   ```json
   {
      "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {},
      "resources": [{
        "location": "westus"
      }]
   }
   ```

   The above file content indicates that it has one resource in the **resources** array. That one resource has a location value of **westus**. The test you are about to implement should detect this value as incorrect, as it should be **westeurope**.

1. Implement the test by navigating to the sub directory **testcases/deploymentTemplate** and opening up the file **Custom-Location.test.ps1**. Replace the file content with the following code:

   ```powershell
   param(
   [Parameter(Mandatory=$false,Position=0)] #not mandatory for case of an empty resource array
   [PSObject]
   $MainTemplateResources
   )
    foreach ($mtr in $MainTemplateResources) {
        foreach ($resource in @(@($mtr) + $mtr.ParentResources)) {
            if ($resource.Location) {
                $location = "$($resource.location)".Trim()
                if ($location -notmatch '^westeurope$') {
                    Write-Error "Resource $($resource.Name) Location must be be located in westeurope'" -TargetObject $resource
                }
            }
        }
   }
   ```

   The above code iterates through all the resources and inspects the location property and checks whether it matches **westeurope**. If there's no match, then it invokes the **Write-Error** command-let with a suitable message.

1. Run the **arm-ttk** tool.

   1. Place yourself at the installation directory root.
   1. Start the PowerShell shell by typing the following terminal command:

      ```bash
      pwsh
      ```

   1. Type the following to import the arm-ttk module:

      ```powershell-interactive
      Import-Module ./arm-ttk.psd1
      ```

   1. Run the **arm-ttk** tool by typing the following command in the terminal:

      ```powershell-interactive
      Test-AzTemplate -TemplatePath /path/to/deployment/template -Test Custom-Location
      ```

      The above command is run with the parameter **-Test**, which takes as test name as input. You've provided **Custom-Location** as argument, which means only your newly developed test will be run. Using this parameter is a good practice when developing a test as it limits what is being run and outputted.

      This command results in the following output:

      ```output
      Validating custom\azuredeploy.json                                                          deploymentTemplate
      [-] Custom Location (1 ms)                                                                  Resource  Location must be be located in westeurope'
      ```

      The result above seems to indicate that your test works. Let's ensure that is the case by altering the deployment file.
  
1. Open up **azuredeploy.json** and change it to the following content:

   ```json
   {
      "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {},
      "resources": [{
        "location": "westeurope"
      }]
   }
   ```

1. Run the **arm-ttk** tool:

   1. Place yourself at the installation directory root.
   1. Start the PowerShell shell by typing the following terminal command:

      ```bash
      pwsh
      ```

   1. Type the following to import the **arm-ttk** module:

      ```powershell-interactive
      Import-Module ./arm-ttk.psd1
      ```

   1. Run the **arm-ttk** tool by typing the following command in the terminal:

      ```powershell-interactive
      Test-AzTemplate -TemplatePath /path/to/deployment/template -Test Custom-Location
      ```

      You should now see the following output:

      ```output
      Validating custom\azuredeploy.json                                                        deploymentTemplate
      [+] Custom Location (1 ms)
      ```

Success, you've managed to implement and a run custom test. Furthermore you've managed to correct a deployment template to match the tests condition.
