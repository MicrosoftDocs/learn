As well as balancing requests from users to front-end servers, you can also use Azure Load Balancer to distribute traffic from front-end servers evenly between back-end servers.

In your healthcare organization, front-end servers call business logic that is hosted on a middle tier. You want to ensure that the middle tier is as scalable and resilient as the front end. You want to use a load balancer to distribute requests from the front-end servers evenly among the middle-tier servers. This way, you'll scale the middle-tier servers out to achieve the highest capacity possible. You'll also ensure that the middle-tier is resilient to failures because, when a server fails, the load balancer will automatically reroute traffic.

Here, you'll learn how to use load balancers to distribute internal traffic.

## Configure an internal load balancer

In the healthcare portal scenario, there is a web tier that handles requests from users, and connects to databases to retrieve data for the users. The database tier is also deployed on two virtual machines. To allow the front-end web portal to continue to serve client requests if a database server fails, you will set up an internal load balancer to distribute traffic to the database servers.

You can configure an internal load balancer in almost the same way as an external load balancer, but with these differences:

- When you create the load balancer, for the **Type** value, select **Internal**. When you choose this setting, the front-end IP address of the load balancer is not exposed to the internet.
- Assign a private IP address for the front end of the load balancer, not a public IP address.
- Place the load balancer in the protected virtual network that contains the virtual machines you want to handle the requests.

The internal load balancer should only be visible to the web tier. All the virtual machines hosting the databases are in one subnet so an internal load balancer can be used to distribute traffic to those virtual machines.

![Diagram of internal load balancer](../media/5-internal-load-balancer.svg)

## Choose distribution mode

In the healthcare portal, the application tier is stateless, so we don't need to use source IP affinity. Therefore, the default distribution mode of a five-tuple hash can be used. This mode offers the greatest scalability and resilience, as the load balancer will route traffic to any healthy server.
