You need to set up an environment, which can horizontally scale when demand and load increases. By the end of this unit, you will be able to:

- Understand what tools to use when creating a virtual machine scale set.
- Understand virtual machine scale set autoscale approaches.
- Understand virtual machine scale set autoscale rules.
- Understand how to configure autoscale rules on a virtual machine scale set. 



## Create virtual machine scale sets using different tools

You can use different tools to configure virtual machine scale sets.  You can use the Azure Portal, or through Azure Resource Manager templates, PowerShell, Azure CLI, API/SDK.  Below are a few example showing how to create scale sets using some of these tools. 

You can create a scale set using Azure CLI as shown below: 

```powershell

az vmss create \
  --resource-group yourResourceGroup \
  --name yourScaleSet \
  --image UbuntuLTS \
  --upgrade-policy-mode automatic \
  --admin-username azureuser \
  --generate-ssh-keys
```



Below is an example showing how we can create a scale set using PowerShell: 

```powershell
New-AzVmss `
  -ResourceGroupName "yourResourceGroup" `
  -Location "WestUS" `
  -VMScaleSetName "yourScaleSet" `
  -VirtualNetworkName "yourVnet" `
  -SubnetName "yourSubnet" `
  -PublicIpAddressName "yourPublicIPAddress" `
  -LoadBalancerName "yourLoadBalancer" `
  -UpgradePolicyMode "Automatic"
```



Below is an example of a scale set resource that someone would put into an Azure Resource Manager template for deployment. Some properties have been removed to keep the template short. 

```json
{
  "type": "Microsoft.Compute/virtualMachineScaleSets",
  "name": "yourScaleSet",
  "location": "West US",
  "apiVersion": "2017-12-01",
  "sku": {
    "name": "Standard_A1",
    "capacity": "2"
  },
  "properties": {
    "upgradePolicy": {
      "mode": "Automatic"
    },
    "virtualMachineProfile": {
      "storageProfile": {
        "osDisk": {
          "caching": "ReadWrite",
          "createOption": "FromImage"
        },
        "imageReference":  {
          "publisher": "Canonical",
          "offer": "UbuntuServer",
          "sku": "16.04-LTS",
          "version": "latest"
        }
      },
      "osProfile": {
        "computerNamePrefix": "yourvmss",
        "adminUsername": "azureuser",
        "adminPassword": "aStrongPassword+"
      }
    }
  }
}
```





## Autoscale virtual machine scale sets using rules

There are three different ways to configure how autoscaling is triggered in an Azure virtual machine scale set: 

- Manually - by increasing or decreasing the Azure instance count.
- Schedule based - if you know you will have an increased workload on a specified date/time window you can proactively plan for that.
- Metric-based - using a variety of resource metrics, you can determine how and when to scale out your virtual machine scale set, and how and when to return to your baseline.

A scale set will have a series of rules, defaults, and limits. It is essential to set limits so you can define the outer parameters for the size of your scale set. This includes the minimum number of nodes in a scale set, the maximum, and the default.

An autoscale rule defines the criteria for horizontally scaling your application; for example, increase the instance count by one when CPU utilization crosses a predefined threshold for example, 70%.

Creating a scale rule brings together a set of conditions, for example: 

- Time aggregation (Average, Minimum, Maximum, Last, Count).

- Metric name (CPU, Memory, etc.).

- Time grain statistic - defines how the collected metrics in each time grain should be aggregated for analysis.    

- Operator - the logic condition, for example, greater than.

- Threshold - the value the condition has to in this case exceed (70).

- Duration - of importance as it takes time to provision and scales down the virtual machine so you would want the system to have observed this increased period of the load over a certain amount of time (10 minutes for example) before scaling up another instance into the scale set.

- Cool down period - Amount of time to wait before attempting to perform another scaling operation.

  

Below is an example of a scale rule in the Azure Portal: 



![Example of a scale rule](4-example-scale-rule.png)



Here is an example of a scale rule in Azure PowerShell: 

```powershell
$myRuleScaleOut = New-AzureRmAutoscaleRule `
  -MetricName "Percentage CPU" `
  -MetricResourceId /subscriptions/$yourSubscriptionId/resourceGroups/$yourResourceGroup/providers/Microsoft.Compute/virtualMachineScaleSets/$yourScaleSet `
  -TimeGrain 00:01:00 `
  -MetricStatistic "Average" `
  -TimeWindow 00:05:00 `
  -Operator "GreaterThan" `
  -Threshold 80 `
  -ScaleActionDirection "Increase" `
  –ScaleActionScaleType "ChangeCount" `
  -ScaleActionValue 3 `
  -ScaleActionCooldown 00:05:00
```

As a default, a scale-in rule is not created. For every scale set, at least one scale-in rule should be set. 



