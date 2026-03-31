AI applications on Azure need reliable monitoring and fast troubleshooting to meet user expectations. These workloads often run as services and background workers on Azure Kubernetes Service (AKS). Monitoring and debugging applications on AKS help you spot issues such as latency spikes, failed inference calls, and resource saturation before they affect users.

AKS provides multiple ways to monitor and troubleshoot applications. The Azure portal offers visual tools like the Workloads blade, Live Logs, and the Diagnose and solve problems feature for quick inspection and guided troubleshooting. For detailed investigation, `kubectl` commands give you direct access to cluster resources, logs, and events. Many developers use both approaches together—the portal for visual assessment and `kubectl` for in-depth analysis.

Imagine you deploy a model inference API and a background worker that enriches data for a recommendation system. Both components run on AKS and must stay responsive as traffic changes. When errors or slowdowns occur, you need to understand whether the problem comes from the application code, Kubernetes configuration, or the underlying cluster. By learning how to monitor logs and metrics, inspect pods and Services, and verify connectivity using both the Azure portal and command-line tools, you can keep AI workloads healthy on AKS.

## After completing this module, you'll be able to:

- Explain which monitoring signals matter for AI applications on AKS
- Use the Azure portal and `kubectl` commands to inspect application logs and metrics
- Troubleshoot pod and Service issues using visual tools and command-line investigation
- Verify Service and ingress connectivity so clients can reach AI endpoints
- Apply a structured workflow to deploy, monitor, and debug applications on AKS

> [!NOTE]
> All commands and patterns in this module use current AKS and Kubernetes concepts. You should validate resource definitions and flags against official Kubernetes and Azure Kubernetes Service documentation when you adapt examples to your environment.
