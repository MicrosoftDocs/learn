In this module, you learned how to create Kubernetes Deployment manifests. These manifests define container images, replicas, resource requirements, and environment variables for running containerized applications on AKS. You also explored how to expose applications using Kubernetes Services. You learned to choose between ClusterIP for internal access, NodePort for testing, and LoadBalancer for external production access with Azure-managed public IPs. Additionally, you learned how to deploy manifests using `kubectl apply` and verify deployment status by checking Pod and Service states. You practiced troubleshooting common issues like ImagePullBackOff, CrashLoopBackOff, and pending Pods using `kubectl logs` and `kubectl describe` commands. Finally, you deployed an AI inference API to AKS, exposed it through a LoadBalancer Service, and verified connectivity using the public IP address.

## Additional resources

- [Azure Kubernetes Service documentation](/azure/aks/) - Comprehensive AKS guides and best practices
- [Kubernetes official documentation](https://kubernetes.io/docs/) - Complete Kubernetes reference and concepts
- [kubectl cheat sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) - Quick reference for kubectl commands
- [AKS best practices](/azure/aks/operator-best-practices) - Production-ready practices for running applications on AKS
