# Module Design
## Title

Build a scalable application with virtual machine scale sets

## Role(s)

- Solution Architect

## Level

- Beginner

## Product(s)

- Azure virtual machine scale sets
- Azure custom script extension

## Prerequisites

- Basic knowledge of Azure virtual machines
- Basic knowledge of load balancing concepts

## Summary

Enable your application to automatically adjust to changes in load while minimizing costs with Azure virtual machine scale sets.

## Learning objectives

1. Identify the features and capabilities of virtual machine scale sets
1. Identify the use cases for running applications on virtual machine scale sets
1. Deploy an application on a virtual machine scale set

## Chunk your content into subtasks

Identify the subtasks of *Build a scalable application with virtual machine scale sets*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- |---|---|---|---|
| Features and benefits of Azure Virtual Machine Scale Set | Review the concepts and components of an Azure Scale Set  | Exercise | Identify the features and capabilities of Azure Virtual Machine Scale Sets | Yes |
| Configuring an Azure Virtual Machine Scale Set | Understanding and implementing a Horizontally scaling Virtual Scale Set to meet demand | Exercise  | Identify and implement a solution to scale to demand | Yes |
| Installing and Updating Applications in Scale Sets | Need to quickly roll out application udpates | Exercise | Implementing a Custom Script extension and performing an Application update | Yes |
||||||

## Outline the units
1. **Introduction**

    A domestic shipping company has a web site that customers can use to manage and check the status of their shipments. This site currently runs on virtual machines on-premises, and the company is moving this application to Azure. They currently have a fixed capacity on-premises and are unable to adjust to fluctuations in load without manually intervening and creating or deallocating virtual machines. They need a solution that will automatically handle these fluctuations in load to ensure consistent performance for their web site. They also need a way to quickly roll out application updates to the servers while minimizing impact to end users.

### 2. Features and benefits of Azure Virtual Machine Scale Set

In this unit, you will explore the features of Azure Virtual Machine Scale Sets. By the end of this unit, you will be able to:

- Understand the Azure Virtual Machine scale set offerings, including scheduled and autoscaling.
- Understand Horizontal-vs-Vertical scaling.
- Understand the Low Priority Scale Set offering.

Cover the following points:

- What is an Azure Azure Virtual Machine Scale Set (VMSS)
  - A scale set is a group of identically configured virtual machines for horizontal scaling within Azure 
  - It can be used to provide a Highly Available environment while introducing the potential for scaling to meet planned and unplanned demand.
  - Horizontal scaling is deploying multiple matching instances of a server to achieve load balancing and load sharing.  This differs from Vertical sharing, which is increasing the physical amount of CPU and memory on the VM and typically require outage in the form of a reboot.
  - Azure Scale Sets address the need to quickly create and manage the VMs for a workload which fluctuates in load. This can be achieved via:
    - A scheduled configuration. When you know there will be a spike in demand you can proactively schedule the scale set to deploy one or N number of additional instances to fulfill the spike in traffic and then scale back down once the spike ends.
    - Autoscaling.  Where the workload is variable, and not always able to be scheduled, you can employ metric based threshold scaling.  This will horizontally scale out based upon node utilization,  then scale back in when the resources have returned to a baseline level.
    - Both these options address the requirement to scale while managing the costs associated with that.
    - Supported on both Windows platform and Linux
- Use case 1
  - Suppose you are a DevOps for a large food delivery company.  Friday night is typically your busiest time, and conversely, 7 am on a Wednesday generally is your quietest time which dictates different requirements for your computational resources. As Azure charges based upon consumption of resources,  as such you don't want to have services running which you don't need. If you need 100 hundred web servers to meet your demand on a Friday night, you are happy to pay for this requirement. However, if you only need two servers to fulfill your requirement on a Wednesday morning - you don't want to have to pay for the additional 98 servers. To optimize spend while fulfilling your operational requirements, you look to use a scheduled Azure Virtual Machine Set.
- Use case 2
  - Suppose you are a DevOps for a popular footwear company.  You have a product launch approaching and believe there will be a significant demand for your service, but the nature of the spike in demand may be unpredictable and hard to quantify.   You want the service to meet the demand by organically horizontally scaling as the current resource is utilized. For this, you look to use metrics based Autoscaling, to scale out your infrastructure as demand rises and to scale in when that demand reduces. 
- What is a 'Low Priority' VM Scale Set 
  - Offers the opportunity for significant cost savings by utilizing compute power of unutilized capacity within Azure without any availability guarantees.
  - This is a pets-vs-cattle outlook, where this is the cattle outlook of employing a herd of instances to achieve your desired workload.
  - It offers two options,  Deallocation or Delete. Deallocate will retain the data, in case you wished to bring back up the VM to complete its workload 
  - This feature is currently in preview and is designed for workloads which can handle interruption, as instances can be evicted at any time.

