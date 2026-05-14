## Choose the right API server isolation model

The Azure Kubernetes Service (AKS) API server is the single control plane endpoint for your cluster. It receives every kubectl command, admits every workload, and processes every configuration change. Exposing it to the public internet expands your attack surface to every IP address on the internet. AKS provides two controls for restricting API server access: **private clusters** and **authorized IP ranges**. The right choice depends on your architecture and risk tolerance.

## Remove the API server from the internet with a private cluster

A private AKS cluster removes the API server from the public internet entirely. Instead of a public IP address, the API server receives a private IP address within your virtual network. DNS resolution for the API server FQDN returns the private address, so the endpoint is reachable only from within the virtual network or from connected networks—on-premises networks via VPN or ExpressRoute, or peered virtual networks.

Private clusters are the right choice when your compliance requirements mandate private-only infrastructure, when your workloads require the highest level of network segmentation, or when you need to ensure cluster administration only happens from trusted network locations.

Create a private cluster with the `--enable-private-cluster` flag:

```azurecli
az aks create \
  --resource-group <resource-group> \
  --name <cluster-name> \
  --enable-private-cluster \
  --enable-aad \
  --aad-admin-group-object-ids <group-object-id>
```

> [!NOTE]
> After creating a private cluster, you can't access the API server from outside the virtual network or a connected network. Plan your administrative access model—a bastion host, a jumpbox VM, or self-hosted build agents inside the virtual network—before enabling private cluster mode.

## Restrict API server access with authorized IP ranges

For clusters that can't be private—because CI/CD pipelines, partner access patterns, or operational requirements need internet-accessible endpoints—authorized IP ranges provide a significant attack surface reduction. You specify a list of IP addresses and CIDR ranges permitted to reach the API server. The network layer rejects connections from every other source address.

Authorized IP ranges don't remove the public endpoint. The API server keeps its public IP address and DNS resolves to a public address. However, an attacker who obtains valid credentials can only use them from an IP address in the allow list.

```azurecli
az aks update \
  --resource-group <resource-group> \
  --name <cluster-name> \
  --api-server-authorized-ip-ranges "203.0.113.0/24,198.51.100.10/32"
```

Update the allow list as your administrative infrastructure changes. Include VPN egress addresses, build agent IP ranges, and administrator workstation addresses. Review the list regularly to remove stale entries.

## Control pod-to-pod traffic with network policies

API server controls protect the control plane. Network policies protect traffic between workloads inside the cluster. By default, every pod in an AKS cluster can communicate with every other pod—no namespace boundary or workload label restricts internal traffic. A Kubernetes **NetworkPolicy** changes this default by defining explicit ingress and egress rules for selected pods. All traffic that doesn't match an allowed rule is denied.

The following NetworkPolicy restricts the backend service so it accepts inbound connections only from pods in the same namespace that carry the `app: frontend` label:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend-to-backend
  namespace: retail-app
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: frontend
    ports:
    - protocol: TCP
      port: 8080
```

This policy applies to any pod labeled `app: backend` in the `retail-app` namespace. The only permitted inbound traffic is TCP on port 8080 from pods labeled `app: frontend`. All other ingress is denied.

## Block access to the Azure Instance Metadata Service

The Azure Instance Metadata Service (IMDS) runs at `169.254.169.254` on every Azure VM, including AKS nodes. It provides node configuration information and, critically, the ability to retrieve access tokens for the node's managed identity. A workload in a pod can query IMDS and obtain the node's managed identity token—gaining the same Azure permissions as the node itself.

Block pod egress to the IMDS endpoint with an explicit NetworkPolicy:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: block-imds
  namespace: retail-app
spec:
  podSelector: {}
  policyTypes:
  - Egress
  egress:
  - to:
    - ipBlock:
        cidr: 0.0.0.0/0
        except:
        - 169.254.169.254/32
```

The empty `podSelector: {}` applies this policy to all pods in the namespace. The egress rule allows all outbound traffic except connections to `169.254.169.254/32`. Apply this policy in every application namespace.

## Enable network policies at cluster creation

Network policies require a network policy engine deployed in the cluster. AKS supports three network policy engines:

| Engine | Description | Use when |
|---|---|---|
| **Cilium** (recommended) | eBPF-based engine included with Azure CNI Powered by Cilium. Supports standard Kubernetes NetworkPolicy objects plus extended L7 policies and FQDN filtering via ACNS. Better performance and scalability than iptables-based solutions. | New clusters—recommended for all new AKS deployments |
| **Azure Network Policy Manager (NPM)** | iptables-based engine for Linux; HNS ACLPolicies for Windows. | Windows node pool support required |
| **Calico** | Open-source iptables-based engine. | Cross-cloud compatibility with non-Azure environments |

> [!NOTE]
> You can add or change a network policy engine on an existing cluster using `az aks update --network-policy <engine>`. This triggers node pool reimaging—similar to a Kubernetes version upgrade—but doesn't require cluster recreation.

Create a cluster with Cilium (Azure CNI Powered by Cilium—recommended for new deployments):

```azurecli
az aks create \
  --resource-group <resource-group> \
  --name <cluster-name> \
  --network-plugin azure \
  --network-plugin-mode overlay \
  --network-dataplane cilium
```

Or use the Azure network policy plugin for Windows node pool support:

```azurecli
az aks create \
  --resource-group <resource-group> \
  --name <cluster-name> \
  --network-plugin azure \
  --network-policy azure
```

Or use Calico for cross-cloud compatibility:

```azurecli
az aks create \
  --resource-group <resource-group> \
  --name <cluster-name> \
  --network-plugin azure \
  --network-policy calico
```

With a private cluster or authorized IP ranges protecting the API server, and network policies governing pod traffic, Contoso Retail's network attack surface is explicitly bounded. Traffic flows only where policy permits it.
