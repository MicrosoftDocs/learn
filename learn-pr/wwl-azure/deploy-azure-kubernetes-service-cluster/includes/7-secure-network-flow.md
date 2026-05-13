Securing network flow into and out of an Azure Kubernetes Service (AKS) cluster involves multiple layers. Network flow can be categorized as:

- **Ingress traffic**: From the client, to the workload running in the cluster.
- **Egress traffic**: From a pod or node, in the cluster to an external service.
- **Pod-to-pod traffic**: Communication between pods. This traffic includes communication between the ingress controller and the workload. Also, if your workload is composed of multiple applications deployed to the cluster, communication between those applications would fall into this category.
- **Management traffic**: Traffic that goes between the client and the Kubernetes API server.

This architecture has several layers of security to secure all types of traffic.

:::image type="content" source="../media/network-traffic-ingress.svg" alt-text="Diagram that shows AKS ingress traffic through a WAF and egress traffic through Azure Firewall in a hub VNet.":::


## Ingress traffic flow

The architecture accepts only TLS-encrypted requests from the client. The Application Gateway is configured with the `AppGwSslPolicy20220101` predefined policy (or `AppGwSslPolicy20220101S` for a stricter cipher set, or an equivalent CustomV2 policy) to enforce TLS 1.2 as the minimum protocol version, with TLS 1.3 also enabled. Use host-specific multi-site HTTPS listeners for production sites so each TLS site is matched by SNI hostname. For no-SNI or IP-only clients on Application Gateway v2, configure a high-priority dummy multi-site HTTPS listener with a self-signed certificate and route it to a sinkhole backend. Use lower-priority wildcard or basic listeners only as catch-all routing after TLS listener selection. For background on multisite listeners, see [Application Gateway multiple site hosting](/azure/application-gateway/multiple-site-overview). The diagram shows the recommended production posture: end-to-end TLS from the client to the workload pod, with certificate material stored in Azure Key Vault.

:::image type="content" source="../media/traffic-ingress-configuration.svg" alt-text="Diagram that shows end-to-end TLS ingress from client to Application Gateway, ingress controller, and workload pod with Key Vault.":::


1.  The client sends an HTTPS request to `delta.contoso.com`. The name resolves through a DNS `A` record to the public IP address of Azure Application Gateway. Application Gateway presents the `delta.contoso.com` certificate from Azure Key Vault by using a user-assigned managed identity.
2.  Application Gateway terminates client TLS so its web application firewall (WAF) can inspect the request and routing rules can select the backend. It then re-encrypts the request and sends it over TLS to the AKS internal load balancer by using the backend certificate for `*.aks-ingress.contoso.com`.
3.  The internal load balancer forwards encrypted traffic to the in-cluster ingress controller. On the Application Gateway-to-ingress hop, the ingress controller presents the backend TLS certificate to Application Gateway. If the ingress controller then opens a TLS connection to the workload, the workload pod presents the certificate expected by the ingress controller. Mount each certificate in the component that presents it, for example by using the Azure Key Vault provider for Secrets Store CSI Driver.
4.  Certificate management path: Application Gateway retrieves listener certificates from Azure Key Vault (background certificate rotation, not per-request traffic). Grant its user-assigned managed identity the least privilege needed to read certificates, and manage certificate rotation in Key Vault.

> [!NOTE]
> TLS to the workload pod is recommended for sensitive workloads. If the workload doesn't support TLS termination, you can terminate TLS at the ingress controller and forward to the workload over HTTP within the cluster's private network, but the diagram in this unit shows the recommended end-to-end TLS configuration.

Application Gateway Ingress Controller (AGIC) runs in the cluster, monitors Kubernetes `Ingress` and `Service` resources, endpoint/pod state, and `Secret` state, and continuously configures Application Gateway through Azure Resource Manager. Application Gateway remains the ingress data plane. An in-cluster ingress controller, such as NGINX or Istio, is a proxy behind Application Gateway for cluster-local routing, TLS, or mesh policy. Application Gateway for Containers is the newer, next-generation Kubernetes load-balancing option from the Application Gateway family, and is positioned by Microsoft as the evolution of AGIC. It implements both the Kubernetes Gateway API and the Ingress API and provides near real-time pod and route updates. AGIC remains fully supported for existing deployments; choose Application Gateway for Containers for new workloads that benefit from Gateway API features or fine-grained traffic management.

## Egress traffic flow

