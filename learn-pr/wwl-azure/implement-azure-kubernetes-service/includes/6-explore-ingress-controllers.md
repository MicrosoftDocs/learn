When you create a Load Balancer–type Service, an underlying Azure Load Balancer resource is created.

The load balancer is configured to distribute traffic to the pods in your service on a given port. The Load Balancer only works at layer 4.

The Service is unaware of the actual applications and cannot make any other routing considerations.

Ingress controllers work at layer seven and can use more intelligent rules to distribute application traffic. Everyday use of an Ingress controller is to route HTTP traffic to different applications based on the inbound URL.

:::image type="content" source="../media/ingress-controller-4f677b4a.png" alt-text="A workflow graphic of incoming traffic being routed from the ingress controller to a blog service, and then being routed to four pods through port 80.":::


There are different implementations of the `Ingress Controller` concept. One example is the `Nginx Ingress Controller`, which translates the Ingress Resource into an **Nginx.conf** file.

Other examples are the `ALB Ingress Controller (AWS`) and the `GCE Ingress Controllers (Google Cloud)`, which use cloud-native resources.

Using the Ingress setup within Kubernetes makes it possible to quickly switch the reverse proxy implementation. So that your containerized workload leverages the most out of the cloud platform on which it's running.

## Azure virtual networks

In AKS, you can deploy a cluster that uses one of the following two network models:

 -  Basic networking. The network resources are created and configured when the AKS cluster is deployed.
 -  Advanced networking. The AKS cluster is connected to existing virtual network resources and configurations.
