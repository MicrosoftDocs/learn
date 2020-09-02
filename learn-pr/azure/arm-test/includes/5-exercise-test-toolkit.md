You're part of a development team at the company Tailwind Traders. As part of that work you need to author ARM templates to deploy and manage resources in the Cloud. You want to ensure the templates follow some sounds practices before it's deployed. You therefore elect to use the ARM-ttk tool to help you analyze your templates, so you can rectify any problems. 

## Fix issues on your template by running the Test toolkit

You will run the arm-ttk tool on a deployment template and fix any errors it detects.

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

1. Before proceeding, make a note of the location of your files. Next, in the terminal navigate to the location of the file **arm-ttk.psd1**
1. Type the following command in the terminal to start a PowerShell shell:

   ```bash
   pwsh
   ```

   You should see an output looking roughly like the below:

   ```output
   PowerShell 7.0.3
   Copyright (c) Microsoft Corporation. All rights reserved.

   https://aka.ms/powershell
   Type 'help' to get help.
   ```

1. Next import the **arm-ttk** module by typing the following command:

   ```bash
   Import-Module ./arm-ttk.psd1
   ```  

1. You will now run the tool. Ensure you use the location of your GitHub files below as an argument to **-TemplatePath**. Run the tests by typing the following command:

   ```bash
   Test-AzTemplate -TemplatePath path/to/starter/template
   ```

   You should see the following output in the terminal:

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
   [-] Parameters Must Be Referenced (2 ms)                                                    Unreferenced parameter: location
   [+] Parameters Property Must Exist (1 ms)                                               
   [+] providers apiVersions Is Not Permitted (1 ms)                                       
   [+] ResourceIds should not contain (1 ms)
   [-] Resources Should Have Location (8 ms)                                                   Resource  Location must be an expression or 'global'                                                                                              [+] Secure String Parameters Cannot Have Default (1 ms)
   [+] Template Should Not Contain Blanks (1 ms)
   [+] Variables Must Be Referenced (1 ms)
   [+] Virtual Machines Should Not Be Preview (3 ms)
   [+] VM Images Should Use Latest Version (1 ms)                                          
   [+] VM Size Should Be A Parameter (3 ms)
   ```

   Note above how two tests are failing,  **Resources Should have Location is failing** and  **Parameters Must Be Referenced**. A failing test is indicated by the prefix **[-]**.

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

   - **The location parameter isn't used**. This error message might, for example,  indicate that we have used it in the past and forgot to clean it up. Or that it should be used but we forgot to update our code.
   - **The location property is set to the hardcoded string westus**. Using this option is not considered a good practice as you want to be able to control the location of a resource with input parameters when you are deploying.

   So how to fix it?

   As the test indicates, we could try replacing **westus** with the text **global**. However, that would only fix one of the problems. Most likely we want to use the **location** parameter and set the resources location to that value. The reason is two-fold, not only can the location parameter be set as an argument when deploying, it also has reasonable fallback of being set to the **resourceGroup().location** as *defaultValue* should you omit to set the **location** when running the deployment.

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

1. Run the test tool once again with the following command:

   ```bash
   Test-AzTemplate -TemplatePath path/to/starter/template
   ```

   You should now get output where all tests pass:

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