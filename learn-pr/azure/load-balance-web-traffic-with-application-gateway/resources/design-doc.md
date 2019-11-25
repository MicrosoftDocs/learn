# Module Design

## Title

Load balance HTTP applications with Application Gateway

## Role(s)

- Solution architect

## Level

- Intermediate

## Product(s)

- Azure
- Azure portal
- Azure Application Gateway
- Azure virtual machines

## Prerequisites

- Knowledge of basic networking concepts (subnets, IP addressing, etc.)
- Familiarity with Azure virtual machines
- Familiarity with Azure virtual networking

## Summary

Improve application resilience by distributing load across multiple servers, and removing distribution to failed servers.

## Learning objectives

1. Create an Application Gateway and configure load balancing
2. Identify the load balancing capabilities of Application Gateway
3. Identify the differences between Application Gateway and Azure Load Balancer

## Chunk your content into subtasks

Identify the subtasks of *Load balance HTTP applications with Application Gateway*

| Subtask             | What part of the introduction scenario does this subtask satisfy?              | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|----------------------|-----------------------------------------------------------------------------|----------------------------------------------------------|-----------------------------------------------|--|
| Describe Application Gateway | Assess the capabilities of Application Gateway as an environment for load balancing requests to web servers |  Knowledge check | 2, 3 |Yes
| Create web servers        | Create and configure virtual machines that run the web site for the motor vehicle department                                    | Exercise                                                 | 1                                            |Yes |
| Create and configure an Application Gateway      | Create an infrastructure to distribute the load across multiple web servers                                                        | Exercise                                                 | 1                                             |Yes |
| Test the Application Gateway | Send requests to the web app running on the pool of web servers through the App Gateway         | Exercise                                                 | 1                                           |Yes. |

## Outline the units

1. **Introduction**

    Provide a scenario of a real-world job-task that shows how the technology is used in practice (from the module proposal):

    *The web site for a motor vehicle department has been running on a single server and has suffered multiple outages due to server failures. This has resulted in frustrated customers who are trying to register their vehicles at the end of the month before their registration expires. The department would like to improve resiliency by adding multiple web servers to their site and distribute load across them.*

    In this module, you will run the motor vehicle department web app on a pair of web servers, and then configure Application Gateway to distribute the load between these servers.

