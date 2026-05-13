Contoso Retail's security review identified three container security gaps—a registry using shared admin credentials, container workloads passing secrets as plain-text environment variables, and a Container Apps environment with unrestricted public ingress on every service. This module closed each gap using the same set of controls that apply across all three Azure container service layers.

## What you accomplished

You secured Azure Container Registry by disabling the admin account and replacing it with RBAC role assignments scoped to specific identities and operations. Developers and pipelines now authenticate with Microsoft Entra ID identities, and every registry action is attributable to a specific user or workload. Scope map tokens gave CI/CD pipelines the minimum permissions needed for their specific repository without granting access to the rest of the registry. Private endpoints removed public network access to the registry, and content trust established the requirement that images must be cryptographically signed before they can be stored.

For Azure Container Instances, you assigned managed identities to container groups and replaced plain-text environment variables with Key Vault secret references that the managed identity retrieves at runtime. The deployment manifest no longer contains sensitive values, and the secret values aren't visible in Azure portal metadata or API responses. Containers now run in a virtual network with private IP addresses, operate as nonroot users, and use read-only root filesystems.

In Azure Container Apps, you separated services by trust level across environments, assigned managed identities for image pull and Key Vault access, and configured internal ingress to keep backend APIs off the public internet. Key Vault references replaced environment-level secrets for connection strings and credentials. For services using Dapr, automatic mutual TLS encrypted all service-to-service communication without certificate management or application code changes.

## Learn more

- [Azure Container Registry authentication overview](/azure/container-registry/container-registry-authentication)
- [Use managed identities with Azure Container Instances](/azure/container-instances/container-instances-managed-identity)
- [Managed identities in Azure Container Apps](/azure/container-apps/managed-identity)