### 2. Exercise - deploy a Low Priority Scale Set in Azure Portal

Deploying a Scale Set in Azure Portal
- Enter Virtual Machine Scale Set in Azure Portal
  1) Click Add
  2) Name the VMSS
  3) Select an Operating System, for this example Windows Datacentre
  4) Enter a new resource group name
  5) Select East US 2 for location
  6) Select Zones 1,2 and 3 for Availability zone
  7) enter a username, and password as an administrative credential
  8) Select an instance count of 2
  9) Select an instance size (DS1_v2)
  10) Select Yes to 'Deploy as Low Priority' choosing stop/deallocate.
  11) Select Loadbalancer as a network option
  12) Enter a public IP address name and domain name label
  13) Hit Create

### 3. Configuring an Azure Virtual Machine Scale Set

You need to set up an environment which can horizontally scale when demand and load increases. By the end of this unit, you will be able to:

- Understand Azure Scale Set Autoscale approaches.
- Understand Azure Scale Set Autoscale rules.

Cover the following points:
- A key benefit of a scale set is employing Autoscale. There are three ways to configure Autoscale which can be done via the Portal or programmatically via the API/SDK.
  - Manually by increasing or decreasing the Azure instance count.
  - Schedule based - if you know you will have an increased workload on a specified date/time window you can proactively plan for that
  - Metric-based - using a variety of resource can determine how and when to scale out your Azure scale set, and how and when to return to your baseline.
    - A scale set will have a series of rules, defaults, and limits. It is essential to set limits so you can define the outer parameters for the size of your scale set. This includes the minimum number of nodes in a scale set, the maximum and the default.
    - An autoscale set rule defines the criteria for horizontally scaling your application; for example, increase the instance count by one when CPU utilization crosses a predefined threshold e.g. 70%.
    - Creating a scale rule brings together a set of conditions for example
      - Time aggregation (Average, Minimum, Maximum, Last, Count)
      - Metric name (CPU, Memory, etc.)
      - Time grain statistic - Defines how the collected metrics in each time grain should be aggregated for analysis.    
      - Operator - the logic condition, for example, greater than
      - Threshold - the value the condition has to in this case exceed (70)
      - Duration - of importance as it takes time to provision and scales down the virtual machine so you would want the system to have observed this increased period of the load over a certain amount of time (10 minutes for example) before scaling up another instance into the scale set.
      - Cool down period - Amount of time to wait before attempting to perform another scaling operation.
      - [Example](https://docs.microsoft.com/azure/virtual-machine-scale-sets/media/virtual-machine-scale-sets-autoscale-portal/rule-increase.png) 
    - As a default, a scale in rule is not created. For every scale set at least one scale in rule should be set.


### 4. Exercise - Configuring a Scale Set
You need to set up an environment which can horizontally scale when demand and load increases. By the end of this unit, you will have:

- Configure an existing scale set to autoscale when CPU threshold exceeds 70% utilization
- Set a Scale in rule to reduce the number of instances when the demand cools.

We will be using the Scale set created in unit 2. 
  1) Open the Portal and navigate to Virtual Machine scale set 
  2) Select the scale set created in unit 2)
  3) In settings panel select scaling
  4) Select Enable Autoscale
  5) Select scale based upon a metric
  6) Select add a rule 
  7) Time aggregation: Average
  8) Metric Name: Percentage CPU
  9) Time grain statistic: Average
  10) Operator: Greater than
  11) Threshold: 70
  12) Duration: 10
  13) Increase count by 1
  14) Set cool down period to 5 minutes and save.
  15) To add a scale down route repeat steps 6-14 replacing step 13) with a decrease 

### Unit 5: Installing and Updating Applications in Scale Sets
You need to configure your virtual machines when they start in the scale set and periodically will need to update the application running on your virtual machine. By the end of this unit, you will understand how to :

- Use the Azure Custom Script Extension
- Update a running application on a scale set

Cover the following points:
- Azure Custom Script Extension
  - The custom script extension downloads and executes scripts on Azure VMs. Typically this is used for post-deployment configuration, software installation, or any other configuration/management task. 
  - Custom scripts can be hosts on Azure Storage (e.g. Blob), GitHub or via the Azure Portal at extension runtime.
  - It can integrate with Azure Resource Manager (ARM) templates, used with the Azure CLI, Powershell, Portal or REST API.  More information can be found [here](https://docs.microsoft.com/azure/virtual-machines/linux/extensions-customscript)
  - To use the Custom Script Extension with the Azure CLI, you create a JSON file that defines what files to obtain and commands to execute. An example is as below

```
  {
    "fileUris": ["https://raw.githubusercontent.com/Azure-Samples/compute-automation-configurations/master/automate_nginx.sh"],
    "commandToExecute": "./automate_nginx.sh"
  }
```
  - Updating an App deployment. 
    - Throughout the lifecycle of a scale set, you may want to deploy an updated version of your application. In the Custom Script Extension, it's possible to reference an updated deploy script and reapply the extension to part or all of your scale set.
    - When creating a scale set, you can define an upgrade policy. The three modes are
      1) Automatic.  The scale set makes no guarantees as to the order of the VM's being brought down. Potentially, all VMs could be brought down at the same time, causing a service outage.
      2) Rolling.  The scale set rolls out the update in batches with an optional pause to minimize or eliminate service outage.
      3) Manual. When you update the scale set model,  no actions to existing VMs

