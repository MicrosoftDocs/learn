## The credential management problem in Kubernetes

Containerized workloads frequently need to authenticate to Azure services—querying Azure Storage, calling Azure OpenAI, reading from Azure SQL, or retrieving secrets from Azure Key Vault. The traditional approach stored credentials for these services as Kubernetes secrets and mounted them into pods as environment variables or files. This approach creates persistent problems.

Kubernetes secrets are base64-encoded, not encrypted by default. They persist in the cluster indefinitely unless explicitly removed. Service principal credentials expire, get rotated, or get revoked, and each event requires updating both the source credential and the Kubernetes secret—often through a manual process coordinated across every pod using them. The result is credentials scattered across namespaces, with unclear ownership, inconsistent rotation, and no automated expiration. A single compromised pod can exfiltrate secrets that persist long after the workload is gone.

## Use Microsoft Entra Workload ID to eliminate stored credentials

Microsoft Entra Workload ID solves the credential problem by replacing stored credentials with federated identity. Instead of a password or client secret stored in the cluster, a pod presents its Kubernetes service account token—a short-lived token issued by the Azure Kubernetes Service (AKS) cluster's OpenID Connect (OIDC) endpoint—and exchanges it for a Microsoft Entra ID access token. No credentials are ever stored in the cluster.

The exchange works through five components working together:

- **AKS OIDC issuer**: Every AKS cluster exposes an OIDC issuer URL that Microsoft Entra trusts as an identity provider. Enable it at cluster creation or on an existing cluster with `--enable-oidc-issuer`.
- **Kubernetes service account annotation**: A service account in the cluster is annotated with the client ID of a Microsoft Entra application registration (`azure.workload.identity/client-id`).
- **Federated identity credential**: A federated identity credential is configured on the app registration. It specifies the AKS OIDC issuer URL as the trusted issuer and the service account namespace and name as the subject—for example, `system:serviceaccount:retail-app:payment-svc`.
- **Workload identity webhook**: The Azure Workload Identity webhook is a mutating admission controller that intercepts pod creation. For pods using an annotated service account, it injects the required environment variables - `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_FEDERATED_TOKEN_FILE` - and mounts a projected service account token as a file.
- **Token exchange at runtime**: When the workload calls the Azure Identity SDK using `DefaultAzureCredential` or `WorkloadIdentityCredential`, the SDK reads the projected token file and presents it to the Microsoft Entra token endpoint. Microsoft Entra validates the token against the federated credential configuration and returns a scoped access token.

The pod never holds a password, client secret, or certificate. Access tokens are short-lived, generated on demand, and scoped to the requested Azure resource.

Enable OIDC issuer and workload identity on a cluster:

```azurecli
az aks update \
  --resource-group <resource-group> \
  --name <cluster-name> \
  --enable-oidc-issuer \
  --enable-workload-identity
```

## Mount Key Vault secrets directly into pods

The Azure Key Vault Secrets Store Container Storage Interface (CSI) Driver extends workload identity to secret retrieval. Instead of storing sensitive values as Kubernetes secrets and mounting them as environment variables, the CSI driver mounts Key Vault secrets, certificates, and keys directly into pods as volumes. Secret values are never written to etcd.

The driver uses workload identity to authenticate to Key Vault. You define a `SecretProviderClass` that maps Key Vault objects to the mount path, and the driver retrieves them when the pod starts:

```yaml
apiVersion: secrets-store.csi.x-k8s.io/v1
kind: SecretProviderClass
metadata:
  name: keyvault-secrets
  namespace: retail-app
spec:
  provider: azure
  parameters:
    usePodIdentity: "false"
    clientID: <workload-identity-client-id>
    keyvaultName: <key-vault-name>
    tenantID: <tenant-id>
    objects: |
      array:
        - |
          objectName: connection-string
          objectType: secret
```

The pod mounts the `SecretProviderClass` as a CSI volume. The connection string is available at the mount path as a file, and it never appears in Kubernetes secrets or etcd.

> [!TIP]
> The Secrets Store CSI Driver can also sync Key Vault secrets to Kubernetes secrets for applications that require environment variable injection. Use this option only when necessary—the CSI volume mount approach keeps secrets out of etcd entirely.

## Authenticate to Azure Container Registry without pull secrets

Image pull secrets store container registry credentials in the cluster. When a node pulls an image, it authenticates using the secret—which must be valid, current, and accessible. If the secret expires or is deleted, image pulls fail.

Attach an Azure Container Registry (ACR) to an AKS cluster and the cluster's managed identity handles authentication automatically:

```azurecli
az aks update \
  --resource-group <resource-group> \
  --name <cluster-name> \
  --attach-acr <acr-name>
```

This grants the cluster's managed identity the `AcrPull` role on the registry. Node image pulls use the managed identity—no `imagePullSecret` is needed in pod specifications.

## Apply workload identity to AI agent workloads

Workload identity is especially important for AKS-hosted AI agents—orchestrators, function-calling services, or automation workflows that invoke Azure OpenAI, Azure AI Foundry, or Azure Cognitive Services APIs. Without workload identity, teams typically store API keys as Kubernetes secrets. Those keys don't expire automatically, can be copied out of the cluster, and create rotation dependencies that are difficult to manage at scale.

With workload identity, an AI agent pod authenticates as a Microsoft Entra application registration and calls Azure OpenAI using a short-lived, scoped access token. The token can't be reused for other resources, expires automatically, and the pod never holds a credential that could be extracted and used elsewhere. Combine workload identity with Azure RBAC on the Azure OpenAI resource—grant the **Cognitive Services OpenAI User** role to the workload identity's app registration rather than sharing a key. This gives the agent least-privilege access that you can audit, rotate, and revoke independently.
