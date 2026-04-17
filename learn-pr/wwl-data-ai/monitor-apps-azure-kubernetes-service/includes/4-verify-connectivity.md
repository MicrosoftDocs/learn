In this unit, you verify that Kubernetes Services and ingress routes direct traffic correctly to your AI workloads on Azure Kubernetes Service (AKS). You can use the Azure portal for visual inspection of Services and endpoints, or use `kubectl` and HTTP clients for detailed connectivity testing.

AI applications often expose HTTP endpoints for inference or data processing. Clients rely on stable URLs or hostnames. Misconfigured Services or ingress rules can create intermittent failures that are difficult to diagnose. By systematically checking connectivity paths using both the Azure portal and command-line tools, you can confirm that users and downstream services can reach your AI endpoints.

## Review Service types and AI scenarios

You start by reviewing how Kubernetes Services expose applications on AKS:

- ClusterIP exposes a service inside the cluster only
- LoadBalancer exposes a service externally through an Azure Load Balancer
- NodePort maps a port on each node to a service port

AI APIs that must be reachable from client applications usually use a LoadBalancer Service or are exposed through an ingress controller. Internal-only services might use ClusterIP.

## Review Services and endpoints in the Azure portal

The Azure portal provides visual tools to inspect Service configuration and connectivity without command-line access.

To review Services in the Azure portal:

1. Navigate to your AKS cluster in the Azure portal.
1. Under **Kubernetes resources**, select **Services and ingresses**.
1. Select a Service to view its details, including type, cluster IP, external IP, and port mappings.
1. Review the **Endpoints** section to see which pods receive traffic.

The Services and ingresses section shows all Services across namespaces. You can filter by namespace and quickly identify Services with external IPs. The details view shows selector labels, port configurations, and the current endpoints. If the endpoints list is empty, the Service has no backing pods and can't route traffic.

For ingress resources, the same section shows host rules, paths, and backend Services. You can verify that ingress rules point to the correct Services and that external addresses are assigned.

## Validate Service-to-pod connectivity using kubectl

You can use kubectl to confirm that Services route traffic to the correct pods. A Service selects pods based on labels. If labels don't match, the Service has no endpoints.

You might run:

```bash
kubectl get service -n ai-workloads
kubectl describe service inference-api -n ai-workloads
kubectl get endpointslices -l kubernetes.io/service-name=inference-api -n ai-workloads
```

In the Service output, you verify that:

- The selector matches labels on your pods
- Ports and targetPorts align with container ports
- The EndpointSlices list contains pod IP addresses

If EndpointSlices are empty, you update pod labels or Service selectors so they align. After you apply the change, you confirm that EndpointSlices appear and that requests reach the pods.

> [!NOTE]
> Replace service names, namespaces, and ports with values from your own AI workloads. The commands in this unit are patterns for verifying connectivity.

## Test AI endpoints with `kubectl port-forward`

Port-forwarding lets you send traffic from your development machine to a Service or pod inside the cluster. This technique is useful when you debug a new model endpoint or when ingress isn't yet configured. You can forward traffic either directly to a pod or, as shown here, to a Service that fronts multiple replicas.

You might run a command like:

```bash
kubectl port-forward service/inference-api 8080:80 -n ai-workloads
```

Then, in another terminal, you issue a request:

```bash
curl http://localhost:8080/api/inference
```

If the application responds successfully, you know that the Service and pods work as expected. If you see errors, you can correlate them with logs and metrics from earlier units.

## Verify external connectivity through load balancers and ingress

For externally accessible AI APIs, you validate the public path from clients to the cluster. You can find external addresses in the Azure portal or using kubectl.

### Find external addresses in the Azure portal

1. Navigate to your AKS cluster and select **Services and ingresses** under **Kubernetes resources**.
1. Look for Services of type **LoadBalancer** and note the **External IP** column.
1. For ingress resources, check the **Address** column for the external hostname or IP.

The portal provides a quick way to find external endpoints without running commands. You can copy the address directly and use it for testing.

### Find external addresses using kubectl

You can also retrieve external addresses from the command line:

```bash
kubectl get service inference-api -n ai-workloads
kubectl get ingress -n ai-workloads
```

From the output, you locate the external address and send test requests from a client or test environment. You confirm that requests reach the expected AI endpoint and return successful responses.

## Best practices for verifying connectivity

- **Start with the portal for quick inspection:** Use the Services and ingresses section to quickly identify external IPs, empty endpoints, and misconfigured selectors.
- **Standardize labels:** Use consistent labels for AI workloads so Services and ingress resources select the correct pods.
- **Test before exposing:** Use port-forwarding and internal testing to validate endpoints before publishing them to users.
- **Combine portal and kubectl:** Use the portal for visual overview of Service configuration and kubectl for detailed endpoint inspection and port-forwarding.
- **Combine checks with monitoring:** Pair connectivity tests with logs and metrics so you can see the impact of configuration changes on AI workloads.
