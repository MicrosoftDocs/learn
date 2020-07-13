Now that we have our application up and running on the cluster. We'll notice it's not accessible by anyone but those inside the cluster itself. Differently from a VM, where we can control all the open ports and network availability, in Kubernetes these controls are in the power of the control plane and we can give it instructions to open some ports for us.

By default, all inbound traffic from the Internet to the AKS cluster is blocked to assure network security. To expose the applications to the outer world, we need to open specific ports and forward them to our services. Since the control plane has the power over that information. Kubernetes has two abstractions around network availability that allows us to expose any app without needing to worry about the underlying infrastructure.

These abstractions are the **Services** and **Ingresses**. They're both responsible for allowing and redirecting the traffic from external sources to our cluster.

## Networks in Kubernetes

Containers are temporary. A container's configuration and data the data in it isn't persistent between executions. Once you delete a container, all information is gone unless it's configured to use a volume.

The same applies to the container's network configuration.

Deployments aren't considered a physical workload since they're only logical groups of pods, so we don't have to worry about their networking rules or IP addresses. Their pods, however, have an internal IP assigned to each of them when created. Like all the data, this IP is lost when the pod is destroyed. Internet is based on persistent IP addresses, so how can we expose an ever-changing pod IP to the network? The answer is **services**.

### Kubernetes services

Services are workloads that abstract the IP address for networked workloads, like pods. Essentially, a service uses the same `selector` key as deployments to select and group resources with the required labels into one single IP, acting somewhat as a load balancer and redirecting the traffic to the specific ports. Services handle the port-forwarding rules to their selected pods. They receive incoming packages one port and forward them onto an internal one.

:::image type="content" source="../media/6-1-service-diagram.png" alt-text="Services diagram":::

A basic service needs to know about three pieces of information:

- **Which are the resources it needs to route the traffic to:** Defined by the `selector` key, which selects the resources with the given labels and values to be grouped into a single IP address
- **Which port in the service will receive the traffic:** It's the inbound port for your application, all the requests should come to this port in the service to it can forward the request to the resource
- **To which port in the resource the traffic will be directed:** Essentially, the service is a port-forwarding abstraction. It receives incoming requests in a port and forwards those requests to another internal port in the resource. This port is the one we opened in the `ports` key of the deployment in the previous unit. This is called the **Target Port**.

All that information will be going into the manifest file. Describing how you'd like your routing to work within your cluster. Generally, services act as an internal router to specific applications, so you don't need to expose your pod's port straight to the Internet. Services can be of several types. Each type changes the behavior of the applications selected by the service:

- **ClusterIP**: Exposes the applications internally only, acting as a port-forwarder. Choosing this type makes the service available within the cluster. Default value when omitted
- **NodePort**: Exposes the service externally, assigning each node a static port that responds to that service. When accessed through `nodeIp:port`, the node will automatically redirect the request to an internal service of the `clusterIP` type. This service will then forward the request on to the applications.
- **LoadBalancer**: Exposes the service externally using Azure's load-balancing solution. When created, this resource will spin up a Load Balancer resource within your Azure subscription. Also, this type will automatically create a `nodePort` service to which the Load Balancer's traffic will be redirected, and a `clusterIP` service to forward internally.
- **ExternalName**: Maps the service using a DNS resolution through a CNAME record. With this type, no proxying is set up.

We'll use the `clusterIP` type because we'll be exposing the application externally through an __Ingress__.

### Ingresses

By default, all incoming traffic to a Kubernetes cluster is rejected. To allow traffic into the cluster, we need to create _ingress rules_. These rules are manipulated through a resource named Ingress.

Ingresses are like doors in a huge wall. They allow some traffic in based on a set of rules. Think of it as a firewall solution. An Ingress resource is required when exposing an application externally using a DNS name – like we want to do by allowing people to access Contoso's website through `http://contoso.com`.

:::image type="content" source="../media/6-2-ingress-diagram.png" alt-text="Ingress diagram":::

Using managed services like AKS makes it a lot easier, because with the :::no-loc text="HTTP Application Routing"::: add on we create a resource called __Ingress Controller__.

Ingress controllers are reverse proxies that listen when you create an Ingress workload in the cluster. When you create a new Ingress, the add-on gets its name and figures where the DNS is pointing to by reading the manifest file. Then it automatically adds a new entry in the internal webserver's configuration that allows this DNS to pass through the cluster's "wall".

In AKS, the Ingress Controller is linked to a _DNS Zone_ resource in your Azure subscription – which was automatically created when we created our cluster. This link makes possible for the cluster to automatically create a zone record pointing the DNS name to the IP address and port of the exposed application.

When we define and Ingress, we need to provide some information to the manifest so it knows where the traffic is coming from and where to direct it. These are the **Ingress Rules**. These rules are defined in the `rules` key of the manifest. Each rule is a set of a few other options:

```yml
rules:
  - host: example.com # A FQDN that describes the host where that rule should be applied
    http:
      paths: # A list of paths and handlers for that host
        - path: /site # Which path is this rule referring to
          backend: # How the ingress will handle the requests
            serviceName: contoso-website # Which service the request will be forwarded to
            servicePort: 80 # Which port in that service
```

This example is saying to the Ingress that we should allow all traffic coming from `example.com` in the path `/site` – which means we're allowing `http://example.com/site` – to enter the cluster, and all this traffic will be sent to the `contoso-website` service and will hit port `80` in that service. An Ingress is basically a name resolver to a service, which resolves the incoming traffic to a port in the pod.

It's also common to see Ingresses work with what is called **Annotations**. Annotations are like labels, but to attach non-identifying metadata such as ingress configurations to workloads. The main difference between a label and an annotation is that labels are public and are used like filters, while annotations are internal and define specific configurations for resources which are destined to libraries and other clients.

The best example of how an annotation can be used within an ingress is to tell Azure that we want to use the HTTP Application Routing Addon we deployed earlier on this module. The HTTP Application Routing is an **Ingress Controller**, which means it'll read all the ingresses with the annotation `kubernetes.io/ingress.class` with the value of `addon-http-application-routing` and create an external access for that ingress:

```yml
#ingress.yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: contoso-website
  annotations:
    kubernetes.io/ingress.class: addon-http-application-routing # Using HTTP Application Routing Addon
```

Different ingress controllers can support different types of annotations that can perform other tasks such as name rewriting, payload limiting, and IP based permissions.
