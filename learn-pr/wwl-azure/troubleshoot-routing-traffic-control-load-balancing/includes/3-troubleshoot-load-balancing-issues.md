Azure offers a range of load-balancing solutions. Traffic Manager provides high availability and quick response times by using DNS to redirect client requests to the most appropriate endpoint for any protocol. Front Door provides high availability and quick response times by using proxies for HTTP requests. Traffic Manager and Front Door load balance at the Network and Transport layers.

Application Gateway loads balances at the Application layer rather than the Network and Transport layers. This means you can route traffic based on the incoming URL. For example, you could route traffic for a URL containing /media to a specific set of servers.

Load Balancer works at the Network and Transport layers to provide internal and external load balancing for both inbound and outbound traffic using any protocol.

Each load-balancing solution requires different troubleshooting steps.

## Determine the status of Azure Traffic Manager

To test whether your Traffic Manager settings are correct, you need to have multiple clients in multiple locations. You can then verify DNS resolution for failover using the following steps:

- Flush your DNS cache by running ipconfig /flushdns.

- Run nslookup for your company’s domain to verify that it resolves to your primary endpoint.

- Take down your primary endpoint, wait for the Time-to-Live (TTL) time of your Traffic Manager profile, plus an additional two minutes.

- Flush your DNS cache by running ipconfig /flushdns.

- Repeat the nslookup request and verify that it resolves to your secondary endpoint.

- Repeat these steps for each endpoint.

You can also test for weighted traffic routing by leaving all endpoints up and repeatedly flushing the cache and running nslookup to verify that traffic is cycling through each endpoint.

You can test for performance routing by connecting from different geographic locations and testing whether the appropriate endpoint is returned by nslookup.

For more information, see [What is Traffic Manager?](/azure/traffic-manager/traffic-manager-overview)

## Determine whether virtual machines in a load-balanced cluster are healthy

Azure Load Balancer uses health probes to detect if an instance is healthy. If the health probe cannot make a connection, the load balancer will stop sending connections to that instance.

What if virtual machines (VMs) in a load balancer set are not responding to health probes? There are a number of possible reasons:

- The back-end pool VM is not in a healthy state.
  - To test this, try sending a Ping request from another VM in the pool. The VM must be able to respond to requests to be part of the pool.

- The back-end pool VM does not allow connections from the probe port.
  - From the back-end VM, run netstat -an and check that the correct port is listed as LISTENING. You must configure the back-end VM and/or the load balancer to use the same port.

- A firewall or NSG does not allow connections from the probe port.
  - If the back-end VM and load balancer are using the same port, verify that this is not blocked by a firewall or NSG.

- The load balancer is misconfigured.  
  - If the previous tests all succeeded, analyze the network for incoming and outgoing packets from multiple VMs in the load balancer set, to try to isolate the issue.

For more information, see [Troubleshoot Azure Load Balancer health probe status](/azure/load-balancer/load-balancer-troubleshoot-health-probe-status).

## Examine load balancer rules

Load balancer rules define how traffic is distributed to the load balancer set. This could mean that a specific VM only receives certain traffic based on its incoming IP address, for example.

Review load balancer rules if traffic is not behaving as expected.

For more information, see [Manage rules for Azure Load Balancer using the Azure portal](/azure/load-balancer/manage-rules-how-to).

## Determine how resources are being allocated based on the load balancer configuration

Load balancers are typically used to evenly distribute traffic. Here are two reasons why the distribution of traffic from the load balancer is uneven:

- Session persistence is turned on.
  - Session persistence will cause each client and server pair to be persisted so load balancing won’t perform as expected.

- Clients are behind a proxy server.  
  - A proxy server can cause multiple clients to appear as a single client, so load balancing won’t perform as expected.

If a VM in the load-balanced pool appears healthy, but is not responding to requests, there could be a number of reasons:

- The back-end VM might not be listening on the correct port, or the port may not be open.

- A network security group might be blocking the port.

- An application on the back-end VM is trying to access another application on the same network interface. This is unsupported.

