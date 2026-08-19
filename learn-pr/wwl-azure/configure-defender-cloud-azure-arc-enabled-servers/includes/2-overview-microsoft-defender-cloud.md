Microsoft Defender for Cloud is a cloud-native application protection platform (CNAPP) that protects applications and resources across their lifecycle. Defender for Cloud combines three capabilities:

- **Development security operations (DevSecOps)** integrates security into code repositories and pipelines.
- **Cloud security posture management (CSPM)** assesses resources and prioritizes recommendations that reduce risk.
- **Cloud workload protection platform (CWPP)** detects and responds to threats against virtual machines, containers, storage, databases, serverless functions, and other workloads.

:::image type="content" source="../media/defender-cloud-pillars-updated-125418ad.png" alt-text="Diagram showing how the Defender for Cloud security components integrate.":::


Defender for Cloud remains available in the Azure portal. Customers with a paid Defender for Cloud plan can also prepare their tenant to use Defender for Cloud under **Cloud security** in the [Microsoft Defender portal](https://security.microsoft.com/). This experience brings cloud posture, recommendations, inventory, alerts, and incidents into the security operations portal. After you prepare the tenant, allow up to 24 hours for the data to appear.

Defender for Cloud alerts and incidents also integrate with Microsoft Defender XDR. Access requires an appropriate Microsoft Defender XDR Unified role-based access control (RBAC) role for Defender for Cloud. Without Unified RBAC, a user must be a Global Administrator or Security Administrator in Microsoft Entra ID. The Defender plans you enable on the subscription determine which alerts are available. For details, see [Defender for Cloud alerts and incidents in Microsoft Defender XDR](/azure/defender-for-cloud/concept-integration-365).
