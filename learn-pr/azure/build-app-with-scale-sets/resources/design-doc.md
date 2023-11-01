# Title

Build a scalable application with virtual machine scale sets

## Role(s)

- Solution Architect

## Level

- Beginner

## Product(s)

- virtual machine scale sets
- Azure custom script extension

## Prerequisites

- Basic knowledge of Azure virtual machines
- Basic knowledge of load balancing concepts

## Summary

Enable your application to automatically adjust to changes in load while minimizing costs with virtual machine scale sets.

## Learning objectives

1. Identify the features and capabilities of virtual machine scale sets
1. Identify the use cases for running applications on virtual machine scale sets
1. Deploy an application on a virtual machine scale set

## Chunk your content into subtasks

Identify the subtasks of *Build a scalable application with virtual machine scale sets*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- |---|---|---|---|
| Features and benefits of virtual machine scale set | Review the concepts and components of an virtual machine scale set  | Exercise | Identify the features and capabilities of virtual machine scale sets | Yes |
| Configuring an virtual machine scale set | Understanding and implementing a Horizontally scaling Virtual Scale Set to meet demand | Exercise  | Identify and implement a solution to scale to demand | Yes |
| Installing and Updating Applications in Scale Sets | Need to quickly roll out application updates | Exercise | Implementing a Custom Script extension and performing an Application update | Yes |

## Outline the units

1. **Introduction**

    A domestic shipping company has a web site that customers can use to manage and check the status of their shipments. This site currently runs on virtual machines on-premises, and the company is moving this application to Azure. They currently have a fixed capacity on-premises and are unable to adjust to fluctuations in load without manually intervening and creating or deallocating virtual machines. They need a solution that will automatically handle these fluctuations in load to ensure consistent performance for their web site. They also need a way to quickly roll out application updates to the servers while minimizing impact to end users.

1. **Features and benefits of virtual machine scale sets**

    In this unit, you'll explore the features of virtual machine scale sets. By the end of this unit, you'll be able to:
  
    - Understand the virtual machine scale set offerings, including scheduled and autoscaling.
    - Understand Horizontal-vs-Vertical scaling.
    - Understand the Low-Priority Scale Set offering.

    Cover the following points:

    - What is an virtual machine scale set (virtual machine scale set)
      - A scale set is a group of identically configured virtual machines for horizontal scaling within Azure 
      - It can be used to provide a Highly Available environment while introducing the potential for scaling to meet planned and unplanned demand.
      - Horizontal scaling is deploying multiple matching instances of a server to achieve load balancing and load sharing.  This differs from Vertical sharing, which is increasing the physical amount of CPU and memory on the VM and typically require outage in the form of a reboot.
      - Virtual machine scale sets address the need to quickly create and manage the VMs for a workload, which fluctuates in load. This can be achieved via:
        - A scheduled configuration. When you know there will be a spike in demand, you can proactively schedule the scale set to deploy one or N number of additional instances to fulfill the spike in traffic and then scale back down once the spike ends.
        - Autoscaling.  Where the workload is variable, and not always able to be scheduled, you can employ metric based threshold scaling.  This will horizontally scale out based upon node utilization,  then scale back in when the resources have returned to a baseline level.
        - Both these options address the requirement to scale while managing the costs associated with that.
        - Supported on both Windows platform and Linux
    - Use case 1
      - Suppose you are a DevOps for a large food delivery company.  Friday night is typically your busiest time, and conversely, 7 am on a Wednesday generally is your quietest time, which dictates different requirements for your computational resources. As Azure charges based upon consumption of resources,  as such you don't want to have services running which you don't need. If you need 100 hundred web servers to meet your demand on a Friday night, you are happy to pay for this requirement. However, if you only need two servers to fulfill your requirement on a Wednesday morning - you don't want to have to pay for the additional 98 servers. To optimize spend while fulfilling your operational requirements, you look to use a scheduled Azure Virtual Machine Set.
    - Use case 2
      - Suppose you are a DevOps for a popular footwear company.  You have a product launch approaching and believe there will be a significant demand for your service, but the nature of the spike in demand may be unpredictable and hard to quantify.   You want the service to meet the demand by organically horizontally scaling as the current resource is utilized. For this, you look to use metrics-based autoscaling, to scale out your infrastructure as demand rises, and to scale in when that demand reduces. 
    - What is a 'Low Priority' virtual machine scale set 
      - Offers the opportunity for significant cost savings by utilizing compute power of unutilized capacity within Azure without any availability guarantees.
      - This is a pets-vs-cattle outlook, where this is the cattle outlook of employing a herd of instances to achieve your desired workload.
      - It offers two options: Deallocation or Delete. Deallocate will retain the data, in case you wished to bring back up the VM to complete its workload 
      - This feature is currently in preview and is designed for workloads, which can handle interruption, as instances can be evicted at any time.

