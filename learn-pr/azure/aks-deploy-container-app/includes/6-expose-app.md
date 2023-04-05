An Azure Kubernetes Service (AKS) cluster blocks all inbound traffic from the internet to the cluster to assure network security. Deployed workloads in Kubernetes are, by default, only accessible from inside the cluster. To expose the applications to the outside world, you need to open specific ports and forward them to your services.

The configuration of ports and port forwarding in Kubernetes is different from what you might be used to in other environments. On a virtual machine (VM), configure the OS-level firewall to allow inbound traffic to port 443 and allow HTTPS web traffic. In Kubernetes, the control plane manages network configuration based on declarative instructions you provide.

## Networks in Kubernetes

The network configuration for containers is temporary. A container's configuration and the data in it isn't persistent between executions. After you delete a container, all information is gone unless it's configured to use a volume. The same applies to the container's network configuration and any IP addresses assigned to it.

A deployment is a logical grouping of pods. It isn't considered a physical workload and isn't assigned an IP address. But each pod is automatically assigned an IP address. When the pod is destroyed, the IP address is lost. This behavior makes a manual network configuration strategy complex.

Kubernetes has two network availability abstractions that allow you to expose any app without worrying about the underlying infrastructure or assigned pod IP addresses.

These abstractions are the *services* and *ingresses*. They're both responsible for allowing and redirecting the traffic from external sources to the cluster.

## What is a Kubernetes service?

A Kubernetes service is a workload that abstracts the IP address for networked workloads. A Kubernetes service acts as a load balancer and redirects traffic to the specified ports by using port-forwarding rules.

:::image type="content" source="../media/6-1-service-diagram.png" alt-text="A diagram that shows two Kubernetes services. The first service is applied to one pod. The second service is applied to two pods.":::

You define a service in the same way as a deployment, by using a YAML manifest file. The service uses the same `selector` key as deployments to select and group resources with matching labels into one single IP.

A Kubernetes service needs four pieces of information to route traffic.

| Information | Description |
| --- | --- |
| **Target resource** | The `selector` key in the service manifest file defines the target resource. This value selects all the resources with a given label onto a single IP address. |
| **Service port** | This port is the inbound port for your application. All the requests come to this port from where the service forwards the requests to the resource. |
| **Network protocol**| This value identifies the network protocol for which the service forwards network data. |
| **Resource port** | This value identifies the port on the target resource on which incoming requests are received. The `targetPort` key in the service manifest file defines this port.

## Kubernetes service types

Services can be of several types. Each type changes the behavior of the applications selected by the service.

- **ClusterIP**: This value exposes the applications internally only. This option allows the service to act as a port-forwarder and makes the service available within the cluster. This value is the default when omitted.

- **NodePort**: This value exposes the service externally. It assigns each node a static port that responds to that service. When accessed through `nodeIp:port`, the node automatically redirects the request to an internal service of the `ClusterIP` type. This service then forwards the request to the applications.

- **LoadBalancer**: This value exposes the service externally by using Azure's load-balancing solution. When created, this resource spins up an Azure Load Balancer resource within your Azure subscription. Also, this type automatically creates a `NodePort` service to which the load balancer's traffic is redirected and a `ClusterIP` service to forward it internally.

- **ExternalName**: This value maps the service by using a DNS resolution through a CNAME record. You use this service type to direct traffic to services that exist outside the Kubernetes cluster.

## What is ingress?

Ingress exposes routes for HTTP and HTTPS traffic from outside a cluster to services inside the cluster. You define ingress routes by using *ingress rules*. A Kubernetes cluster rejects all incoming traffic without these routes defined.

:::image type="content" source="../media/6-2-ingress-diagram.png" alt-text="A diagram that shows two Kubernetes services. The first service doesn't make use of an ingress and all internet access is blocked. The second service uses an ingress and internet access is allowed to the service.":::

Assume you want to allow clients to access your website through the `http://contoso.com` web address. For a client to access your app inside the cluster, the cluster must respond to the website's CNAME and route the requests to the relevant pod.

## How to use ingress controllers in Kubernetes

Kubernetes uses ingress controllers to manage the configuration of ingresses in a cluster and provides several features. An ingress controller:

- Acts as a reverse proxy to allow external URLs.
- Might act as a load balancer.
- Terminates SSL/TLS requests.
- Offers name-based virtual hosting.

In AKS, the ingress controller links to a _DNS Zone_ resource in your Azure subscription. The DNS Zone is automatically created as part of the cluster creation process on your behalf. The link makes it possible for the cluster to automatically generate a zone record that points the DNS name to the exposed application's IP address and port.

In AKS, the :::no-loc text="HTTP application routing"::: add-on allows you to create ingress controllers.

## What are ingress rules?

Ingress rules define where traffic is coming from and where to direct it within a cluster. You define ingress rules in an ingress deployment manifest file.

These rules are defined in the `rules` key of the manifest file. Each rule is a set of values that describes the rule.

For example, assume you want to allow clients to access your website by using the URL `http://example.com/site`. You want to route traffic to your video rendering service website. Here's an example of the defined ingress rule to allow this behavior.

```yaml
rules:
  - host: example.com # A FQDN that describes the host where that rule should be applied
    http:
      paths: # A list of paths and handlers for that host
        - path: /site # Which path is this rule referring to
          backend: # How the ingress will handle the requests
            serviceName: contoso-website # Which service the request will be forwarded to
            servicePort: 80 # Which port in that service
```

This example defines a rule that allows all traffic using the address `example.com` and path `/site` to enter the cluster. This traffic is then routed to the `contoso-website` service on port `80`.

## What is an annotation?

An annotation allows you to attach nonidentifying metadata, such as ingress configurations, for workloads. You can think of the annotation as an internal label that defines specific configurations for resources. For example, you might want to use a specific ingress controller that supports name rewriting or payload limiting.

Here's an example of the annotation in a manifest file that specifies the use of the HTTP application routing add-on.

```yaml
#ingress.yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: contoso-website
  annotations:
    kubernetes.io/ingress.class: addon-http-application-routing # Use the HTTP application routing add-on
```

In the next exercise, you'll define a service of type `ClusterIP` and expose your company's web app through an ingress.