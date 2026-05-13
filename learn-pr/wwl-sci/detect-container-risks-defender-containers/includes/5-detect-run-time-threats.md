Vulnerability scanning tells you what's in your images. Runtime threat detection tells you what's happening in your clusters right now. These two capabilities answer different questions—and together they provide layered coverage across the container security lifecycle. Defender for Containers addresses both, and adds a third layer: gated deployment prevents misconfigured workloads from reaching production in the first place.

This unit covers three of the four protection pillars introduced in unit 2. The following table shows which pillar and component each section uses.

| Section | Protection pillar | Component required |
|---|---|---|
| Control plane threat detection | Runtime threat protection | No component toggle—audit logs collected via Azure infrastructure agentlessly |
| Runtime threat alerts | Runtime threat protection | Defender sensor |
| Binary drift detection and blocking | Runtime threat protection | Defender sensor |
| Security posture recommendations | Security posture management | Kubernetes API access |
| Gated deployment | Gated deployment | Azure Policy |
| Alert forwarding | Spans all pillars | Microsoft Sentinel data connector / Defender XDR integration |

## Detect control plane threats through audit log analysis

Every AKS cluster maintains a Kubernetes audit log—a record of requests made to the API server. These logs capture control plane activity: who created a pod, which services account modified a ConfigMap, whether a user tried to list secrets in a namespace they don't own. Defender for Containers collects this data agentlessly through Azure infrastructure, with no sensor required.

Audit log analysis detects control plane threats such as:

- Suspicious access to sensitive Kubernetes objects (secrets, service accounts, cluster roles)
- Kubernetes API calls from unusual source IPs or at unusual times
- Attempts to create or modify resources that indicate cluster reconnaissance
- Privilege escalation through ClusterRoleBinding manipulation

When Defender for Cloud detects a suspicious pattern, it generates an alert with the API call details, the initiating identity, and the affected resource. These alerts surface in the Defender for Cloud **Security alerts** screen and are forwarded to Microsoft Sentinel and Microsoft Defender XDR when those integrations are configured.

## Identify runtime threats with the Defender sensor

While audit log analysis covers the control plane, the Defender sensor covers workload behavior at the node level. The sensor uses eBPF (extended Berkeley Packet Filter) technology to observe process execution, network connections, and file system activity across all containers running on each AKS node.

Runtime alert categories include:

- **Suspicious process execution** - A process runs inside a container that isn't consistent with the container's normal behavior profile, such as a web application container spawning a shell.
- **Network anomaly detection** - A container initiates unexpected outbound connections, for example to a known command-and-control IP or to unusual external destinations.
- **Privilege escalation attempts** - A process inside a container attempts to gain elevated privileges, such as writing to `/etc/sudoers` or accessing privileged namespaces.
- **Crypto mining indicators** - Processes associated with cryptocurrency mining run inside a container, indicating potential resource hijacking.

Each alert includes the container name, node name, process details, network connection data (where applicable), and a severity level. The sensor generates these alerts in real time as it observes the behavior, not after a batch analysis cycle.

## Analyze and block binary drift

Binary drift occurs when a container runs an executable that wasn't part of the original container image. This matters because container images should be immutable—the code that passes security review and enters your registry should match what runs in production. Drift signals that something changed after the image was built and scanned.

Binary drift can be intentional and legitimate (a developer temporarily copying a diagnostic tool into a running container) or it can indicate an attack (malware injected into a running container after exploitation).

Defender for Containers detects binary drift using the Defender sensor. When the sensor observes a process starting from a binary not present in the original image, it generates a high-severity alert in the **Security alerts** screen. Binary drift blocking goes a step further—when you configure a blocking policy, the sensor prevents the unauthorized process from executing, not just alerting after the fact.

> [!NOTE]
> The **Containers drift policy** option is only visible in Environment settings when the Defender for Containers plan is enabled on the subscription. If you don't see it, enable the plan first.

To configure drift policies:

1. In Defender for Cloud, go to **Environment settings**.
2. Select **Containers drift policy**.
3. Select the rule you want to configure, or select the **Default binary drift** rule to set a subscription-wide default.
4. For each rule, define:
   - **Action** - Choose **Drift detection alert** to generate an alert, **Drift detection blocking** to block execution, or **Ignore drift detection** to exclude matched containers.
   - **Cloud scope** - Select the Azure subscriptions where the rule applies.
   - **Resource scope** - Add conditions based on container name, image name, namespace, pod labels, or cluster name to target specific workloads.
   - **Allowlist for processes** - Specify process names that are permitted to run even if they're not in the original image.
