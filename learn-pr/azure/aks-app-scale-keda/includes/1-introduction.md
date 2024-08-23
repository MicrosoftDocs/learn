## Example scenario

You work as a DevOps engineer for a growing online pet store that sells various pet products. Client application usage peaks at various times during any given 24-hour period. Due to this increasing and decreasing demand, the company needs to be able to scale its application accordingly to provide a better experience to its customers. Because the application is event-driven and receives a large number of events at various times, CPU and memory-based metrics aren't fully representative of the load on the system. You've been tasked with finding a scaling solution that will help the company achieve its scaling needs.

After experimenting with various options, you've determined that using Azure Kubernetes Services (AKS) and Kubernetes Event-driven Autoscaling (KEDA) fulfills all the requirements to scale for peak and off-peak usage.

> [!NOTE]
> All exercises use the [Azure Cloud Shell](/azure/cloud-shell/overview), which already has all the needed tooling installed. If you prefer to run the examples locally, you need to install [Azure CLI](/azure/aks/learn/quick-kubernetes-deploy-cli) and [Kubectl](/azure/aks/learn/quick-kubernetes-deploy-cli).