Pods and nodes initiate outbound connections to Azure services and the internet. AKS also requires outbound dependencies for cluster operation, including image pulls from Microsoft Artifact Registry (`mcr.microsoft.com`), time servers, package repositories, and monitoring endpoints. Review required FQDNs and ports before you restrict egress.

Route egress through Azure Firewall in the hub virtual network. Apply a User-Defined Route (UDR) to the AKS cluster subnet so outbound traffic uses the firewall as the next hop. Configure Azure Firewall application rules for HTTP/HTTPS FQDN dependencies (such as `mcr.microsoft.com`, `management.azure.com`, and package repositories — the `AzureKubernetesService` FQDN tag covers most of these). Use network rules for the non-HTTP/S protocols required by your specific cluster configuration. For older public clusters without `konnectivity-agent`, allow UDP 1194 and TCP 9000 for tunneled node-to-control-plane communication. For clusters with `konnectivity-agent`, allow the API-server FQDN `*.hcp.<location>.azmk8s.io` over HTTPS 443 instead. Private clusters and clusters that use API Server VNet Integration don't require the public tunnel port rules. UDP 123 for NTP is only required for older Linux node images that don't use the Azure host time source. With the Azure Firewall DNS proxy enabled, FQDN-based matching also works in network rules. For the authoritative list of required egress endpoints for your cluster configuration, see [Outbound network and FQDN rules for AKS clusters](/azure/aks/outbound-rules-control-egress).

API Server VNet Integration, shown by the `snet-apiserver` subnet in the hub-spoke network diagram in the Plan the IP addresses unit, keeps node-to-API-server traffic on the customer's private network. [Network-isolated clusters](/azure/aks/concepts-network-isolated) can run without public outbound dependencies when required artifacts and control-plane dependencies are available privately. AKS supports two outbound types for this scenario: `none` (generally available) and `block` (in preview at the time of writing). The `block` outbound type is supported only for managed virtual network network-isolated clusters; for bring-your-own VNets, including hub-spoke topologies, use `none` with explicit egress controls such as NSGs, UDRs, and firewall rules.

## Management traffic and API server access

Management traffic includes administrator, automation, and node communication with the Kubernetes API server. Restrict the API server to trusted networks and identities.

- **API server authorized IP ranges**: For a public API server, allow only trusted source IP ranges.
- **Private cluster**: Use a private API server endpoint that is reachable only from peered or private networks, such as a hub virtual network, VPN, or Azure ExpressRoute.
- **API Server VNet Integration**: Project the API server into a delegated subnet in the customer virtual network so node-to-API-server traffic stays private.

## Pod-to-pod traffic and network policy

Use Kubernetes `NetworkPolicy` resources to restrict pod-to-pod traffic by namespace and label selectors. Start with least-privilege policies that allow only the protocols and ports each application needs.

Azure CNI Powered by Cilium is the recommended AKS option for a managed eBPF-based data plane and policy engine. Azure Network Policy Manager (NPM) and Calico are alternatives for supported network configurations, but NPM support ends on Windows nodes on September 30, 2026, and on Linux nodes on September 30, 2028. Validate the policy engine and data-plane choice at cluster creation. Migrating an existing supported cluster to Azure CNI Powered by Cilium is supported in place via `az aks update --name <cluster-name> --resource-group <resource-group> --network-dataplane cilium`. The operation simultaneously reimages all node pools and isn't supported on clusters with Windows node pools or Node Auto-Provisioning enabled. If you also need Azure CNI Overlay IPAM, after uninstalling or disabling NPM or Calico network policy if enabled, update the IPAM mode first as a separate, irreversible operation, then update the dataplane to Azure CNI Powered by Cilium. Choosing Cilium from day one avoids the migration disruption.

For service-to-service encryption, traffic management, and identity-aware policy, use a service mesh with mutual TLS (mTLS). AKS recommends the Istio-based service mesh add-on. The [Open Service Mesh (OSM) add-on for AKS retires on September 30, 2027](/azure/aks/open-service-mesh-about), and should not be used for new workloads.

## Private endpoints to Azure dependencies

Use Azure Private Link with private endpoints in `snet-privatelinkendpoints` to keep traffic to Azure Container Registry, Azure Key Vault, and other Azure dependencies on the private network. This pattern reduces exposure to public endpoints.

## NSG and firewall caveat

Use Network Security Groups (NSGs) for subnet boundary controls, but understand their limits. NSGs cannot enforce FQDN-based rules; use Azure Firewall application rules for FQDN-based egress control. Blocking traffic between AKS-internal subnets with NSGs or firewall rules is not supported and can break the cluster.
