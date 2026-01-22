This unit shows how you can troubleshoot pods and Services when AI applications on Azure Kubernetes Service (AKS) misbehave. You can use the Azure portal for visual inspection and guided diagnostics, or use `kubectl` for detailed command-line investigation. These techniques help you move from a high-level symptom to a concrete root cause.

AI workloads often rely on configuration, Secrets, and external services such as model endpoints or caches. Mistakes in these dependencies can cause containers to fail, probes to fail, or Services to route no traffic. A structured troubleshooting workflow reduces time-to-recovery and helps you fix the right problem.

AKS provides multiple ways to investigate issues. The Azure portal offers visual tools like Container insights and the Diagnose and solve problems option, while `kubectl` provides direct access to cluster resources. Many developers use both approaches together—the portal for quick visual assessment and `kubectl` for detailed investigation.

## Recognize pod-level issues for AI workloads

You begin by identifying common pod states that indicate problems:

- `ImagePullBackOff` when the container image reference or registry credentials are incorrect
- `CrashLoopBackOff` when the container repeatedly starts and exits with an error
- Pending pods that can't be scheduled because of resource constraints
- Pods that restart frequently, which might indicate memory leaks or unhandled exceptions

These conditions can make model-serving APIs or background workers intermittent or unavailable.

## Inspect pods using the Azure portal

The Azure portal provides visual tools to inspect pod status and events without command-line access. You can view pod health, logs, and events directly from the AKS resource.

To inspect pods in the Azure portal:

1. Navigate to your AKS cluster in the Azure portal.
1. Under **Kubernetes resources**, select **Workloads**.
1. Select a deployment, pod, or other workload type to view its details.
1. Select **Live Logs** to stream container logs in real time.

The Workloads section shows pod status, restart counts, and age at a glance. You can filter by namespace and quickly identify pods in error states. The Live Logs feature streams container output directly in the browser, which is useful when you need to observe behavior without setting up kubectl access.

You can also use the **Diagnose and solve problems** option from the AKS resource menu. This tool provides guided troubleshooting for common issues like connectivity problems, node health, and cluster configuration. It runs diagnostics automatically and suggests remediation steps based on detected issues.

## Use `kubectl describe` to inspect pods and events

The `kubectl describe` command gives you detailed information about a pod, including events. You can use this view to understand why a pod is unhealthy.

A typical flow is:

1. Find the pod that runs your AI service.
2. Describe the pod and scan the events section.
3. Look for failed probes, resource issues, or image pull errors.
4. Optionally, use `kubectl get events -n ai-workloads` to review recent cluster events across pods and controllers.

Commands might look like this:

```bash
kubectl get pods -n ai-workloads
kubectl describe pod <pod-name> -n ai-workloads
```

In the describe output, you pay attention to:

- Readiness and liveness probes for the AI endpoint
- Environment variables and mounted Secrets for model configuration
- Volume mounts that might contain model files or configuration
- Events that record failed pulls, scheduling issues, or probe failures

These details tell you whether the pod is configured as you expect.

> [!NOTE]
> When you adapt these examples, confirm that you use the correct namespace and resource names. You also need sufficient permissions in your AKS cluster to describe pods and Services.

## Debug from inside the container

Sometimes you need to observe the environment inside the container. You can open a shell to run diagnostic commands without modifying images.

### Debug using the Azure portal

The Azure portal Console feature lets you open a terminal session to a running container directly in the browser:

1. Navigate to your AKS cluster and select **Workloads** under **Kubernetes resources**.
1. Select a pod, then select the **Console** tab.
1. Choose the container and shell type to open an interactive session.

This approach is useful when you don't have kubectl configured locally or when you need quick access from any device with browser access.

### Debug using kubectl exec

You can also open a shell using kubectl:

```bash
kubectl exec -it <pod-name> -n ai-workloads -- /bin/sh
```

From inside the container, whether you access it through the portal or kubectl, you can:

- List model files or configuration directories
- Inspect environment variables that control which model or endpoint the service uses
- Run simple HTTP commands against local endpoints, such as `curl http://localhost:8080/health`

These checks help you confirm that the runtime environment matches your expectations. When you find a problem, you update manifests or configuration rather than making manual changes inside the container.

## Inspect Services that front AI endpoints

Even when pods are healthy, applications might be unreachable if Services are misconfigured. You examine Services to confirm that they route traffic to the right pods.

### Inspect Services using the Azure portal

To view Service configuration in the Azure portal:

1. Navigate to your AKS cluster and select **Services and ingresses** under **Kubernetes resources**.
1. Select a Service to view its details, including type, cluster IP, external IP, and port mappings.
1. Review the selector labels to verify they match your pod labels.

The portal shows Service endpoints and can help you quickly identify when a Service has no backing pods. You can also view associated pods directly from the Service details.

### Inspect Services using kubectl

You can use kubectl commands to examine Services in detail:

```bash
kubectl get service -n ai-workloads
kubectl describe service <service-name> -n ai-workloads
kubectl get endpointslices -l kubernetes.io/service-name=<service-name> -n ai-workloads
```

In the Service definition, you check:

- Selector labels that should match pod labels
- Ports and targetPorts that should align with container ports
- EndpointSlices that list the actual pod IPs that receive traffic

If a Service has no EndpointSlices, your AI API can't receive traffic even if pods are healthy. Resolving label mismatches or port configuration restores connectivity.

## Best practices for troubleshooting pods and Services

- **Start with visual inspection:** Use the Azure portal Workloads option for a quick overview of pod status and restart counts before diving into detailed investigation.
- **Use Diagnose and solve problems:** The AKS diagnostic tool in the Azure portal can automatically detect common issues and suggest fixes.
- **Combine portal and kubectl:** Use the portal for visual assessment and Live Logs, then switch to kubectl for detailed resource descriptions and events.
- **Check configuration that affects AI behavior:** Verify environment variables, ConfigMaps, and Secrets that specify model endpoints, keys, or storage locations.
- **Avoid ad hoc fixes inside containers:** Make permanent changes through source code and manifests so your AKS environment stays reproducible.
