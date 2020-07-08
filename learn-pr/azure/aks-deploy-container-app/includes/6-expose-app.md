[//]: # (This first paragraph will pull your reader into the unit. Try and relate the intro to the scenario from the introduction unit.)

[//]: # (Think about what the student wants to know or do. This unit is kind of interesting. Typically, allow of what you're going to talk about isn't needed on a VM. Strictly speaking, that isn't completely true since you'll configure VNets, firewalls, and load balancers. Rewrite the following to explain why there are objects responsible for redirecting the traffic inside the cluster to the correct apps. Why isn't the app exposed, to begin with?)

To expose our application to the world, we must have a basic knowledge of two workloads we'll be creating: services and ingresses. Both are responsible for redirecting the traffic inside the cluster to the correct apps.

## Networks in Kubernetes

[//]: # (Do I need to know about all the info in this paragraph to understand networks? I would simplify the next in this way:)

Containers are temporary. A container's configuration and data the data inside of it isn't persistent between executions. Once you delete a container, all information is gone unless it's configured to use a volume. 

The same applies to the container's network configuration. 

Deployments aren't considered a physical workload since they're only logical groups of pods, so we don't have to worry about their networking rules or IP addresses. Their pods, however, have an internal IP assigned to each of them when created. Like all the data, this IP is lost when the pod is destroyed. Internet is based on persistent IP addresses, so how can we expose an ever-changing pod IP to the network? The answer is **services**.

### Kubernetes services

Services are workloads that abstract the IP address for networked workloads, like pods. Essentially, a service uses the same `selector` key as deployments to select and group resources with the required labels into one single IP, acting somewhat as a load balancer and redirecting the traffic to the specific ports. Services handle the port-forwarding rules to their selected pods. They receive incoming packages one port and forward them onto an internal one.

:::image type="content" source="../media/6-1-service-diagram.png" alt-text="Services diagram":::

Services can be of several types. Each type changes the behavior of the applications selected by the service:

- **ClusterIP**: Exposes the applications internally only, acting as a port-forwarder. Choosing this type makes the service available within the cluster. Default value when omitted
- **NodePort**: Exposes the service externally, assigning each node a static port that responds to that service. When accessed through `nodeIp:port`, the node will automatically redirect the request to an internal service of the `clusterIP` type. This service will then forward the request on to the applications.
- **LoadBalancer**: Exposes the service externally using Azure's load-balancing solution. When created, this resource will spin up a Load Balancer resource within your Azure subscription. Also, this type will automatically create a `nodePort` service to which the Load Balancer's traffic will be redirected, and a `clusterIP` service to forward internally.
- **ExternalName**: Maps the service using a DNS resolution through a CNAME record. With this type, no proxying is set up.

We'll use the `clusterIP` type because we'll be exposing the application externally through an __Ingress__.

[//]: # (How about discussing the structure of a Service manifest file, Service and Ingress are completely new.)

### Ingresses

By default, all incoming traffic to a Kubernetes cluster is rejected. To allow traffic into the cluster, we need to create _ingress rules_. These rules are manipulated through a resource named Ingress.

Ingresses are like doors in a huge wall. They allow some traffic in based on a set of rules. Think of it as a firewall solution. An Ingress resource is required when exposing an application externally using a DNS name – like we want to do by allowing people to access Contoso's website through `http://contoso.com`.

:::image type="content" source="../media/6-2-ingress-diagram.png" alt-text="Ingress diagram":::

Using managed services like AKS makes it a lot easier, because with the :::no-loc text="HTTP Application Routing"::: add on we create a resource called __Ingress Controller__.

Ingress controllers are reverse proxies that listen when you create an Ingress workload in the cluster. When you create a new Ingress, the add-on gets its name and figures where the DNS is pointing to by reading the manifest file. Then it automatically adds a new entry in the internal webserver's configuration that allows this DNS to pass through the cluster's "wall".

In AKS, the Ingress Controller is linked to a _DNS Zone_ resource in your Azure subscription – which was automatically created when we created our cluster. This link makes possible for the cluster to automatically create a zone record pointing the DNS name to the IP address and port of the exposed application.

[//]: # (How about discussing the structure of a Ingress manifest file, Service and Ingress are completely new.)