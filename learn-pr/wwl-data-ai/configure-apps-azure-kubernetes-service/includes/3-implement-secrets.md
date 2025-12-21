AI applications often call external services and model endpoints. These services require keys and credentials to authenticate requests. Kubernetes Secrets store sensitive values, such as connection strings and API keys. Secrets keep credentials out of source control and container images. They help you follow security guidance for Azure workloads. For production scenarios with strict compliance requirements, consider integrating with Azure Key Vault. The Key Vault CSI driver provides centralized secret management and automated rotation.

> [!NOTE]
> Examples use Kubernetes Secrets in opaque form. For production scenarios on Azure, consider integrating with Azure Key Vault and CSI driver as appropriate.

## Create a Secret

You can create a Secret directly with `kubectl` using the `create secret` command. This approach takes literal values from the command line. You can also create Secrets from files or define them in YAML manifests. Use manifests when you manage resources through a GitOps workflow. The opaque Secret type works for most string values like API keys and passwords. Kubernetes provides other Secret types for specific use cases. Use `kubernetes.io/dockerconfigjson` for container registry credentials. Use `kubernetes.io/tls` for TLS certificates and keys. Secret manifests are typically stored in a file named *secret.yaml*.

```bash
kubectl create secret generic app-secrets \
  --from-literal=DB_CONNECTION="Host=db;User=app;Password=secure" \
  --from-literal=API_KEY="your-api-key"
```

## Reference Secret values in a Deployment

After you create a Secret, you reference it in your Deployment manifest. Use the `valueFrom` field with `secretKeyRef` to point to specific keys in the Secret. When a Pod starts, Kubernetes reads the Secret and injects the values as environment variables in the container. The values remain in memory and are not written to disk by default. After deployment, validate that Pods receive the expected values. Check your application logs or use `kubectl exec` to inspect the environment. Also confirm that RBAC policies restrict who can view the Secret. Only service accounts and users with appropriate permissions should have access.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-api
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web-api
  template:
    metadata:
      labels:
        app: web-api
    spec:
      containers:
      - name: api
        image: myregistry.azurecr.io/web-api:v1
        env:
        - name: DB_CONNECTION
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: DB_CONNECTION
        - name: API_KEY
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: API_KEY
```

## Verify with kubectl

You can list and describe resources to confirm the Secret exists and Pods receive the expected configuration. Use `kubectl get secrets` to list all Secrets in the current namespace. The output shows the Secret name, type, data field count, and age. Use `kubectl describe secret` with the Secret name to see metadata and keys without exposing actual values. The describe command shows which keys exist in the Secret but masks the sensitive data for security. You can also describe the Deployment to verify that the Pod template references the correct Secret and keys. Look for the `secretKeyRef` entries in the environment variable section to confirm the mappings are correct. These manifests are typically stored in files named *deployment.yaml* (Deployment) and *secret.yaml* (Secret).

```bash
kubectl get secrets
kubectl describe secret app-secrets
kubectl describe deployment web-api
```

## Integrate with Azure services for centralized secret management

Production AI workloads on Azure often require centralized secret management with audit trails and compliance features. Azure provides two primary options for managing secrets and configuration data in AKS clusters. Each option offers different capabilities suited to specific scenarios.

Azure Key Vault provides dedicated secret storage with enterprise-grade security features. The Secrets Store CSI Driver mounts secrets from Key Vault directly into Pod filesystems as files. Secrets remain in Key Vault and sync to containers when Pods start. The driver polls for changes and updates mounted secrets automatically without Pod restarts. Key Vault supports automated rotation, detailed audit logging, and private endpoints for network isolation. This approach works well when you need strict compliance controls and want secrets to stay in a dedicated vault. For implementation details, visit [Use the Azure Key Vault provider for Secrets Store CSI Driver](/azure/aks/csi-secrets-store-driver).

Azure App Configuration stores references to secrets in Key Vault rather than the secrets themselves. The [App Configuration Kubernetes Provider](/azure/azure-app-configuration/quickstart-azure-kubernetes-service) runs in your cluster, reads those Key Vault references from App Configuration, and resolves them by fetching the actual secret values from Key Vault. The App Configuration Kubernetes Provider then generates native Kubernetes Secret resources containing the resolved values. This pattern lets you manage which secrets each application uses centrally in App Configuration while keeping actual secret values in Key Vault. Applications receive secrets as standard Kubernetes resources without authenticating directly to Key Vault or App Configuration.

Choose direct Key Vault integration when you need fine-grained audit trails for each secret access and want secrets to remain exclusively in the vault. Choose App Configuration with Key Vault references when you want to manage secret mappings centrally and provide secrets to applications as standard Kubernetes resources.

## Best practices

Handling secrets securely on Azure Kubernetes Service (AKS) requires careful planning:

- **Restrict access with RBAC:** Grant Secret view and modify permissions only to service accounts and users that need them.
- **Avoid source control exposure:** Never commit Secret manifests with literal values. Create Secrets directly in the cluster or use external secret management tools.
- **Rotate credentials regularly:** Update secrets periodically to reduce risk. Trigger Deployment rollouts after updates so Pods receive new values.
- **Integrate with Azure Key Vault for production:** Use the Key Vault CSI driver for automated rotation, detailed audit trails, and secrets that stay in a dedicated vault. The CSI driver syncs rotated secrets automatically without manual Kubernetes updates.
- **Centralize secret mappings with App Configuration:** Use App Configuration with Key Vault references when you want to manage which secrets each application uses from a central location while keeping actual values in Key Vault.
- **Enable encryption at rest:** Configure etcd encryption when you create your cluster for an extra layer of protection. Combine with Key Vault integration for comprehensive security including rotation and audit capabilities.
