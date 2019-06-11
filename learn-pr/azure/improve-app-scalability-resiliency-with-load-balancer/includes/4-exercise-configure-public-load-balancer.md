In the healthcare example, we want to load balance the client traffic, to provide a consistent response based on the health of the patient portal web servers. In order to setup the load balancer, we first need setup two VMs within an availability set to act as our healthcare portal web application.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Deploy the patient portal web application
Your first task is to deploy your patient portal application across two VMs within a single availability set

To save time, let's start by running a script to create this for us

- Create a VNET and network infrastructure for the VMs
- Create 2 VMs in this VNET

1. Run the following git clone command in the Cloud Shell to clone the repo that contains the source for our app, as well as our setup script from GitHub.

```bash
git clone https://github.com/GeekEffect/load-balance.git
```

2. Navigate into the repo folder locally by running the following cd command.

```bash
cd load-balance
```

3. As its name suggests, this will generate two VMs within a single availability set

```bash
bash create-high-availabilty-vm-with-sets.sh
```

The script takes about 2 minutes to run. When the script finishes. Observe that during deployment, all dependencies needed for your VM to run are automatically installed.

## Configure the load balancer

::: zone pivot="Portal"
## Portal section

1. Go to Azure portal Find Load Balancer and click Create

    ![Create a Load Balancer](../media/4-create-lb.png)

1. Enter the following:

    | Field | Information |
    | ----- | ----------- |
    | **Name** | Enter a unique Name (for example, Pub-LB-PatientsPortal) |
    | **Type** | Select **Public** |
    | **SKU** | Select **Standard** |
    | **Public IP address** | Select **create new** |
    | **Public IP address name** | Enter a unique name for the public IP (for example, Pub-LB-PatientsPortal-IP) |
    | **Assignment** | Choose **Public** |

   ![Enter Load Balancer Details](../media/4-create-details-lb.png)

1. Click "Review + create button"
1. After Validation is passed, click Create

### Add Backend pools

1. Go to Backend Pools and click Add

    ![Backend Pools Screenshot](../media/4-backend-pools.png)

1. On the Add Backend pool screen,enter the following:

    | Field | Information |
    | ----- | ----------- |
    | **Name** | Give a unique name to the backend pool (for example, bepool-http) |
    | **IP Version** | Choose **IPv4**
    | **Associated to** | Select **Availability set**
    | **Availability set** | Choose the existing **portalAvailabilitySet**

1. Click `+Add a target network IP configuration` button
1. Choose the first VM from the availability set - **webVM1**
1. Choose the first Network IP configuration - **ipconfig1**
1. Click `+Add a target network IP configuration` button again
1. Choose the second VM from the availability set - **webVM2**
1. Choose the second Network IP configuration - **ipconfig2**

    ![Add a new backend pool](../media/4-backend-pool-create.png)

1. Click OK

### Add Health probes

1. Go to Health probes
1. Click Add and enter the following:

    | Field | Information |
    | ----- | ----------- |
    | **Name** | A name for the probe (e.g. probe-http) |
    | **Protocol** | Select **TCP** |
    | **Port** | Enter port 80 (default) |
    | **Interval** | Enter 5 (default), this is the amount of time between the probes |
    | **Unhealthy Threshold** | Enter 2 (default), this is the number of consecutive probes failures that must occur before a virtual machine is considered unhealthy |

    ![Add a new health probe](../media/4-new-health-probe.png)

1. Click OK

### Add Load balancer rule

