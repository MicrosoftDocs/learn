
The [Azure Application Gateway](/azure/application-gateway/overview) processes network traffic to web apps hosted on a pool of web servers. The processing performed by Azure Application Gateway includes load balancing HTTP traffic and inspecting traffic using a web application firewall. This type of routing is known as application layer (OSI layer 7) load balancing. Azure Application Gateway includes the following features:

- Support for the HTTP, HTTPS, HTTP/2, and WebSocket protocols.
- A web application firewall (WAF) to protect against web application vulnerabilities.
- End-to-end request encryption.
- Autoscaling to dynamically adjust capacity as your web traffic load change.
- Connection draining allowing graceful removal of backend pool members during planned service updates.
- Session stickiness to ensure client requests in the same session are routed to the same backend server. 
- Path and URL based routing. 

## How Azure Application Gateway works

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=f42d6621-a73d-4c37-91ee-545aa0adbbd0]

Let's review the [Azure Application Gateway components](/azure/application-gateway/application-gateway-components).

- **Front-end IP address**. Client requests are received through a front-end IP address. You can configure the Application Gateway to have a public IP address, a private IP address, or both. 
- **Listeners**. A listener is a logical entity that checks for incoming connection requests. A listener accepts a request if the protocol, port, hostname, and IP address match the listener's configuration. You must have at least one listener.
- **Request routing rules**. A request routing rule is a key component of an application gateway because it determines how to route traffic on the listener. The rule binds the listener, the backend server pool, and the backend HTTP settings. When a listener accepts a request, the request routing rule forwards the request to the backend or redirects it elsewhere. If the request is forwarded to the backend, the request routing rule defines which backend server pool to forward it to.
- **Backend pools**. A backend pool is a collection of web servers. Backend targets can include: a fixed set of virtual machines, a virtual machine scale-set, an app hosted by Azure App Services, or a collection of on-premises servers. The backend pool receives and processes requests. 
- **Health probes**. Health probes determine which servers are available for load-balancing in a backend pool. Servers are automatically added and removed from the backend pool based on their availability. 

> [!TIP]
> Learn more about Azure Application Gateway check out the [Introduction to Azure Application Gateway](/training/modules/intro-to-azure-application-gateway/) module.