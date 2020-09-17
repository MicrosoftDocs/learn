As a member of a product team it's important to be able to implement some team or domain-specific rules. A way to do so is to implement the rules as tests that you can run with the test tool Test Toolkit.

## Author and run a Custom test

You will author a custom test and use the Test Toolkit tool to run it. Furthermore you will need to correct the deployment template to ensure the test passes. The custom test will be looking to verify that all parameters follow a naming rule. This rule is a domain-specific requirement on the product the team you are working on.

1. Open a terminal window
1. **Create a template file**. Create a file called `azuredeploy.json`. Give it the following content:

   ```json
   {
      "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {},
      "resources": []
   }
   ```

1. Locate your installation directory for the Test Toolkit tool.
1. Place yourself in the sub directory **testcases/deploymentTemplate**
1. Create a file **Custom-ParameterNaming.test.ps1** and give the file the following content:

   ```powershell
   param(
   [Parameter(Mandatory=$false,Position=0)] #not mandatory for case of an empty resource array
   [PSObject]
   $MainTemplateResources
   )

   Write-Error "To be implemented"
   ```

1. Ensure the Test Toolkit tool runs this file by starting a test run with the following command at the root of the installation directory:

   1. Start the PowerShell shell:

      ```bash
      pwsh
      ```

   1. Import the **arm-ttk** module.

      ```powershell
      Import-Module ./arm-ttk.psd1
      ```

   1. Run the Test Toolkit tool by typing the following command in the terminal, don't forget to change the **-TemplatePath** argument to your path:

      ```powershell
      Test-AzTemplate -TemplatePath /path/to/deployment/template
      ```

   You should see the following output:

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

   Great, the test is found.

1. Inspect the **azuredeploy.json** file located in your cloned directory. The file should have the following content:

   ```json
   {
      "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {},
      "resources": []
   }
   ```

   The above file content indicates that it has no parameters as the **parameters** property is set to `{}`. The test you are about to implement should detect if any parameters are defined and if they adhere to a naming standard.

1. Implement the test by navigating to the sub directory **testcases/deploymentTemplate** and opening up the file **Custom-ParameterNaming.test.ps1**. Replace the file content with the following code:

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

   The above code iterates through all the parameters and inspects its name and checks whether it the name starts with **tailwind**. If parameter does not match naming rule, then the code invokes the **Write-Error** cmdlet with a suitable message.

1. Open up **azuredeploy.json** and change it to the following content:

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

1. Run the Test Toolkit tool.

   1. Place yourself at the installation directory root.
   1. Start the PowerShell shell by typing the following terminal command:

      ```bash
      pwsh
      ```

   1. Type the following to import the **arm-ttk** module:

      ```powershell
      Import-Module ./arm-ttk.psd1
      ```

   1. Run the Test Toolkit tool by typing the following command in the terminal:

      ```powershell
      Test-AzTemplate -TemplatePath /path/to/deployment/template -Test Custom-ParameterNaming
      ```

      The above command is run with the parameter **-Test**, which takes a test name as input. You've provided **Custom-ParameterNaming** as argument, which means only your newly developed test will be run. Using this parameter is a good practice when developing a test as it limits what is being run and output to the terminal.

      This command results in the following output:

      ```output
      Validating custom\azuredeploy.json
      deploymentTemplate

      [-] Custom ParameterNaming (2ms) Parameter 'location' must start with prefix 'tailwind'
      ```

      The result above indicates that your test works. Let's ensure that is the case by altering the deployment file.
  
1. Open up **azuredeploy.json** and change it to the following content:

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

1. Run the Test Toolkit tool:

   1. Place yourself at the installation directory root.
   1. Start the PowerShell shell by typing the following terminal command:

      ```bash
      pwsh
      ```

   1. Type the following to import the **arm-ttk** module:

      ```powershell
      Import-Module ./arm-ttk.psd1
      ```

   1. Run the Test Toolkit tool by typing the following command in the terminal:

      ```powershell
      Test-AzTemplate -TemplatePath /path/to/deployment/template -Test Custom-ParameterNaming
      ```

      You should now see the following output:

      ```output
      Validating custom\azuredeploy.json                                                        deploymentTemplate
      [+] Custom ParameterNaming (2 ms)
      ```

Success, you've managed to implement and run a custom test. Furthermore you've managed to correct a deployment template to match the tests condition.