2. **How Application Gateway works**

    List the content that will enable the learner to *Describe Application Gateway*:

    - Provide an overview of Application Gateway, including its purpose and key components. See [How Application Gateway Works](https://docs.microsoft.com/azure/application-gateway/how-application-gateway-works) and [Application gateway components](https://docs.microsoft.com/azure/application-gateway/application-gateway-components).

    - Video\Animation: Show how an incoming request from a client is routed through an Application Gateway to a selected web server. Include load balancing and content-based routing in the animation.

    - Compare the features of App Gateway for load balancing requests to those available in Azure Load Balancer:

      - URL routing at OSI Layer 7 rather than Layer 4, including path-based redirection,
      - Web Application Firewall,
      - HTTP/2,
      - WebSocket support,
      - Multi-tenant support,
      - Multiple site hosting (using the same App Gateway to act as a load balancer for different web sites)

    Knowledge check:

    ***Note**: The purpose of these questions if to test the objectives *Identify the load balancing capabilities of Application Gateway*, and *Identify the differences between Application Gateway and Azure Load Balance*?*

      - What is OSI Layer 7 routing? (*multiple-choice question*)
      - How does Appliaction Gateway direct requests to a VM (make sure students know about Backend Pools, HTTP Listeners and Rules)? (*get students to map the flow through the various components of App Gateway, starting with an incoming request and finishing at the web server handling the request*)
      - What features does the Web Application Firewall provide? (*get students to select items from a list. See [Features](https://docs.microsoft.com/azure/application-gateway/application-gateway-components) for source material*)

3. **Exercise - Create virtual machines for the web servers**
    
List the content that will enable the learner to *Create web servers*:

    - Recap that Application Gateway directs trafic to pools of web servers. Each server in a pool should the same functionality and run the same web app. They should also be configured identically.
    - ***Note:** Briefly mention that virtual machine scale sets could be used for the web server pool VMs, but for simplicity this lab creates two identical VMs manually.*

    - You can implement the web server using any appropriate technology such as Windows Server and IIS, or Linux and Apache. This helps to preserve any existing investment made for an existing web app that you are moving to the application gateway.

    List the steps which apply the learning content from previous unit:

    **Note:** This exercise creates Linux VMs to make it easier to script from the Azure Cloud Shell.

    1. Start the Azure Cloud Shell (https://shell.azure.com) and sign in.

    1. Create a resource group for the web server VMs and Application Gateway. Use your nearest location:

    ```CLI
    az group create --name gatewayrg --location <location>
    ```

    1. Create a VNET and subnet for the web server VMs:

    ```CLI
    az network vnet create --resource-group gatewayrg --name vehicleappvnet --address-prefix 10.0.0.0/16 --subnet-name webserversubnet --subnet-prefix 10.0.1.0/24
    ```

    1. Create VMs for the web servers (Note: These commands run asynchronously to allow both VMs to be created concurrently):

    ```CLI
    az vm create --resource-group gatewayrg --name webservervm1 --image Canonical:UbuntuServer:16.04.0-LTS:16.04.201610200 --admin-username azureuser --generate-ssh-keys --vnet-name vehicleappvnet --subnet webserversubnet --public-ip-address "" --nsg "" --no-wait

    az vm create --resource-group gatewayrg --name webservervm2 --image Canonical:UbuntuServer:16.04.0-LTS:16.04.201610200 --admin-username azureuser --generate-ssh-keys --vnet-name vehicleappvnet --subnet webserversubnet --public-ip-address "" --nsg "" --no-wait
    ```

    1. Wait for both VMs to be built (run these commands every 30 seconds or so, until the provisioning state for both VMs is returned as "Succeeded"):

    ```CLI
    az vm show --resource-group gatewayrg --name webservervm1 --query provisioningState

    az vm show --resource-group gatewayrg --name webservervm2 --query provisioningState
    ```

    1. Install and configure the vehical app on webservervm1 (Note: replace https://github.com/<vehicleapp-repo> with the URL of the GIT repo holding the source code for the vehicle app):

    ```CLI
    az vm run-command invoke --resource-group gatewayrg --name webservervm1 --command-id RunShellScript --scripts '

    # Install dotnet core
    wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    sudo apt-get -y update
    sudo apt-get -y install dotnet-sdk-2.2
    export DOTNET_CLI_HOME=/home/azureuser

    # Get the code for the sample app
    cd /home/azureuser
    git clone https://github.com/<vehicleapp-repo> vehicleapp

    # Build and publish the web app
    cd /home/azureuser/vehicleapp
    dotnet build
    dotnet publish -o published -c Release
    sudo cp -r /home/azureuser/vehicleapp/vehicles/published /opt/vehicleapp

    # Configure the web service
    cd /home/azureuser
    cat << EOD > vehicleapp.service 
    [Unit]
    Description=Vehicle Web App

    [Service]
    WorkingDirectory=/opt/vehicleapp
    ExecStart=/usr/bin/dotnet /opt/vehicleapp/vehicles.dll --server.urls "http://*:80"
    Restart=always
    RestartSec=10

    [Install]
    WantedBy=multi-user.target
    EOD

    sudo cp vehicleapp.service /etc/systemd/system/vehicleapp.service
    sudo systemctl enable vehicleapp.service
    sudo systemctl start vehicleapp.service
    sudo systemctl status vehicleapp.service
    '
    ```

    1. Configure the vehicle app on the webservervm2:

    ```CLI
    az vm run-command invoke --resource-group gatewayrg --name webservervm2 --command-id RunShellScript --scripts '

    # Install dotnet core
    wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    sudo apt-get -y update
    sudo apt-get -y install dotnet-sdk-2.2
    export DOTNET_CLI_HOME=/home/azureuser

    # Get the code for the sample app
    cd /home/azureuser
    git clone https://github.com/<vehicleapp-repo> vehicleapp

    # Build and publish the web app
    cd /home/azureuser/vehicleapp
    dotnet build
    dotnet publish -o published -c Release
    sudo cp -r /home/azureuser/vehicleapp/vehicles/published /opt/vehicleapp

    # Configure the web service
    cd /home/azureuser
    cat << EOD > vehicleapp.service 
    [Unit]
    Description=Vehicle Web App

    [Service]
    WorkingDirectory=/opt/vehicleapp
    ExecStart=/usr/bin/dotnet /opt/vehicleapp/vehicles.dll --server.urls "http://*:80"
    Restart=always
    RestartSec=10

    [Install]
    WantedBy=multi-user.target
    EOD

    sudo cp vehicleapp.service /etc/systemd/system/vehicleapp.service
    sudo systemctl enable vehicleapp.service
    sudo systemctl start vehicleapp.service
    sudo systemctl status vehicleapp.service
    '
    ```

4. **Create and configure an Application Gateway**

    List the content that will enable the learner to *Create and configure an Application Gateway*:

    ***Note:** Add a graphic to help illustrate the items that are created by this unit.*

    - Highlight that Application Gateway requires a secure virtual network in which to operate. Explain the requirements for a subnet specifically for the App Gateway.
    **Note:** From [Frequently asked questions for Application Gateway](https://docs.microsoft.com/azure/application-gateway/application-gateway-faq)
    *Application Gateway consumes one private IP address per instance, plus another private IP address if a private frontend IP configuration is configured. Also, Azure reserves the first four and last IP address in each subnet for internal usage. For example, if an application gateway is set to three instances and no private frontend IP, then a /29 subnet size or greater is needed. In this case, the application gateway uses three IP addresses. If you have three instances and an IP address for the private frontend IP configuration, then a /28 subnet size or greater is needed as four IP addresses are required.*

    - Animation: How traffic is directed towards a specific web server in a backend pool from a listener by using a rule, including:
      - How the application gateway references web servers by using backend pools.
      - How the application gateway accepts incoming requests from clients using a listener.
      - How the application gateway directs traffic received using a listener to a backend pool by using a rule
    - Cover the following points:
      - Creating a virtual network and subnet with the appropriate address space for an Application Gateway.
      - Creating an Application Gateway. Summarize the decisions you need to make. Specifically, highlight the following points:
        - Selecting the tier (Standard, Standard V2, WAF, WAF V2). Briefly list the features of each tier and why you might use them.
        - Specifying the capacity type (Autoscale, Manual, and the number of scale units). Emphasize that the capacity refers to the number of instances of Application Gateway, **not** the size of the backend pools.
        - Specifying the availability zone.
        **Note:** For an overview of scaling and availability with Application Gateway, see [Autoscaling and Zone-redundant Application Gateway](https://docs.microsoft.com/azure/application-gateway/application-gateway-autoscaling-zone-redundant)
        - Deciding whether to expose the Application Gateway to the public, or keep it private inside an organization/application-specific VNET.
        - Selecting the protocol (HTTP/HTTPS) and port to listen on for incoming requests
        - Supporting the HTTP2 protocol
        - What level of Web application firewall to use (if any)
      - Describe how to configure backend pools, listeners, and rules.
      - Explain how to configure cookie-based affinity and connection draining by modifying the HTTP settings of an Application Gateway
  
5. **Exercise - Create and configure an Application Gateway**

    List the steps which apply the learning content from previous unit:
    ***Note**: Use the CLI from the Azure Cloud Shell (bash) rather than the portal, as outlined in the steps below*

    1. Create a subnet for the Application Gateway:

    ```CLI
    az network vnet subnet create --resource-group gatewayrg --vnet-name vehicleappvnet  --name appgatewaysubnet --address-prefixes 10.0.0.0/24
    ```

    1. Create a public IP address and DNS label for the Application Gateway:

    ```CLI
    az network public-ip create --resource-group gatewayrg --name appgwipaddr --sku Standard --dns-name <your initials or name>vehicleapp
    ```

    1. Find the private IP addresses of the web server VMs, webservervm1 and webservervm2:

    ```CLI
    az vm list-ip-addresses --resource-group gatewayrg --name webservervm1

    az vm list-ip-addresses --resource-group gatewayrg --name webservervm2
    ```

    1. Create the Application Gateway with a backend pool container the IP addresses of the web servers VMs, a listener that listens to port 80 for incoming requests to the Application Gateway, and a rule that routes (and load balances) these requests to the web servers in the backend pool:

    ```CLI
    az network application-gateway create --resource-group gatewayrg --name vehicleappgateway --sku WAF_v2 --capacity 2 --vnet-name vehicleappvnet --subnet appgatewaysubnet --public-ip-address appgwipaddr --http-settings-protocol Http --http2 disabled --routing-rule-type Basic --servers <IP address of webservervm1> <IP address of webservervm2>
    ```

    1. Display the backend pool configuration for the Application Gateway. Verify that the Application Gateway contains a backend pool with the addresses of the web servers:

    ```CLI
    az network application-gateway show --resource-group gatewayrg --name vehicleappgateway --query backendAddressPools
    ```

   1. Display the listener configuration for the Application Gateway. Verify that the Application Gateway contains a listener named appGatewayListener that waits for incoming client requests:

    ```CLI
    az network application-gateway show --resource-group gatewayrg --name vehicleappgateway --query httpListeners
    ```

    1. Display the HTTP settings for the Application Gateway. Verify that the Application Gateway is listening on port 80 for incoming client requests:

    ```CLI
    az network application-gateway show --resource-group gatewayrg --name vehicleappgateway --query frontendPorts[0].port
    ```

    1. Display the routing rules for the Application Gateway. Verify that the Application Gateway contains a routing rule named rule1 that directs traffic receieved on the appGatewayListener HTTP listener to the appGatewayBackendPool:

    ```CLI
    az network application-gateway show --resource-group gatewayrg --name vehicleappgateway --query requestRoutingRules
    ```

6. **Exercise - Test the Application Gateway**

    List the steps that will enable the learner to *Test the Application Gateway*:

    1. Find the fully qualified domain name of the Application Gateway IP address:

    ```CLI
    az network public-ip show --resource-group gatewayrg --name appgwipaddr --query dnsSettings.fqdn
    ```

    1. Using a web browser, navigate to http://*\<fqdn of app gateway\>*.
    1. Verify that the Home page of the web app appears. Note the name of the selected server to which the session has been connected.
    1. Click **Register** to register a vehicle.
    1. Click the **Refresh** button in the address bar of the web browser. Notice that the session should now be connected to a different server.
    1. Click the the **Refresh** button again, and repeat several times. Observe how the sessions are allocated to servers on a round-robin basis (the server name should oscillate between the two web servers).
    1. In the Azure cloud shell, run the following command to stop and deallocate the VM for webservervm1:

    ```CLI
    az vm deallocate --resource-group gatewayrg --name webservervm1
    ```

    1. Return to the application in the web browser and click **Refresh** several times. Notice that the web browser now only connects to webservervm2. Note that it may take a little time to refresh the view each time; this is because the Application Gateway waits for a reponse from the stopped server, and eventually times out before trying the working server. You can add a health probe to the Application Gateway for each server to reduce this delay.

    1. Restart the webservervm1 instance:

    ```CLI
    az vm start --resource-group gatewayrg --name webservervm1
    ```

    1. Return to the web application and click **Refresh** several times. You should see that the requests are now distributed across both web servers again.

7. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    - Created a virtual network in which to run the Application Gateway and web servers.
    - Created virtual machines acting as web servers running instances of the web app.
    - Created an Application Gateway with a backend pool consisting of virtual machine instances.
    - Tested the Application Gateway to ensure that requests are distributed evenly across the web servers, and that if a web server stops traffic is only directed to  working web servers.