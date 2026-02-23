After writing your Deployment and Service manifests, deploying to AKS is straightforward. Use `kubectl apply` to send the manifests to your cluster. Kubernetes then reconciles the current state with your desired state by pulling images, launching Pods, creating Services, and assigning public IPs if needed.

Imagine writing your Deployment and Service manifests and saving them as `deployment.yaml` and `service.yaml`. You run `kubectl apply`, and moments later, your AI inference API is running on AKS with a public IP address.

## Deploying with kubectl apply

The `kubectl apply` command is your primary tool for deploying to AKS. It reads your YAML manifests and tells the cluster to create or update resources:

```bash
# Code fragment - focus on kubectl apply commands
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# Or deploy both in one command:
kubectl apply -f deployment.yaml -f service.yaml

# Or deploy all YAML files in a directory:
kubectl apply -f .
```

Kubernetes processes the manifests and:
1. Pulls your container image from the registry
2. Schedules Pods on cluster nodes
3. Starts your containers
4. Creates the Service and assigns networking

The deployment is asynchronous—`kubectl apply` returns immediately, but Pods may take a few seconds to start (pulling images, initializing containers).

## Verifying Deployment Status

After deploying, verify everything is running:

```bash
# Code fragment - focus on verifying deployment status
# Check Pod status
kubectl get pods

# Output:
# NAME                             READY  STATUS    RESTARTS   AGE
# inference-api-7d8b4f9c6-abc12    1/1    Running   0          2m
# inference-api-7d8b4f9c6-xyz78    1/1    Running   0          2m

# Check Deployment status
kubectl get deployment

# Output:
# NAME             READY   UP-TO-DATE   AVAILABLE   AGE
# inference-api    2/2     2            2           2m
```

**READY**: How many replicas are ready. "2/2" means both replicas are running.

**STATUS**: Pod state. "Running" is what you want. "Pending" means the Pod is still starting (pulling image, waiting for resources). "CrashLoopBackOff" means your app is crashing—read logs to diagnose.

```bash
# Code fragment - focus on checking logs
# View logs from a specific Pod
kubectl logs inference-api-7d8b4f9c6-abc12

# View logs from the last 10 minutes
kubectl logs inference-api-7d8b4f9c6-abc12 --since=10m

# View logs from all Pods in the Deployment
kubectl logs -l app=inference-api
```

Check Service status:

```bash
# Code fragment - focus on verifying services
kubectl get svc

# Output:
# NAME                      TYPE           CLUSTER-IP    EXTERNAL-IP    PORT(S)
# inference-api-service     LoadBalancer   10.0.12.45    40.89.123.45   80:30523/TCP
```

The EXTERNAL-IP (for LoadBalancer) or node IPs (for NodePort) is what clients use to reach your service. If EXTERNAL-IP is `<pending>`, the load balancer is still being provisioned—wait a moment and check again.

## Checking Connectivity

Verify your application is actually responding to requests:

**For ClusterIP services (internal only)**: Run a test Pod and call the service DNS name:

```bash
# Code fragment - focus on testing internal services
# Run a test Pod
kubectl run -it --rm debug --image=alpine:latest --restart=Never -- sh

# Inside the debug Pod, test the service
wget http://inference-api-service:80
```

**For LoadBalancer services (external)**: Use the public IP to test from your machine:

```bash
# Code fragment - focus on testing external services
# Get the external IP
kubectl get svc inference-api-service

# Test with curl
curl http://40.89.123.45

# Or test a specific endpoint
curl http://40.89.123.45/predict -X POST -d '{"input": "test"}'
```

If the service is reachable, you get a response from your application. If it times out or refuses connection, troubleshoot using the scenarios below.

## Troubleshooting Common Issues

When deployments don't work, diagnose systematically using kubectl commands:

### ImagePullBackOff

**Symptom**: Pod status is "ImagePullBackOff"

**Cause**: Kubernetes can't pull your container image from the registry.

**Diagnosis**:
```bash
# Code fragment - focus on diagnosing ImagePullBackOff
kubectl describe pod inference-api-7d8b4f9c6-abc12

# Look for events section—you'll see an error like:
# Failed to pull image "myregistry.azurecr.io/inference-api:v1.0": image not found
```

**Solutions**:
- Verify the image path, tag, and registry are correct in your manifest
- Confirm the image was built and pushed to your registry: `az acr repository list --name myregistry`
- Ensure your AKS cluster has credentials to pull from your registry (usually automatic with Azure Container Registry)
- Try pulling the image manually to test: `docker pull myregistry.azurecr.io/inference-api:v1.0`

### CrashLoopBackOff

**Symptom**: Pod status is "CrashLoopBackOff"—your application keeps crashing and restarting

**Cause**: Your application is exiting or crashing on startup.

**Diagnosis**:
```bash
# Code fragment - focus on diagnosing CrashLoopBackOff
# View the application's error logs
kubectl logs inference-api-7d8b4f9c6-abc12

# View logs including previous crashes
kubectl logs inference-api-7d8b4f9c6-abc12 --previous

# Get detailed Pod information and events
kubectl describe pod inference-api-7d8b4f9c6-abc12
```

**Solutions**:
- Check application logs for error messages (missing environment variables, configuration errors, etc.)
- Verify all environment variables and secrets are configured and accessible
- Ensure configuration files (if your app uses them) are mounted correctly
- Test your container image locally to ensure the application starts: `docker run myregistry.azurecr.io/inference-api:v1.0`

### Pending Pods

**Symptom**: Pods stay in "Pending" status and never transition to "Running"

**Cause**: Kubernetes can't schedule Pods—likely insufficient resources (memory, CPU) or node issues.

**Diagnosis**:
```bash
# Code fragment - focus on diagnosing pending pods
kubectl describe pod inference-api-7d8b4f9c6-abc12

# Look for events section—you'll see:
# Insufficient memory, Insufficient cpu

# Check node resources
kubectl get nodes
kubectl describe node <node-name>
```

**Solutions**:
- Check cluster capacity: `kubectl top nodes` (requires metrics server)
- Review your resource requests—they might be too large for available nodes
- Add more nodes to the cluster if capacity is exhausted: `az aks scale --resource-group mygroup --name myaks --node-count 3`
- If using resource limits that are too aggressive, increase them or remove limits

### Service Has No Endpoints

**Symptom**: Service exists but `kubectl describe svc` shows "Endpoints: \<none>"

**Cause**: No Pods are matching the Service's selector—traffic has nowhere to go.

**Diagnosis**:
```bash
# Code fragment - focus on diagnosing endpoint issues
kubectl get pods -L app

# Shows all Pods and their labels

kubectl describe svc inference-api-service

# Look for "Selector" and "Endpoints"
# If Endpoints is empty, the selector isn't matching Pods
```

**Solutions**:
- Verify Pod labels match the Service selector: compare `kubectl get pods --show-labels` with the Service's selector
- Update either the Pod labels or Service selector so they match
- Ensure the Deployment's Pod template has the correct label matching the Service selector

## Additional Resources

- [kubectl Command Reference](https://kubernetes.io/docs/reference/kubectl/overview/) - Complete kubectl command documentation
- [Kubernetes Troubleshooting Guide](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application/) - Debugging applications in Kubernetes
- [AKS Best Practices](/azure/aks/best-practices) - Production readiness practices for AKS
