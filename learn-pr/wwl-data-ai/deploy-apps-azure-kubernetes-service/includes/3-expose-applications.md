A Kubernetes Service provides a stable endpoint for accessing your application. Without a Service, your Pods have internal IP addresses that change whenever they restart—not reliable for consistent access. A Service abstracts the changing Pod IPs by giving your application a persistent IP (or DNS name) that clients use and automatically routing traffic to Pods based on selector labels.

Imagine your AI inference API is running in two Pods behind a Service. A client calls the Service's IP address, and the Service routes the request to one of the Pods (load balancing). If a Pod crashes and restarts with a new IP, the Service still routes traffic correctly—the client never knows the Pod's IP changed.

## Choosing the Right Service Type

The Service type determines how your application is accessed. Choose based on whether your application is internal or external:

**ClusterIP (default)**: Internal IP address within the cluster only. Pods access the service using the Service's DNS name. Use when:
- Your application serves other pods in the cluster (for example, a vector database service accessed by multiple AI workers)
- You don't need external access
- You're building a backend service in your architecture

Example: Your vector search service running in two Pods, accessed internally by other AI workloads.

**NodePort**: Exposes the service on a port across all cluster nodes. External clients access using `node-ip:nodeport`. Use when:
- You're testing or developing and want simple external access
- You don't need a managed load balancer
- You're integrating with external load balancers (less common)

Example: During development, you access your API via `192.168.1.10:30080` (a node's IP and the exposed port).

**LoadBalancer**: Creates an external Azure Load Balancer with a public IP address. Traffic arriving at the public IP is routed to your Service and then to Pods. Use when:
- Your application needs to be accessible from the internet (production AI APIs)
- You want a managed, Azure-integrated load balancer
- You're serving external clients

Example: Your AI inference API is accessible at `40.89.123.45` (a public IP assigned by Azure Load Balancer), serving requests from external users.

**ExternalName**: Maps the service to an external DNS name (no load balancing). Use when:
- Your pods need to call external services outside the cluster
- You want to represent an external service as a Kubernetes Service (less common for this module)

## Service Manifest Structure

A Service manifest specifies the service type, port mapping, and selector (which Pods to route to):

```yaml
# Code fragment - focus on LoadBalancer Service manifest
apiVersion: v1
kind: Service
metadata:
  name: inference-api-service
spec:
  type: LoadBalancer              # External load balancer with public IP
  selector:
    app: inference-api            # Route to Pods with this label
  ports:
  - protocol: TCP
    port: 80                       # External port (what clients connect to)
    targetPort: 8080              # Container port (what your app listens on)
```

The `selector` matches Pod labels from your Deployment. The selector automatically connects the Service to your Pods—when traffic arrives at the Service, it routes to Pods with matching labels.

## Port Configuration

The Service exposes one port and forwards traffic to your application's port:

- **port**: The external port clients connect to (usually 80 for HTTP, 443 for HTTPS)
- **targetPort**: The port your application listens on inside the container (typically 8080, 5000, 3000, etc.)

```yaml
# Code fragment - focus on port mapping
ports:
- protocol: TCP
  port: 80              # Clients connect on port 80
  targetPort: 8080      # Your app listens on port 8080
```

This is the critical connection: when a client connects to the Service's port 80, the Service forwards the connection to the Pod's port 8080 (where your Flask, FastAPI, or Express app is listening).

## Accessing the Service

How you access the service depends on its type:

**ClusterIP**: Use the DNS name `servicename.namespace.svc.cluster.local` from within other pods. Example: Inside a pod, call `http://inference-api-service.default.svc.cluster.local:8080` to reach your service.

**NodePort**: Use `node-ip:nodeport` from outside the cluster. Get the nodeport using `kubectl get svc`—it's usually a high port number (30000+). Example: `http://192.168.1.10:30080`

**LoadBalancer**: Use the public IP assigned by Azure. Get the IP using `kubectl get svc`—the EXTERNAL-IP column shows the public address. Example: `http://40.89.123.45`

```bash
# Code fragment - focus on checking Service status
kubectl get svc inference-api-service

# Output:
# NAME                      TYPE          CLUSTER-IP     EXTERNAL-IP    PORT(S)
# inference-api-service     LoadBalancer  10.0.12.45     40.89.123.45   80:30523/TCP
```

The EXTERNAL-IP field shows the public IP clients use (for LoadBalancer) or node IPs (for NodePort). CLUSTER-IP is only for internal access.

## Service-to-Pod Connection

The magic that connects Services to Pods is the selector. When you create a Service with `selector: app: inference-api`, Kubernetes finds all Pods with the label `app: inference-api` and routes traffic to them automatically.

```yaml
# Code fragment - focus on selector matching
# In your Deployment:
template:
  metadata:
    labels:
      app: inference-api     # Pods get this label

# In your Service:
selector:
  app: inference-api         # Service routes to Pods with this label
```

If the labels don't match, the Service has no Pods to route to (no endpoints). Always verify that Pod labels and Service selectors match—this is a common troubleshooting issue.

## Additional Resources

- [Kubernetes Services Documentation](https://kubernetes.io/docs/concepts/services-networking/service/) - Official reference for Service specifications and types
- [Azure Load Balancer Documentation](/azure/load-balancer/load-balancer-overview) - Understanding Azure's load balancing service
- [Exposing Applications on AKS](/azure/aks/concepts-network) - AKS networking and service exposure patterns