- A back-end VM is trying to access resources through the load balancer. This is unsupported.

For more information, see [Troubleshoot Azure Load Balancer back-end traffic responses](/azure/load-balancer/load-balancer-troubleshoot-backend-traffic).

## Troubleshoot port exhaustion issues

When a load balancer is used for external connections, you should be aware of port exhaustion. There are 64,000 ports available, but each connection uses eight ports when a load balancer is in use. Therefore, if there are many back-end instances, it is possible to exhaust the available ports.

For more information, see [Troubleshooting outbound connections failures](/azure/load-balancer/troubleshoot-outbound-connection).

## Troubleshoot Azure Front Door

If you’re using Azure Front Door for load balancing and wish to troubleshoot common routing problems, you should first request that Front Door returns additional debugging HTTP response headers.

For more information, see [Protocol support for HTTP headers in Azure Front Door](/azure/frontdoor/front-door-http-headers-protocol).

When you have the HTTP group response headers, there are a number of responses from Azure Front Door you could use for debugging:

- A 503 response after a few seconds means that regular requests go to your back end without going through Azure Front Door. To resolve this issue, configure the origin response timeouts for the endpoint and extend the default timeout.

  :::image type="content" source="../media/4-endpoint-timeout.png" alt-text="Endpoint default timeout settings":::

- You’re receiving 503 responses from the Azure Front Door, but only for HTTPS requests. Reasons for this could be:

  - The back-end pool is an IP address.

  - The back-end server is returning a certificate that doesn’t match the fully qualified domain name of the Azure Front Door back-end pool.

  - The back-end pool is an Azure Web app server.

- You’re receiving 400 status codes when requests are sent to a custom domain.
  - The problem occurs because you haven’t created a routing rule for the custom domain when it was added as the front-end host.

- You’re receiving 411 status codes from the front-end host.
  - These status codes are generated when your HTTP request is not fully RFC compliant.

For more information, see [Troubleshoot Azure Front Door common issues](/azure/frontdoor/troubleshoot-issues).

## Troubleshoot Azure Application Gateway

Application Gateway probes back-end servers to check their health status. If these servers do not successfully respond, Application Gateway marks them as unresponsive and stops sending requests to them. Application Gateway resumes sending requests when the server starts responding successfully.

For more information, see [Troubleshoot back-end health issues in Application Gateway](/azure/application-gateway/application-gateway-backend-health-troubleshooting).

## Troubleshoot Azure Load Balancer

There are several troubleshooting steps to consider when you use Azure Load Balancer:

- Started internal load balancers are secured by default, but basic internal load balancers allow connections to the internet through hidden IP addresses. This is not recommended for production workloads—Network Gateway is the recommended solution for outbound traffic.

- When you have a health probe, the back-end port can’t be modified for load balancing. To resolve this issue, remove the health probe, reconfigure the port, and then add the health probe again.

- If a VM is removed from a back-end pool but is still receiving network traffic, this could be due to storage, DNS, or other Azure functions.

For more information, see [Troubleshoot Azure Load Balancer](/azure/load-balancer/load-balancer-troubleshoot-backend-traffic).

## Troubleshoot Traffic Manager profile issues

Azure Traffic Manager uses six traffic routing methods. These are Priority, Weighted, Performance, Geographic, Multivalue, and Subnet. If you select the incorrect traffic routing method, the expected behavior might not be achieved. Traffic may be going towards a primary service endpoint for all traffic because you are using Priority, but you want it to go to the closest endpoint—for example, by using Performance.

For more information, see [Traffic Manager routing methods](/azure/traffic-manager/traffic-manager-routing-methods).

## Troubleshoot latency issues

For latency issues in your load-balanced network, you should test in the same way you would for any virtual machine network latency. You can use common connectivity tools such as Ping, but more specialist third-party tools are available to provide more information. To test latency issues, it’s a good idea to use two virtual machines, one as the sender and the other as the receiver. This allows you to test two-way communication between the virtual machines and through the load balancer.

For more information, see [Test VM network latency](/azure/virtual-network/virtual-network-test-latency).