1. Go to Load Balancing Rules and click Add, enter the following:

    | Field | Information |
    | ----- | ----------- |
    | **Name** | A name for Load Balancing Rule (e.g. lbrule-http)
    | **IP Version** | Choose **IPv4**
    | **Frontend IP address** | Choose the existing public IP of load balancer as Frontend IP address |
    | **Protocol** | Choose **TCP** |
    | **Port** | 80 (default) |
    | **Backend port** | 80 (default) |
    | **Backend pool** | Select the existing backend pool |
    | **Health probe** | Select the existing health probe |
    | **Session persistence** | Choose **None**
    | **Idle timeout** | Select 4 (default).  This is the time to keep a TCP or HTTP connection open without relying on clients to send keep-alive messages |
    | **Floating IP** | Choose **Disabled** (default)

    ![Add a new load balancer rule](../media/4-new-lb-rule.png)

1. Click OK to complete the load balancer configuration.

::: zone-end
::: zone pivot="powershell"
## Powershell section

1. Firstly, you will need to create a new Public IP address

    ```Powershell
    $publicIP = New-AzPublicIpAddress `
      -ResourceGroupName "myResourceGroupLB" `
      -Location "EastUS" `
      -AllocationMethod "Static" `
      -Name "myPublicIP"
    ```

1. Next, you will create a front-end IP with ```New-AzLoadBalancerFrontendIpConfig```. The following example creates a frontend IP configuration named myFrontEnd and attaches the myPublicIP address:

    ```Powershell
    $frontendIP = New-AzLoadBalancerFrontendIpConfig `
      -Name "myFrontEnd" `
      -PublicIpAddress $publicIP
    ```

1. You will now create create a back-end address pool with ```New-AzLoadBalancerBackendAddressPoolConfig```. The VMs attach to this back-end pool in the remaining steps. The following example creates a back-end address pool named myBackEndPool:

    ```Powershell
    $backendPool = New-AzLoadBalancerBackendAddressPoolConfig -Name "myBackEndPool"
    ```

1. To allow the load balancer to monitor the status of your healthcare portal, you will now create a health probe. The health probe dynamically adds or removes VMs from the load balancer rotation based on their response to health checks

    ```Powershell
    $probe = New-AzLoadBalancerProbeConfig `
      -Name "myHealthProbe" `
      -RequestPath healthcheck2.aspx `
      -Protocol http `
      -Port 80 `
      -IntervalInSeconds 4 `
      -ProbeCount 2
    ```

1. You will now need a load balancer rule, which is used to define how traffic is distributed to the VMs. You define the frontend IP configuration for the incoming traffic and the backend IP pool to receive the traffic, along with the required source and destination port. To make sure only healthy VMs receive traffic, you also define the health probe to use.

    ```Powershell
    $lbrule = New-AzLoadBalancerRuleConfig `
      -Name "myLoadBalancerRule" `
      -FrontendIpConfiguration $frontendIP `
      -BackendAddressPool $backendPool `
      -Protocol Tcp `
      -FrontendPort 80 `
      -BackendPort 80 `
      -Probe $probe
    ```

1. Create the Basic Load Balancer with ```New-AzLoadBalancer```

    ```Powershell
    $lb = New-AzLoadBalancer `
      -ResourceGroupName 'myResourceGroupLB' `
      -Name 'MyLoadBalancer' `
      -Location 'eastus' `
      -FrontendIpConfiguration $frontendIP `
      -BackendAddressPool $backendPool `
      -Probe $probe `
      -LoadBalancingRule $lbrule
    ```

1. Finally, run the following cmd to get the public IP address of the load balancer, you will need this for the next section

    ```Powershell
    Get-AzPublicIPAddress `
      -ResourceGroupName "myResourceGroupLB" `
      -Name "myPublicIP" | select IpAddress
    ```

::: zone-end

## Test the load balancer configuration

You will now test the load balancer setup to show how the load balancer can handle availability and health issues dynamically
 
1. Open Microsoft Edge on your machine.
1. Browse to [http://LoadBalancerIP](http://LoadBalancerIP)
1. You will see that the response will be returned from one of the virtual machines
1. Try Force Refresh using Ctrl+F5 few times to see that response will be returned from both virtual machines randomly
1. Stop the webVM1 server and force a refresh of the webpage, all traffic will be returned from webVM2