5. Order rules by priority. The highest-priority rule matching a given container is applied. If no rule matches, the default rule applies.
6. Select **Save**.

Policy updates propagate to protected clusters automatically after you save.

> [!NOTE]
> Binary drift **detection** (alerting) is generally available. Binary drift **blocking** is currently in preview and requires the Defender sensor deployed via Helm with sensor version 0.10.2 or later.

## Enforce security posture with CIS recommendations

Runtime threat detection responds to active attacks. Security posture management helps you eliminate the conditions that make attacks easier.

Defender for Containers evaluates your AKS cluster configurations against the Center for Internet Security (CIS) Kubernetes Benchmark—an industry-recognized set of security controls for Kubernetes environments. Findings appear as recommendations in the Defender for Cloud **Recommendations** screen.

To review container security posture recommendations:

1. In Defender for Cloud, select **Recommendations**.
2. Filter by **Resource type** and select **Kubernetes services**, or search for "Kubernetes".

Common recommendation categories include:

- **Pod security** - Containers running as root, containers with privileged access, writable root file systems
- **Network policies** - Namespaces or pods without network policy restrictions
- **RBAC** - Overly permissive ClusterRoleBindings, default service accounts with excessive permissions
- **Image security** - Container images not using a trusted registry, images with known vulnerabilities

Each recommendation shows the affected resources, the associated control identifier from the CIS benchmark, and remediation steps. Prioritize findings that appear on attack paths in Defender for Cloud (requires Defender CSPM).

## Gate deployments with Azure Policy admission control

Posture recommendations address existing misconfigurations. Gated deployment prevents new misconfigurations from entering your clusters.

The Azure Policy for Kubernetes add-on (deployed as part of the Defender for Containers plan) runs as a Kubernetes admission controller webhook. When a developer or pipeline submits a resource creation or update request to the AKS API server, the webhook intercepts the request and evaluates it against your Azure Policy assignments.

Two enforcement modes are available:

- **Audit mode** - Noncompliant deployments are logged and flagged in Defender for Cloud recommendations, but not blocked. Use this mode when first rolling out a policy to understand challenges before enforcement.
- **Deny mode** - Noncompliant deployments are rejected by the admission controller. The requesting user or pipeline receives an error message explaining which policy was violated.

For example, if you assign the policy "Kubernetes clusters shouldn't allow privilege escalation to root" in deny mode, any pod spec requesting `allowPrivilegeEscalation: true` is blocked from deploying to the cluster. This stops the misconfiguration before it becomes a live risk.

## Configure alert forwarding to Microsoft Sentinel and Defender XDR

Defender for Containers generates alerts in the Defender for Cloud **Security alerts** screen. For your SOC team to act on those alerts in their investigation tools, you need to configure forwarding to Microsoft Sentinel and Microsoft Defender XDR. This configuration is your responsibility as the engineer—alert routing doesn't happen automatically without the connectors in place.

**Connect Microsoft Sentinel:**

Microsoft Sentinel receives Defender for Cloud alerts through the **Microsoft Defender for Cloud** data connector.

1. In Microsoft Sentinel, go to **Content hub** and search for **Microsoft Defender for Cloud**.
2. Install the solution, then enable the **Tenant-based Microsoft Defender for Cloud** connector (or the subscription-based connector if you're scoping to specific subscriptions).
3. Select the subscriptions where Defender for Containers is enabled and select **Connect**.

**Connect Microsoft Defender XDR:**

Defender for Cloud integrates with Microsoft Defender XDR through the unified security operations platform. To verify this integration is active, open the Microsoft Defender portal, go to **Settings** > **Microsoft Defender XDR**, and confirm **Microsoft Defender for Cloud** appears as a connected data source [REVIEW: Verify exact settings path in current Defender portal UI].

**Verify alert flow:**

After enabling both connectors, confirm alerts are flowing correctly. Review an existing alert in the Defender for Cloud **Security alerts** screen, then verify the same alert appears in Microsoft Sentinel and in the Defender XDR incidents queue. If alerts aren't appearing, check that the connector is enabled for the correct subscriptions and that the Log Analytics workspace is associated with your Microsoft Sentinel instance.

For Contoso Retail, this configuration ensures that container runtime alerts don't stay isolated in Defender for Cloud. The SOC team can investigate them alongside identity and network signals in the tools they already use.
