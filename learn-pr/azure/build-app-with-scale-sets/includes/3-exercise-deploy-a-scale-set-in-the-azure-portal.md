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
**Exercise - Deploy a scale set in the Azure portal**

Deploy a Scale Set of Ubuntu VMs configured with nginx acting as a web server.

1.  

In the Cloud Shell, use the Code editor to create the following YAML file. Name file **cloud-init.yaml** The YAML file contains the configuration information for installing nginx on the VMs in a scale set:

<code class="language-yaml">#cloud-configpackage_upgrade: truepackages:  - nginxwrite_files:  - owner: www-data:www-data  - path: /var/www/html/index.html    content: |      Hello world from VM Scale Set !runcmd:  - service nginx restart</code>

2.  

Create the scale set with the following command:

<code class="language-azurecli">az vmss create \  --resource-group <sandbox resource group> \  --name webServerScaleSet \  --image UbuntuLTS \  --upgrade-policy-mode automatic \  --custom-data cloud-init.yaml \  --admin-username azureuser \  --generate-ssh-keys</code>

By default, the virtual machine scale set is created with two instances and a load balancer.

3.  

Add a health probe to the load balancer (the load balancer may fail to route traffic to a web server if it cannot detect the health of any servers)

<code class="language-azurecli">az network lb probe create \  --lb-name webServerScaleSetLB \  --resource-group <sandbox resource group> \  --name webServerHealth \  --port 80 \  --protocol Http \  --path /</code>

4.  

Run the following command to configure the load balancer to route HTTP traffic to the instances in the scale set.

<code class="language-azurecli">az network lb rule create \  --resource-group <sandbox resource group> \  --name webServerLoadBalancerRuleWeb \  --lb-name webServerScaleSetLB \  --probe-name webServerHealth \  --backend-pool-name webServerScaleSetLBBEPool \  --backend-port 80 \  --frontend-ip-name loadBalancerFrontEnd \  --frontend-port 80 \  --protocol tcp</code>

Examine the Scale Set in Azure portal:

1.  Go to the Sandbox resource group and select the virtual machine scale set
2.  Make a note of the public IP address of the scale set
3.  Click Instances, and verify that the scale set contains two running VMs
4.  Click Operating system, and verify that the VMs are running Ubuntu Linux
5.  Click Size. The VMs should be running on DS1_v2 hardware

Test the scale set:

1.  In the web browser, navigate to the public IP address of the scale set:
2.  Verify that the message **Hello World from virtual machine scale set** appears
