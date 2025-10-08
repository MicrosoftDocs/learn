As your AI environment expands, different services, models, and data sources can introduce configuration risks. Defender for Cloud's **Cloud Security Posture Management (CSPM)** plan helps identify those risks by analyzing your AI workloads, connected data, and network dependencies. It provides a clear view of how your AI resources are configured and where improvements are needed.

The AI workloads plan you enabled earlier feeds its discovery results into CSPM. From there, you can use tools like **Cloud Security Explorer** and **attack path analysis** to locate misconfigurations that could expose sensitive data or disrupt model performance.

## Discover AI workloads and assess posture

CSPM automatically builds an **AI Bill of Materials (AI BOM)** that maps deployed AI models, datasets, and related services. This inventory lets you confirm where AI workloads are running and whether they align with your organization's security requirements.

To view AI workloads in your environment:

1. Sign in to the **Azure portal**.
1. Search for and select **Microsoft Defender for Cloud**.
1. Under **General**, select **Cloud Security Explorer**.
1. Select **AI workloads and models in use** query template, then select **Open query**.
1. Select **Search** to run the query and view the results.

   :::image type="content" source="../media/ai-workload-query.png" alt-text="Screenshot showing the AI workloads and models in use query template in Cloud Security Explorer." lightbox="../media/ai-workload-query.png":::

Each result represents a discovered AI workload, including details about its model, data source, and resource group. Selecting a result opens a detailed view with model metadata and configuration context.

:::image type="content" source="../media/result-details.png" alt-text="Screenshot showing AI workload results with one workload selected and details displayed." lightbox="../media/result-details.png":::

These details help you verify that sensitive or regulated data isn't exposed through public access or unsecured endpoints.

## Investigate risks and attack paths

Defender for Cloud uses **attack path analysis** to connect related configuration risks across resources. This feature visualizes potential routes an attacker could exploit to reach sensitive AI data or services. For example, an exposed storage account that contains grounding data could create a path to a fine-tuned AI model using that data.

:::image type="content" source="../media/attack-path-example.png" alt-text="Screenshot showing an example of an attack path highlighting connected AI and data resources with configuration risks." lightbox="../media/attack-path-example.png":::

Attack paths help you focus on the issues that matter most by showing how individual misconfigurations are linked.

## Apply recommendations to improve posture

CSPM generates security recommendations that identify configuration weaknesses and remediation steps. Key recommendation categories include:

- **Identity and access**: Require managed identities for AI services instead of static keys.
- **Network exposure**: Restrict public endpoints and use private links where possible.
- **Data protection**: Enable encryption at rest for all storage and datasets.
- **Dependencies**: Update vulnerable AI frameworks or libraries.

Remediating these findings improves the overall security posture of your AI workloads and reduces exposure risk across your environment.

CSPM connects discovery to action. It gives you visibility into your deployed AI workloads, highlights where configuration issues exist, and provides guidance for correcting them. By applying these recommendations, you can strengthen how your organization secures and manages its AI resources before moving on to runtime threat protection.
