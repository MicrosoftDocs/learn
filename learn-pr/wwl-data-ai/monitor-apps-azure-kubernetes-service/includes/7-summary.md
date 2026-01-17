In this module, you learned how to monitor and troubleshoot AI applications that run on Azure Kubernetes Service (AKS). You saw how logs, metrics, and events help you understand workload behavior and detect issues before they become incidents.

You explored how to use both the Azure portal and `kubectl` to observe application health. The Azure portal provides visual tools like the Workloads section, Live Logs, and Container insights for quick inspection and real-time monitoring. You also learned how to use `kubectl logs` and `kubectl top` for targeted command-line investigation. You examined practical workflows for describing pods and Services, inspecting events, and debugging from inside containers using both the portal Console feature and `kubectl exec`.

You learned how to troubleshoot pods and Services using the Diagnose and solve problems option for guided diagnostics and `kubectl describe` for detailed resource inspection. Additionally, you learned how to verify connectivity paths between clients and AI endpoints. You used the Services and ingresses section in the Azure portal to review Service configuration and EndpointSlices, and you used `kubectl` to check EndpointSlices and test connectivity with port-forwarding.

In the exercise, you deployed a sample AI-style application to AKS. You practiced monitoring logs and metrics, troubleshooting a simulated configuration issue, and confirming end-to-end connectivity using both the Azure portal and command-line tools. These skills help you keep AI workloads reliable and observable in production.

## Additional resources

- [Azure Kubernetes Service (AKS) documentation](/azure/aks/)
- [Monitor Azure Kubernetes Service (AKS) with Azure Monitor](/azure/aks/monitor-aks)
- [AKS Diagnose and Solve Problems](/azure/aks/aks-diagnostics)
- [Troubleshoot applications on Azure Kubernetes Service (AKS)](/azure/aks/troubleshooting)
