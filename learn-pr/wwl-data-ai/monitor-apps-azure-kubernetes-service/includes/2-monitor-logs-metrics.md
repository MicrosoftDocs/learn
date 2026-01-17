In this unit, you learn how to observe application behavior inside an Azure Kubernetes Service (AKS) cluster. You focus on logs and metrics that reveal how AI workloads behave in production. You see how to use both the Azure portal and `kubectl` for inspections, and how these signals relate to Azure monitoring tools.

AI applications such as model inference APIs and background processors depend on predictable performance. Latency spikes, increased error rates, or CPU saturation can indicate model issues or configuration problems. Monitoring logs and metrics helps you distinguish between normal variation and emerging incidents. You can then decide when to scale, investigate, or roll back changes.

AKS provides multiple ways to access logs and metrics. The Azure portal offers visual dashboards, Live Logs streaming, and the Monitoring tab on your cluster resource. For command-line access, `kubectl` provides direct queries against pods and nodes. Many developers start with the portal for a quick overview and then use `kubectl` for targeted investigation.

## Identify key monitoring signals for AI workloads

You start by identifying which signals matter most for AI services that run on AKS. For example, an inference API might expose HTTP status codes and latency. Background workers might track queue depth or batch processing times.

Important signals include:

- Response latency and throughput for AI endpoints
- Error rates such as HTTP 5xx responses or timeouts
- Pod restart counts and container exit codes
- CPU and memory utilization compared to configured requests and limits

Together, these signals help you determine whether your AI workload stays within its performance and reliability targets.

## View logs using the Azure portal

The Azure portal provides visual tools to view container logs without command-line access. You can stream logs in real time or view recent output directly from the AKS resource.

To view logs in the Azure portal:

1. Navigate to your AKS cluster in the Azure portal.
1. Under **Kubernetes resources**, select **Workloads**.
1. Select a deployment, pod, or other workload type.
1. Select **Live Logs** to stream container output in real time.

The Live Logs feature shows container stdout and stderr as the application produces output. You can pause the stream, search for specific text, and switch between containers in multi-container pods. This approach is useful when you need quick access to logs without configuring kubectl or when you want to share a browser session with a colleague.

You can also view logs from the **Insights** section under **Monitoring**. Container insights provides a unified view of logs across your cluster, with filtering by namespace, pod, and container. This view is helpful when you need to correlate logs across multiple pods or search for patterns across your AI workloads.

## Use `kubectl logs` to inspect application behavior

You can use `kubectl logs` to read container logs directly from pods. This method is useful when you need to inspect an application quickly or reproduce an issue.

A typical flow is:

1. List pods for your AI application in the target namespace.
1. Stream logs from a specific pod while you send test traffic.
1. Filter for errors, timeouts, or unexpected responses.

You might run the following commands:

```bash
kubectl get pods -n ai-workloads
kubectl logs <pod-name> -n ai-workloads
kubectl logs -f <pod-name> -n ai-workloads
```

These log commands target a specific Kubernetes namespace instead of the default namespace. A namespace is a logical boundary inside the cluster that groups related workloads, such as all AI services for a particular environment.

You can use the `-n ai-workloads` flag to tell `kubectl` to look in the `ai-workloads` namespace when you list pods or fetch logs. If your AI workloads run in the `default` namespace, or your current context already sets a namespace, you can omit the flag or replace `ai-workloads` with the namespace that matches your deployment.

Namespaces complement Kubernetes labels. Namespaces help you separate environments and control access and quotas, while labels help you select specific pods inside a namespace when you scale, roll out updates, or filter logs for a single AI service.

If a pod has multiple containers, such as a sidecar for logging or metrics, you specify the container name:

```bash
kubectl logs <pod-name> -c inference-api -n ai-workloads
```

You can use these logs to find patterns such as repeated timeouts when calling an upstream model endpoint or failures when retrieving features from a cache.

> [!NOTE]
> Code fragments and commands in this unit are patterns you can adapt. Replace namespace, pod, and container names with values from your own AKS environment.

## View resource metrics using the Azure portal

The Azure portal provides visual dashboards for CPU, memory, and other resource metrics without requiring command-line access.

To view metrics in the Azure portal:

1. Navigate to your AKS cluster in the Azure portal.
1. Select the **Monitoring** tab on the Overview page to see metric graphs for your cluster.
1. Under **Monitoring**, select **Insights** to access Container insights dashboards.
1. Use the **Nodes**, **Controllers**, or **Containers** tabs to view resource utilization at different levels.

The Monitoring tab shows CPU and memory usage graphs separated by node pool. You can select any graph to open it in metrics explorer for deeper analysis. Container insights provides heat maps and performance charts that highlight resource-constrained pods and nodes.

You can also view live metrics for individual pods:

1. Under **Monitoring**, select **Insights**.
1. Select the **Nodes** or **Controllers** tab, then select a pod.
1. Select **Live Metrics** to see real-time CPU, memory, and network data.

These visual tools help you quickly identify which AI workloads are under resource pressure without running commands.

## View resource metrics using kubectl

Resource metrics help you understand whether your AI workload uses CPU and memory as expected. High CPU utilization can indicate a model that needs more resources or a need to scale out replicas. High memory usage can cause container restarts or degraded performance.

If your cluster has the metrics server installed, you can run:

```bash
kubectl top nodes
kubectl top pods -n ai-workloads
```

This output shows per-node and per-pod CPU and memory usage. You can compare these values to the requests and limits defined in your pod specifications. If a pod constantly reaches its CPU limit, node-level CPU limits can throttle it, which can increase inference latency.

## Combine Azure portal and kubectl for effective monitoring

AKS integrates with Azure Monitor so you can collect and visualize telemetry over time. The monitoring tools covered in this unit work together to provide comprehensive visibility into your AI workloads.

A typical monitoring workflow combines both approaches:

- Use the Azure portal Monitoring tab for a quick health overview of your cluster
- Use Live Logs in the portal to stream container output when investigating an issue
- Use `kubectl logs` when you need to filter logs or pipe output to other tools
- Use `kubectl top` for a quick snapshot of current resource usage
- Use Container insights dashboards for historical trends and cross-pod analysis

For example, you might notice high CPU usage on the portal's Monitoring tab, drill into Container insights to identify the affected pods, then use `kubectl logs` to inspect application behavior during the spike. This combination helps you respond quickly to incidents and learn from historical data.

## Best practices for monitoring AI workloads on AKS

- **Start with the portal for visual overview:** Use the Monitoring tab and Container insights for a quick assessment of cluster and workload health before diving into command-line investigation.
- **Use Live Logs for real-time observation:** Stream container output in the Azure portal when you need to watch application behavior during testing or incident response.
- **Combine portal and kubectl:** Use the portal for visual dashboards and historical trends, and use kubectl for targeted queries and scripted automation.
- **Include correlation data in logs:** Add request identifiers, model names, and version information to log entries so you can trace problematic inference calls.
- **Prefer structured logging:** Emit logs in structured formats that are easier to query and filter in both the portal and command-line tools.
- **Measure against service objectives:** Define latency and error budget targets for your AI services and select metrics that indicate when you approach those thresholds.
