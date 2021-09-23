Here's a Bicep file and module.

main.bicep
 module blah xxx.bicep = { name = yyy }

xxx.bicep


1. You deploy the main.bicep file with the default settings. You open the Azure portal and look at the deployment history for the resource group. What do you see?
  - A single deployment named main
  - Two deployments - one named main and the other named xxx
  - Two deployments - one named main and the other named yyy
      - Correct.

2. Something about getting a secret output from the module
  - Create an `output` in the module and set it to the value of the connection string.
  - Use a Key Vault to create a secret.
  - You don't need to do anything. Properties for all the resources defined in the module are automatically available to the parent template.

3. Something about conditions
