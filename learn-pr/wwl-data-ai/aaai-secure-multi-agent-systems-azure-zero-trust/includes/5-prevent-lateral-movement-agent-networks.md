In traditional software architectures, a compromised component can communicate freely with other components on the same network. If an attacker gains code execution in one service, they often pivot to other services laterally—moving through the network to access progressively more valuable resources. Zero-trust network controls prevent this lateral movement: a compromised agent should not be able to communicate with agents it doesn't have a legitimate business reason to reach.

| Network Control | Defense Mechanism | Implementation Technology |
|----------------|-------------------|--------------------------|
| Network policies | Explicit allow-list for pod-to-pod traffic | Kubernetes NetworkPolicy, Azure CNI |
| Private endpoints | No public IP exposure for internal services | Azure Private Link |
| Mutual TLS | Cryptographic authentication of both caller and receiver | Service mesh (Istio, Linkerd) |
| Traffic monitoring | Anomaly detection for unexpected communication patterns | Azure Sentinel, network flow logs |

## Define network policies with explicit allow-lists

The default Kubernetes network behavior allows all pods to communicate with all other pods. This "implicit allow" model enables lateral movement. Replace it with explicit deny-all followed by specific allow rules for legitimate agent communication paths.

In Fabrikam's code review system, the orchestrator agent legitimately calls specialist agents (security scanner, style checker, syntax analyzer). Those specialist agents should not be able to call each other—there's no business reason for the security scanner to communicate with the style checker. A compromised security scanner should be isolated, not able to pivot to other agents.

Implement network policies in Azure Kubernetes Service (AKS) with Azure CNI and NetworkPolicy support:

```yaml
# network-policies/deny-all-default.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all-agent-traffic
  namespace: agents
spec:
  podSelector: {}  # Apply to all pods in namespace
  policyTypes:
  - Ingress
  - Egress
  ingress: []  # Deny all ingress traffic
  egress:
  - to:
    - namespaceSelector:
        matchLabels:
          name: kube-system
    ports:
    - protocol: TCP
      port: 53  # Allow DNS
    - protocol: UDP
      port: 53
```

This default policy denies all traffic between agent pods. Then add specific allow rules for each legitimate communication path:

```yaml
# network-policies/allow-orchestrator-to-specialists.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-orchestrator-to-specialists
  namespace: agents
spec:
  podSelector:
    matchLabels:
      agent-role: specialist  # security-scanner, style-checker, etc.
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          agent: orchestrator
    ports:
    - protocol: TCP
      port: 8000
```

This policy allows ingress traffic to specialist agents only from the orchestrator pod, only on port 8000. If the security scanner tries to call the style checker, the network policy blocks the connection.

For agents deployed in Azure Container Apps, use built-in ingress controls:

```azurecli
# Configure internal ingress only - no public access
az containerapp create \
  --name fabrikam-security-scanner \
  --resource-group fabrikam-agents-production \
  --environment fabrikam-containerapp-env \
  --image fabrikam.azurecr.io/security-scanner:latest \
  --ingress internal \
  --target-port 8000
```

Internal ingress means the agent is accessible only from within the Container Apps environment—not from the public internet.

## Eliminate public endpoints with private networking

Agents that don't need external access should never have public IP addresses or public endpoints. All agent-to-agent communication happens over private virtual network connections. External access to the system flows through a single controlled gateway (Azure API Management) that authenticates requests before routing to internal agents.

Configure Azure Private Link for services agents consume:

```azurecli
# Create private endpoint for Azure OpenAI used by agents
az network private-endpoint create \
  --name fabrikam-openai-private-endpoint \
  --resource-group fabrikam-agents-production \
  --vnet-name fabrikam-agents-vnet \
  --subnet agents-subnet \
  --private-connection-resource-id /subscriptions/<sub-id>/resourceGroups/<rg>/providers/Microsoft.CognitiveServices/accounts/fabrikam-openai \
  --group-id account \
  --connection-name fabrikam-openai-connection

# Disable public network access on Azure OpenAI
az cognitiveservices account update \
  --name fabrikam-openai \
  --resource-group fabrikam-agents-production \
  --public-network-access Disabled
```

With public access disabled and private endpoints configured, Azure OpenAI is accessible only from within the agent virtual network. Even if an attacker compromises a component outside the network, they can't reach Azure OpenAI to steal model access.

Apply the same pattern to all agent dependencies:

- **Azure AI Foundry projects**: Private endpoint for project API
- **Azure Cosmos DB**: Private endpoint for database access
- **Azure Blob Storage**: Private endpoint for data storage
- **Azure Key Vault**: Private endpoint for secrets retrieval

Build a comprehensive private network topology where no agent service has public network exposure except the API Management gateway that fronts the entire system.

## Enforce mutual TLS between all agent services

Network policies control which agents can communicate. Mutual TLS (mTLS) controls how they communicate: every connection is encrypted AND both the client and server authenticate each other using certificates. A compromised agent can't impersonate another agent without possessing that agent's certificate.

Deploy a service mesh in AKS to enforce mTLS automatically. Istio and Linkerd provide mTLS without modifying application code—the service mesh sidecars handle certificate management and TLS negotiation.

