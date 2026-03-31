In this module, you learned how to externalize configuration with ConfigMaps. You saw how to inject values as environment variables or mount them as files. You also explored using Secrets to protect API keys and connection strings. The `secretKeyRef` field lets you inject sensitive values securely at Pod start. You attached persistent storage using PersistentVolume and PersistentVolumeClaim. You learned how to choose access modes based on your read and write patterns. You also considered `StorageClass` options for different performance needs. Finally, you practiced applying these configurations on Azure Kubernetes Service with `kubectl`. You verified that Pods received the correct configuration and that storage persisted across Pod restarts.

## Additional resources

- [Kubernetes ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap/) - Store and consume non-sensitive configuration
- [Kubernetes Secrets](https://kubernetes.io/docs/concepts/configuration/secret/) - Manage sensitive data securely
- [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) - Provide durable storage for workloads
- [AKS concepts and features](/azure/aks/) - Azure Kubernetes Service documentation