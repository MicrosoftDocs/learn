
## Exercise: Protect Microsoft Foundry by using Microsoft Entra ID Conditional Access

Learners can find the full list of labs and launch each exercise directly by visiting the [Manage AI-Ready Infrastructure](https://go.microsoft.com/fwlink/?linkid=2349700) GitHub repository, which serves as the single entry point for the course’s hands‑on activities.

Modern security extends beyond the network perimeter and relies on identity-driven access control. Microsoft Entra Conditional Access evaluates multiple signals to make access decisions for users, devices, and applications. Signals include, for example, user's identity and group membership, device state and compliance, IP location, target application, and real-time risk assessment. Policies can combine these signals to implement complex access rules, such as requiring multifactor authentication in combination with restricting connections from trusted networks only or enforcing device's Microsoft Entra hybrid join status when accessing sensitive apps.

Policies are applied after first-factor authentication and help organizations implement a Zero Trust model, reducing the risk of unauthorized access to sensitive resources. However, they can be set in report-only mode, allowing administrators to evaluate their impact before actually enforcing them.

Conditional Access policies can be applied to protect Microsoft Foundry resources. For example, administrators can assign policies to the following apps by their App IDs:
- Microsoft Foundry App (cb2ff863-7f30-4ced-ab89-a00194bcf6d9) – controls access to the Microsoft Foundry portal
- Azure Machine Learning Web App (d7304df8-741f-47d3-9bc2-df0e24e2071f) – controls access to Azure Machine Learning studio
- Azure Machine Learning API (0736f41a-0425-bdb5-1563eff02385) – governs direct API access, such as SDK or REST API calls (hub-based projects rely on this API)

By using these app IDs in Conditional Access assignments, administrators can target policies specifically to the Azure AI workloads, ensuring only authorized users using compliant devices from secure locations can access sensitive AI environments. This combination of signals and targeted enforcement enables organizations to maintain regulatory compliance, monitor access risk in real time, and protect critical AI workloads.

### Scenario
Your company is a financial services firm that handles highly sensitive customer and transactional data, including banking records, payment histories, credit assessments, and fraud detection metrics. To support its AI initiatives, the organization plans to deploy a centralized Microsoft Foundry platform, enabling teams to develop machine learning models for fraud detection, credit risk assessment, and transaction analysis. Given the sensitivity of these workloads, controlling access to the Microsoft Foundry portal is critical to maintain regulatory compliance and protect customer data.

To implement this, the company plans to use Microsoft Entra Conditional Access policies. Access is restricted to a designated security group of users, ensuring only authorized personnel can reach the portal. More access controls require multifactor authentication and devices to be Microsoft Entra hybrid joined. Furthermore, access is allowed exclusively from the company’s HQ IP range, blocking logins from untrusted networks. To validate these controls without disrupting business operations, the policies will initially be deployed in report-only mode, allowing administrators to monitor the effects before enforcing them. In addition, any users outside the designated group will be explicitly blocked from accessing the Microsoft Foundry portal, ensuring strict segregation and minimizing the risk of unauthorized access.

:::image type="content" source="../media/company-planning-create-conditional-access.png" alt-text="Diagram showing a company planning to use Microsoft Entra Conditional Access policies.":::

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::](https://go.microsoft.com/fwlink/?linkid=2349802)

## Estimated duration
15 minutes