### Unit 6: Exercise - Installing and Updating Applications in Scale Sets

You need to deploy Proxy software to your Azuze Virtual Machine Scale Set. In this unit, you will use the Azure Shell and CLI to create a Scale set, use a Custom Script Extension to deploy the Proxy and then roll out an update

  1) Open Azure Cloud shell by selecting the Cloud Shell button on the menu in the upper-right corner of the Azure portal.    
  2) Create the Custom Script Extension definition by running `sensible-editor customConfig.json` and entering the below code block
  ```
  {
    "fileUris": ["https://raw.githubusercontent.com/Azure-Samples/compute-automation-configurations/master/automate_nginx.sh"],
    "commandToExecute": "./automate_nginx.sh"
  }
  ```
  3) Create a resource group named myResourceGroup in the eastus location
  ```
  az group create --name myResourceGroup --location eastus
  ```
  4) Create a virtual machine set. This will take a few minutes.
  ```
  az vmss create \
  --resource-group myResourceGroup \
  --name myScaleSet \
  --image UbuntuLTS \
  --upgrade-policy-mode automatic \
  --admin-username azureuser \
  --generate-ssh-keys
  ```
  5) Apply the custom script agent
  ```
  az vmss extension set \
  --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --name CustomScript \
  --resource-group myResourceGroup \
  --vmss-name myScaleSet \
  --settings @customConfig.json
  ```
  6) Create a Load Balancer rule
  ```
  az network lb rule create \
  --resource-group myResourceGroup \
  --name myLoadBalancerRuleWeb \
  --lb-name myScaleSetLB \
  --backend-pool-name myScaleSetLBBEPool \
  --backend-port 80 \
  --frontend-ip-name loadBalancerFrontEnd \
  --frontend-port 80 \
  --protocol tcp
  ```
  7) To test your WebServer, collect the Public IP of your Load Balancer. Enter the output of this into a Web Brower. Leave this page open.
  ```
  az network public-ip show \
  --resource-group myResourceGroup \
  --name myScaleSetLBPublicIP \
  --query [ipAddress] \
  --output tsv
  ```
  [images](https://docs.microsoft.com/azure/virtual-machine-scale-sets/media/tutorial-install-apps-cli/running-nginx.png)
  8) To update your App Deployment update the Custom Script Extension.  Create the following file using `sensible-editor customConfigv2.json`
  ```
  {
    "fileUris": ["https://raw.githubusercontent.com/Azure-Samples/compute-automation-configurations/master/automate_nginx_v2.sh"],
    "commandToExecute": "./automate_nginx_v2.sh"
  }
  ```
  9) Apply the Custom Script Extension to the VM instances in the Scale Set
  ```
  az vmss extension set \
    --publisher Microsoft.Azure.Extensions \
    --version 2.0 \
    --name CustomScript \
    --resource-group myResourceGroup \
    --vmss-name myScaleSet \
    --settings @customConfigv2.json
  ```
  10) Refresh the web site in your browser, observing the updated response.
  [image](https://docs.microsoft.com/azure/virtual-machine-scale-sets/media/tutorial-install-apps-cli/running-nginx.png)



### Unit 7: Summary + Cleanup

How did you solve the problem in the initial scenario with the knowledge learned in the module?

- Explained the features of Azure Virtual Machine Scale Set.
- Described how Scale Sets could be configured to autoscale manually, based upon a schedule, or via metrics 
- Configured an autoscale set based upon Metrics
- Configured an Internal Load Balancer across availability zones.
- Configured a Custom Script Agent to deploy an Application Proxy and performed an update

Clean up

- Remove scale sets and all associated resources from the portal.

## Notes
Create VMSS - https://docs.microsoft.com/azure/virtual-machine-scale-sets/tutorial-create-and-manage-cli  
Install and upgrade an application on VMSS - https://docs.microsoft.com/azure/virtual-machine-scale-sets/tutorial-install-apps-cli  

We currently don't have scale sets enabled in the sandbox so the learner may have to use their own subscription. Design based upon scale sets becoming available in Azure.  