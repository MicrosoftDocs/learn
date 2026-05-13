Azure container services give development teams the ability to build, store, and run applications in isolated, portable environments. Container registries hold the images that workloads depend on, container instances run those images as short-lived or long-running jobs, and container app environments provide a managed platform for microservices at scale. Each layer introduces a distinct set of security controls that must be configured intentionally—container services aren't secure by default.

Contoso Retail runs a significant portion of its e-commerce platform on Azure container services, and a recent security review uncovered three gaps. The container registry relies on its built-in admin account for authentication. That account gives every developer and pipeline the same set of credentials with full registry access, and no individual action is traceable back to a specific identity. The Container Instances workloads that manage inventory data pass database connection strings as plain-text environment variables in ARM templates checked into source control, making every secret visible to anyone with repository access. And the Container Apps environment serving customer-facing APIs has external ingress enabled for every service, including internal backend services that should never be reachable from the public internet.

These three gaps follow the same pattern: default credential access, plaintext secret handling, and unrestricted network exposure. The controls to close them follow a matching pattern: disable default credentials, use managed identities for authentication, apply network isolation, and store secrets in Azure Key Vault.

This module addresses all three layers. You implement RBAC, private endpoints, and content trust for Azure Container Registry; apply managed identities and virtual network integration for Azure Container Instances; and configure ingress controls, managed identities, and Key Vault-based secrets management for Azure Container Apps environments.

## Learning objectives

After completing this module, you'll be able to:

- Implement access controls and network isolation for Azure Container Registry
- Configure security controls for Azure Container Instances workloads
- Apply ingress controls, managed identity, and secrets management for Azure Container Apps
