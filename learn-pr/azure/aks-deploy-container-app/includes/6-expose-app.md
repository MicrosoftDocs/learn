To expose our application to the world, it's necessary we have a basic knowledge of two workloads we'll be creating: services and ingresses. Both are responsible to redirect the traffic inside the cluster to the correct apps.

## Networks in Kubernetes

Pods are containers, as we saw in the previous exercise. Deployments are wraps around pods to provide intelligence for them to scale out. By definition, containers are ephemeral, which means the data inside them isn't persistent between executions. Once you delete a container, all data inside it's gone (unless it's hooked onto a volume).

The same happens with the network. Deployments aren't considered a physical workload since they're only logical groups of pods, so we don't have to worry about their networking rules or IP addresses. Their pods, however, have an internal IP assigned to each of them when created. Like all the data, this IP is lost when the pod is destroyed. Internet is based on persistent IP addresses, so how can we expose an ever-changing pod IP to the network? The answer is __services__.

### Kubernetes services

Services are workloads that abstract the IP address for networked workloads, like pods. Essentially, a service uses the same `selector` key as deployments to select and group resources with the required labels into one single IP, acting somewhat as a load balancer and redirecting the traffic to the specific ports.

Basically, services handle the port-forwarding rules to their selected pods. receiving incoming packages in one port and forward them to another internal one.

Services can be of several types, each type changes the behavior of the applications selected by the service:

- __ClusterIP__: Exposes the applications internally only, acting as a port-forwarder. Choosing this type makes the service available within the cluster. Default value when omitted
- __NodePort__: Exposes the service externally assigning each node a static port that responds to that service. When accessed through `nodeIp:port`, the node will automatically redirect the request to an internal service of the `clusterIP` type. This service will then forward the request on to the applications.
- __LoadBalancer__: Exposes the service externally using Azure's load-balancing solution. When created, this resource will spin up a Load Balancer resource within your Azure subscription. Also, this type will automatically create a `nodePort` service to which the Load Balancer's traffic will be redirected, and a `clusterIP` service to forward internally.
- __ExternalName__: Maps the service using a DNS resolution through a CNAME record. With this type, no proxying is set up.

We'll use the `clusterIP` type, because we'll be exposing the application externally through an __Ingress__.

### Ingresses

By default, all incoming traffic to a Kubernetes cluster is rejected. To allow traffic into the cluster, we need to create _ingress rules_. These rules are manipulated through a resource named Ingress.

Ingresses are like doors in a huge wall. They allow some traffic in based on a set of rules. Think of it as a firewall solution. An Ingress resource is required when exposing an application externally using a DNS name – like we want to do by allowing people to access Contoso's website through `http://contoso.com`.

Using managed services like AKS makes it a lot easier, because with the :::no-loc text="HTTP Application Routing"::: add on we create a resource called __Ingress Controller__.

Ingress controllers are reverse proxies that listen when you create an Ingress workload in the cluster. When you create a new Ingress, the add-on gets its name and figures where the DNS is pointing to by reading the manifest file. Then it automatically adds a new entry in the internal webserver's configuration that allows this DNS to pass through the cluster's "wall".

In AKS, the Ingress Controller is linked to a _DNS Zone_ resource in your Azure subscription – which was automatically created when we created our cluster. This link makes possible for the cluster to automatically create a zone record pointing the DNS name to the IP address and port of the exposed application.
