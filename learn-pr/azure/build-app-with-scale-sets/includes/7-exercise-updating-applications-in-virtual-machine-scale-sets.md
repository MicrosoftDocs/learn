<!-- Topic sentence -->

<!-- Scenario sub-task -->

<!-- Task performed in the exercise -->

<!-- Optional image (this should be either an image of the completed solution or the section that is being completed in the greater solution)-->

## [Part 1 title]

<!-- Introduction paragraph -->

1. <!-- Step 1 -->

1. <!-- Step 2 -->

1. <!-- Step n -->

## [Part 2 title]

<!-- Introduction paragraph -->

1. <!-- Step 1 -->

1. <!-- Step 2 -->

1. <!-- Step n -->

## [Part n title]

<!-- Introduction paragraph -->

1. <!-- Step 1 -->

1. <!-- Step 2 -->

1. <!-- Step n -->

## [Result part title]

<!-- Introduction paragraph -->

1. <!-- Optional step 1 -->

1. <!-- Optional step 2 -->

1. <!-- Optional step n -->

## Notes from design doc
**Exercise - Updating applications in virtual machine scale sets**

You have previously installed the nginx web server across your virtual machine scale set. In this exercise, you wicode cloud- ll use a Custom Script Extension to roll out an update to the web app served by nginx. In this exercise, you will simply amend the message displayed by the web app, but you can use the same principle to perform more substantial updates.

1.  

In the Azure Cloud shell, run the following command:

<code class="language-azurecli">az vmss extension set \  --vmss-name webServerScaleSet \  --name customScript \  --resource-group <Sandox Resource Group> \  --force-update \  --version 2.0 \  --publisher Microsoft.Azure.Extensions \  --settings '{"commandToExecute": "echo This is the updated app installed on the VM Scale Set ! > /var/www/html/index.html"}'</code>

2.  

Navigate to the public address of the scale set load balancer in the web browser. Verify that the message. This is the updated app installed on the virtual machine scale set** appears