Deploy Linkerd OSS to the Fabrikam AKS cluster:

```bash
# Install Linkerd CLI
curl -sL https://run.linkerd.io/install | sh

# Install Linkerd control plane
linkerd install | kubectl apply -f -

# Verify installation
linkerd check

# Enable mTLS for agents namespace
kubectl annotate namespace agents linkerd.io/inject=enabled
```

Once the namespace has the Linkerd injection annotation, every new pod deployment automatically gets a Linkerd proxy sidecar. The sidecar intercepts all network traffic and enforces mTLS:

```yaml
# agents/deployments/security-scanner.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: security-scanner
  namespace: agents
spec:
  template:
    metadata:
      labels:
        app: security-scanner
      # Linkerd automatically injects proxy - no manual sidecar configuration needed
    spec:
      containers:
      - name: scanner
        image: fabrikam.azurecr.io/security-scanner:latest
        ports:
        - containerPort: 8000
```

When the security scanner calls the orchestrator, the mTLS flow looks like this:

1. Security scanner application sends HTTP request to orchestrator
2. Security scanner's Linkerd proxy intercepts the request
3. Proxy establishes mTLS connection to orchestrator's Linkerd proxy
4. Both proxies exchange and validate certificates
5. If certificates are valid, encrypted request flows to orchestrator
6. Orchestrator's proxy decrypts and forwards to application container

The application code sees standard HTTP—the service mesh handles all cryptographic operations transparently. An attacker who compromises an agent and tries to call another agent can't succeed without the agent's certificate, which is managed by the service mesh and rotated automatically.

## Monitor for anomalous lateral communication

Define a baseline communication graph: which agents normally communicate with which other agents. In Fabrikam's system, the baseline includes:

- Orchestrator → Security scanner
- Orchestrator → Style checker
- Orchestrator → Syntax analyzer
- Reporting agent → Orchestrator
- All agents → Azure OpenAI (via private endpoint)

Monitor network traffic and alert on any communication that deviates from the baseline. If the security scanner suddenly starts communicating with the reporting agent—a path that doesn't exist in the baseline—it indicates potential lateral movement by an attacker.

Implement baseline monitoring using Azure Network Watcher flow logs and Azure Sentinel:

```azurecli
# Enable flow logs for agent subnet
az network watcher flow-log create \
  --name fabrikam-agents-flow-log \
  --nsg fabrikam-agents-nsg \
  --storage-account fabrikamflowlogs \
  --enabled true \
  --retention 90 \
  --log-version 2 \
  --traffic-analytics true \
  --workspace /subscriptions/<sub-id>/resourceGroups/<rg>/providers/Microsoft.OperationalInsights/workspaces/fabrikam-sentinel
```

Create a Sentinel analytics rule that detects unexpected agent-to-agent communication:

```kusto
// Sentinel KQL query: Detect lateral movement between agents
let baseline_paths = dynamic([
    {"source": "orchestrator", "destination": "security-scanner"},
    {"source": "orchestrator", "destination": "style-checker"},
    {"source": "orchestrator", "destination": "syntax-analyzer"},
    {"source": "reporting", "destination": "orchestrator"}
]);
AzureNetworkFlowLog
| where ResourceGroup == "fabrikam-agents-production"
| where SubnetName == "agents-subnet"
| extend source_agent = extract(@"fabrikam-([a-z-]+)-prod", 1, SourceIP)
| extend dest_agent = extract(@"fabrikam-([a-z-]+)-prod", 1, DestinationIP)
| where isnotempty(source_agent) and isnotempty(dest_agent)
| extend communication_path = pack("source", source_agent, "destination", dest_agent)
| where communication_path !in (baseline_paths)
| summarize Count=count(), FirstSeen=min(TimeGenerated), LastSeen=max(TimeGenerated) by source_agent, dest_agent, SourceIP, DestinationIP
| where Count > 5  // Filter noise - alert if anomalous path used more than 5 times
| project FirstSeen, source_agent, dest_agent, Count, SourceIP, DestinationIP
```

This query identifies agent-to-agent traffic that doesn't match the baseline and generates alerts for investigation. Security teams can investigate whether the new communication path is legitimate (perhaps a new feature was deployed that requires it) or malicious (lateral movement by an attacker).

Combine network policies, private endpoints, mutual TLS, and anomaly monitoring to create defense in depth. An attacker must bypass multiple independent security controls to achieve lateral movement. Even if one control fails, others contain the breach.

With network lateral movement defenses in place, the next security layer is multi-tenant data isolation—ensuring that customer data stays strictly separated even when agents serve multiple customers from shared infrastructure.

## Unit summary

- **Explicit allow-list network policies** deny all traffic by default and permit only known, necessary agent-to-agent communication paths.
- **Private endpoints** eliminate public-facing agent APIs, routing all traffic through Azure Private Link within virtual networks.
- **Mutual TLS** between all agent services ensures both sides of every connection authenticate, preventing man-in-the-middle interception.
- **Anomaly monitoring** detects unusual lateral communication patterns (new destinations, unusual protocols, traffic volume spikes) as early indicators of compromised agents.