1. **Exercise - Deploy a scale set in the Azure portal**

    Deploy a Scale Set of Ubuntu VMs configured with nginx acting as a web server.

      1. In the Cloud Shell, use the Code editor to create the following YAML file. Name file **cloud-init.yaml** The YAML file contains the configuration information for installing nginx on the VMs in a scale set:

          ```yaml
          #cloud-config
          package_upgrade: true
          packages:
            - nginx
          write_files:
            - owner: www-data:www-data
            - path: /var/www/html/index.html
              content: |
                Hello world from VM Scale Set !
          runcmd:
            - service nginx restart
          ```

      1. Create the scale set with the following command:

          ```azurecli
          az vmss create \
            --resource-group <sandbox resource group> \
            --name webServerScaleSet \
            --image Ubuntu2204 \
            --upgrade-policy-mode automatic \
            --custom-data cloud-init.yaml \
            --admin-username azureuser \
            --generate-ssh-keys
          ```

          By default, the virtual machine scale set is created with two instances and a load balancer.

      1. Add a health probe to the load balancer (the load balancer may fail to route traffic to a web server if it cannot detect the health of any servers)

          ```azurecli
          az network lb probe create \
            --lb-name webServerScaleSetLB \
            --resource-group <sandbox resource group> \
            --name webServerHealth \
            --port 80 \
            --protocol Http \
            --path /
          ```

      1. Run the following command to configure the load balancer to route HTTP traffic to the instances in the scale set.

          ```azurecli
          az network lb rule create \
            --resource-group <sandbox resource group> \
            --name webServerLoadBalancerRuleWeb \
            --lb-name webServerScaleSetLB \
            --probe-name webServerHealth \
            --backend-pool-name webServerScaleSetLBBEPool \
            --backend-port 80 \
            --frontend-ip-name loadBalancerFrontEnd \
            --frontend-port 80 \
            --protocol tcp
          ```

    Examine the Scale Set in Azure portal:

      1. Go to the Sandbox resource group and select the virtual machine scale set
      2. Make a note of the public IP address of the scale set
      3. Click Instances, and verify that the scale set contains two running VMs
      4. Click Operating system, and verify that the VMs are running Ubuntu Linux
      5. Click Size. The VMs should be running on DS1_v2 hardware

    Test the scale set:

      1. In the web browser, navigate to the public IP address of the scale set:
      2. Verify that the message **Hello World from virtual machine scale set** appears

1. **Configuring a virtual machine scale set**

    You need to set up an environment, which can horizontally scale when demand and load increases. By the end of this unit, you will be able to:
  
    - Understand virtual machine scale set autoscale approaches.
    - Understand virtual machine scale set autoscale rules.
  
    Cover the following points:
    - A key benefit of a scale set is employing autoscale. There are three ways to configure autoscale, which can be done via the Portal or programmatically via the API/SDK.
      - Manually by increasing or decreasing the Azure instance count.
      - Schedule based - if you know you will have an increased workload on a specified date/time window you can proactively plan for that
      - Metric-based - using a variety of resource can determine how and when to scale out your virtual machine scale set, and how and when to return to your baseline.
        - A scale set will have a series of rules, defaults, and limits. It is essential to set limits so you can define the outer parameters for the size of your scale set. This includes the minimum number of nodes in a scale set, the maximum, and the default.
        - An autoscale set rule defines the criteria for horizontally scaling your application; for example, increase the instance count by one when CPU utilization crosses a predefined threshold for example, 70%.
        - Creating a scale rule brings together a set of conditions for example
          - Time aggregation (Average, Minimum, Maximum, Last, Count)
          - Metric name (CPU, Memory, etc.)
          - Time grain statistic - Defines how the collected metrics in each time grain should be aggregated for analysis.    
          - Operator - the logic condition, for example, greater than
          - Threshold - the value the condition has to in this case exceed (70)
          - Duration - of importance as it takes time to provision and scales down the virtual machine so you would want the system to have observed this increased period of the load over a certain amount of time (10 minutes for example) before scaling up another instance into the scale set.
          - Cool down period - Amount of time to wait before attempting to perform another scaling operation.
          - [Example](/azure/virtual-machine-scale-sets/media/virtual-machine-scale-sets-autoscale-portal/rule-increase.png) 
        - As a default, a scale in rule is not created. For every scale set at least one scale in rule should be set.

