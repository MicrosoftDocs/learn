A Kubernetes Deployment manifest is a YAML file that tells Azure Kubernetes Service (AKS) exactly how to run your containerized application. It specifies the container image, how many copies should run, resource requirements, environment variables, and configuration. Instead of manually managing containers, you describe your desired state in the manifest, apply it to the cluster, and Kubernetes makes it reality.

Imagine you're deploying a Python FastAPI application that performs AI model inference. Your application is already containerized in an image stored in Azure Container Registry. The Deployment manifest describes: "Run two copies of this image from my registry, each with 2GB memory and one CPU core, with these environment variables set." Once applied, AKS pulls the image, launches two Pods, monitors their health, and restarts any that crash.

## Deployment Manifest Structure

A Deployment manifest has a specific YAML structure that Kubernetes recognizes:

```yaml
# Code fragment - focus on Deployment manifest structure
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ai-inference-api     # Name of your Deployment
  namespace: default          # Kubernetes namespace (default is fine for most scenarios)
spec:
  replicas: 2                # Number of Pods to run
  selector:
    matchLabels:
      app: inference-api     # Label selector—Deployment manages Pods with this label
  template:
    metadata:
      labels:
        app: inference-api   # Pod label—must match selector above
    spec:
      containers:
      - name: api
        image: myregistry.azurecr.io/inference-api:v1.0
        ports:
        - containerPort: 8080 # Port your app listens on inside the container
        resources:
          requests:
            memory: "2Gi"
            cpu: "1000m"      # 1 CPU core
          limits:
            memory: "4Gi"
            cpu: "2000m"
        env:
        - name: MODEL_NAME
          value: "gpt-4"
        - name: API_KEY
          valueFrom:
            secretKeyRef:
              name: api-secrets
              key: api-key
```

The manifest tells Kubernetes: "Maintain 2 running Pods of the `inference-api` image, each with these resources and environment variables."

## Container Image Specification

Your Deployment references a container image that contains your application. The image path follows this format: `registryname.azurecr.io/imagename:tag`

- **Registry name**: Your Azure Container Registry name (for example, `myregistry.azurecr.io`)
- **Image name**: The name of your image (for example, `inference-api`)
- **Tag**: The image version (for example, `v1.0` or `latest`)

The full path looks like: `myregistry.azurecr.io/inference-api:v1.0`

```yaml
# Code fragment - focus on image specification
containers:
- name: api
  image: myregistry.azurecr.io/inference-api:v1.0  # Full image path with tag
```

Ensure your image is:
- Already built and pushed to your registry
- Accessible from your AKS cluster
- Includes your application code and all dependencies

## Replicas for High Availability

The `replicas` field determines how many copies of your application run simultaneously. For AI workloads, typically 2-3 replicas are sufficient to ensure your application keeps running if a Pod crashes.

```yaml
# Code fragment - focus on replicas configuration
spec:
  replicas: 2  # Run 2 Pods
```

Why replicas matter: If you run only one Pod and it crashes (memory error, bug, out-of-memory), your application is temporarily down until Kubernetes detects the crash and restarts it. With 2-3 replicas, even if one Pod crashes, the others keep handling requests. The Deployment controller monitors Pod health and automatically restarts crashed Pods.

For an AI inference API:
- **2 replicas**: Basic resilience against single pod failures. Good for development and noncritical services.
- **3 replicas**: Better resilience. Recommended for production APIs serving external users.
- **4+ replicas**: Only if traffic is high and you need load distribution. Keep in mind—each replica consumes resources, so balance resilience with cost.

## Resource Requests and Limits

Kubernetes needs to know how much CPU and memory your application requires. You specify two values:

**Requests**: The amount your app needs to run properly. Kubernetes uses this value to schedule Pods on nodes with enough resources. If a Pod requests 2GB memory and nodes only have 1GB free, the Pod stays Pending.

**Limits**: The maximum your app can consume. If your app tries to exceed this value, Kubernetes terminates and restarts it (OOMKill for memory).

```yaml
# Code fragment - focus on resource requests and limits
resources:
  requests:
    memory: "2Gi"      # This Pod needs 2GB memory to start
    cpu: "1000m"       # This Pod needs 1 CPU core (1000 millicores)
  limits:
    memory: "4Gi"      # Pod can't exceed 4GB; terminated if it tries
    cpu: "2000m"       # Pod can't exceed 2 CPU cores
```

For an AI inference Pod:
- **Memory requests/limits**: Depends on your model size. A small language model might need 2-4GB; larger models need more. Start with your model's documented requirements, then add 20% for overhead.
- **CPU requests/limits**: For inference, typically 1-2 CPU cores per Pod is sufficient. Adjust based on expected throughput.

Setting requests too low causes Pod crashes (OOMKill). Setting them too high wastes cluster resources and costs money. You refine these values based on observing actual usage.

## Environment Variables and Secrets

Your application likely needs configuration: model names, API endpoints, API keys, database connection strings. Kubernetes provides two mechanisms:

**Environment Variables** for nonsensitive configuration:

```yaml
# Code fragment - focus on environment variables
env:
- name: MODEL_NAME
  value: "gpt-4"
- name: API_ENDPOINT
  value: "https://api.example.com"
```

**Secrets** for sensitive data (API keys, credentials):

```yaml
# Code fragment - focus on secret references
env:
- name: API_KEY
  valueFrom:
    secretKeyRef:
      name: api-secrets      # Name of the Secret object
      key: api-key           # Key within the Secret
```

Create the Secret separately using kubectl:

```bash
# Code fragment - focus on kubectl secret creation
kubectl create secret generic api-secrets --from-literal=api-key=your-secret-key
```

Never hardcode secrets in your manifest. Using Secrets keeps sensitive data out of source control and version history.

## Additional Resources

- [Kubernetes Deployments Documentation](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) - Official reference for Deployment specifications
- [Azure Container Registry Documentation](/azure/container-registry/container-registry-intro) - Build and store container images on Azure
- [Managing Kubernetes Secrets](/azure/aks/developer-best-practices-pod-security#kubernetes-secrets) - Best practices for handling sensitive data
