Container image vulnerability assessment answers a fundamental question: does the image your team is about to deploy—or is already running in production—contain vulnerabilities that put your workloads at risk? Defender for Containers provides two scanning paths that together cover images in the registry and images running live in Azure Kubernetes Service (AKS) clusters.

## Examine how image scanning works

This section covers the **vulnerability assessment** pillar in practice. The two components that make scanning work are **Registry access** (for images stored in ACR) and **Kubernetes API access** or **Defender sensor** (for images running in AKS clusters).

| Scanning scope | Component required | Protection pillar |
|---|---|---|
| Images stored in ACR | Registry access | Vulnerability assessment |
| Images running in AKS | Kubernetes API access or Defender sensor | Vulnerability assessment |

Defender for Containers scans ACR images through two triggers, both managed automatically once the **Registry access** component is enabled.

**Push-triggered scanning** fires within a few hours of a new image being pushed or imported to ACR. When Contoso Retail's pipeline builds a new version of its payment microservice and pushes the updated image to ACR, Defender for Cloud begins scanning that image automatically. ACR requires no extra pipeline steps or configuration.

**Continuous rescanning** ensures that images don't receive a one-time clean bill of health only to accumulate risk as new CVEs are published. The following images are rescanned daily:

- Images pushed or imported to the registry in the last 30 days.
- Images pulled from the registry in the last 30 days.
- Images currently running in AKS clusters monitored by Defender for Cloud.

This means a payment service image that scanned clean three weeks ago is rescanned daily as long as it's running in a production cluster—surfacing newly published vulnerabilities that didn't exist at the time of the original scan.

## Review vulnerability findings in Defender for Cloud

Vulnerability findings appear as security recommendations in Microsoft Defender for Cloud. To review ACR image findings:

1. In Defender for Cloud, select **Recommendations**.
2. Search for **Azure registry container images should have vulnerabilities resolved**.
3. Select the recommendation to open the findings view.
4. Select a specific image to review its vulnerability report.

Each vulnerability report includes the following data:

| Field | Description |
|---|---|
| **CVE identifier** | The unique CVE ID assigned to the vulnerability (for example, CVE-YYYY-NNNNN). |
| **CVSS score** | The Common Vulnerability Scoring System (CVSS) scores indicating severity. Scores range from 0.0 to 10.0. |
| **Severity** | Classification based on CVSS score: Critical (9.0–10.0), High (7.0–8.9), Medium (4.0–6.9), or Low (0.1–3.9). |
| **Affected package** | The specific OS package or language dependency containing the vulnerability. |
| **Installed version** | The version of the affected package currently in the image. |
| **Fixed version** | The package version that resolves the vulnerability, if a patch is available. |
| **Exploitability** | Whether known exploit code or active exploitation in the wild has been documented for the CVE. |
| **Remediation guidance** | Steps to resolve the vulnerability, typically by updating the affected package. |

The exploitability field is valuable for prioritization. A Critical severity CVE without any known exploit can carry lower immediate risk than a High severity CVE with active exploit code—Defender for Cloud surfaces this distinction.

## Compare registry and runtime container scanning

Registry scanning evaluates images stored in ACR. Runtime container scanning evaluates images actually running in AKS clusters, including images pulled from public registries or other private registries not connected to Defender for Cloud.

Runtime vulnerability findings appear in a separate recommendation: **Azure running container images should have vulnerabilities resolved**. This recommendation maps vulnerable images back to the specific AKS clusters and namespaces where they're running, making it possible to trace a vulnerability finding directly to an affected workload.

The distinction matters in practice. An image might exist in the registry with known vulnerabilities but never be deployed. Runtime scanning focuses your attention on vulnerabilities that are currently present in running workloads—where exposure is actual rather than theoretical.

> [!TIP]
> Use both recommendations together. Registry scanning gives you broad coverage of your image inventory. Runtime scanning shows you which vulnerabilities are live in production today.

## Use vulnerability data in the cloud security graph

Vulnerability findings from both registry and runtime scanning feed into Defender for Cloud's cloud security graph—the graph that maps relationships between your Azure resources, their configurations, and known risks. The security graph connects vulnerability findings with other signals: network exposure, permissions, attack paths from external-facing resources, and the presence of sensitive data.

This contextual view changes how you prioritize findings. A High severity CVE in a container that runs on an internet-facing AKS node with broad permissions represents materially higher risk than the same CVE in a container running in an isolated namespace with no external connectivity. The cloud security graph makes that risk difference visible.

Attack path analysis builds on the graph to show the sequence of conditions an attacker would need to exploit to reach a sensitive resource. If a vulnerable container image sits on a path to a storage account containing customer data, that path appears as a finding in the **Attack path analysis** view in Defender for Cloud.

> [!NOTE]
> Defender for Containers and Defender CSPM (Cloud Security Posture Management) is separate plans. Defender for Containers contributes vulnerability data to the cloud security graph, but the **Cloud Security Explorer** and **Attack path analysis** views that surface this data require **Defender CSPM** to be enabled on the subscription. You can run Defender for Containers without Defender CSPM—vulnerability findings still appear in the Recommendations screen—but the contextual graph views aren't available.

The following diagram shows the complete vulnerability assessment lifecycle—from image push through scanning, findings, prioritization, and remediation.

:::image type="content" source="../media/vulnerability-assessment-lifecycle.png" alt-text="Activity diagram showing the vulnerability assessment lifecycle from image push through scanning, findings, and remediation." lightbox="../media/vulnerability-assessment-lifecycle.png":::

## Prioritize and act on findings

Use the following approach to act on vulnerability findings effectively:

1. **Filter by severity and exploitability** - Start with Critical and High severity findings with known exploits. These represent the highest immediate risk.
2. **Check for fixed versions** - Only findings with an available fixed version have a direct remediation path. If no fix is available, consider whether the affected workload requires compensating controls.
3. **Traces back to workloads** - Use the runtime recommendation to identify which clusters and namespaces run the affected image. This tells you where the vulnerable code is executing right now.
4. **Rebuild and redeploy** - The remediation path for most image vulnerabilities is to update the affected package, rebuild the image, push the updated image to ACR, and redeploy the workload. The **Fixed version** field in the vulnerability report identifies the exact package version to update to. Defender for Cloud rescans the new image automatically on push.

For Contoso Retail, this process closes the second detection gap from the security review: the team can now identify which ACR images contain known vulnerabilities, see which of those images are running in production AKS clusters, and prioritize remediation based on severity and exploitability—before the next incident goes undetected.