1. **Exercise - Configuring a virtual machine scale set**

    You need to set up an environment, which can horizontally scale when demand and load increases. In this unit, you will:

    - Configure an existing scale set to autoscale when CPU threshold exceeds 70% utilization
    - Set a Scale in rule to reduce the number of instances when the demand cools.

    Use the Scale set created in unit 2.
      1. Open the Azure portal and navigate to virtual machine scale set
      2. Select the scale set created in unit 2.
      3. In settings panel, select scaling
      4. Select Enable autoscale
      5. Select scale based upon a metric
      6. Select add a rule
      7. Time aggregation: Average
      8. Metric Name: Percentage CPU
      9. Time grain statistic: Average
      10. Operator: Greater than
      11. Threshold: 70
      12. Duration: 10
      13. Increase count by 1
      14. Set cool down period to 5 minutes and save.
      15. To add a scale down route repeat steps 6-14 replacing step 11 with 60 and step 13 with a decrease by 1.

1. **Installing and updating applications in virtual machine scale sets**

    You need to configure your virtual machines when they start in the scale set and periodically will need to update the application running on your virtual machine. By the end of this unit, you'll understand how to:

    - Use the Azure Custom Script Extension
    - Update a running application on a scale set
  
    Cover the following points:
    - Azure Custom Script Extension
      - The custom script extension downloads and executes scripts on Azure VMs. Typically this is used for post-deployment configuration, software installation, or any other configuration/management task. 
      - Custom scripts can be hosts on Azure Storage (for example, Blob), GitHub or via the Azure portal at extension runtime.
      - It can integrate with Azure Resource Manager (ARM) templates, used with the Azure CLI, Powershell, Portal, or REST API.  More information can be found [here](/azure/virtual-machines/linux/extensions-customscript)
      - To use the Custom Script Extension with the Azure CLI, you create a JSON file that defines what files to obtain and commands to execute. Show an example.
      - Updating an App deployment. 
        - Throughout the lifecycle of a scale set, you may want to deploy an updated version of your application. In the Custom Script Extension, it's possible to reference an updated deploy script and reapply the extension to part or all of your scale set.
        - When creating a scale set, you can define an upgrade policy. The three modes are
          1) Automatic.  The scale set makes no guarantees as to the order of the VMs being brought down. Potentially, all VMs could be brought down at the same time, causing a service outage.
          2) Rolling.  The scale set rolls out the update in batches with an optional pause to minimize or eliminate service outage.
          3) Manual. When you update the scale set model,  no actions to existing VMs
  
1. **Exercise - Updating applications in virtual machine scale sets**

    You have previously installed the nginx web server across your virtual machine scale set. In this exercise, you wicode cloud- ll use a Custom Script Extension to roll out an update to the web app served by nginx. In this exercise, you will simply amend the message displayed by the web app, but you can use the same principle to perform more substantial updates.
  
      1. In the Azure Cloud shell, run the following command:

          ```azurecli
          az vmss extension set \
            --vmss-name webServerScaleSet \
            --name customScript \
            --resource-group <Sandox Resource Group> \
            --force-update \
            --version 2.0 \
            --publisher Microsoft.Azure.Extensions \
            --settings '{"commandToExecute": "echo This is the updated app installed on the VM Scale Set ! > /var/www/html/index.html"}'
          ```
  
      1. Navigate to the public address of the scale set load balancer in the web browser. Verify that the message. This is the updated app installed on the virtual machine scale set** appears

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    - Explained the features of virtual machine scale set.
    - Described how Scale Sets could be configured to autoscale manually, based upon a schedule, or via metrics
    - Configured an autoscale set based upon Metrics
    - Configured a Custom Script Agent to update an application across the scale set

    Clean up

    - Remove scale sets and all associated resources from the portal.

## Notes

Create virtual machine scale set - https://learn.microsoft.com/azure/virtual-machine-scale-sets/tutorial-create-and-manage-cli  
Install and upgrade an application on virtual machine scale set - https://learn.microsoft.com/azure/virtual-machine-scale-sets/tutorial-install-apps-cli  

We currently don't have scale sets enabled in the sandbox so the learner may have to use their own subscription. Design based upon scale sets becoming available in Azure.
