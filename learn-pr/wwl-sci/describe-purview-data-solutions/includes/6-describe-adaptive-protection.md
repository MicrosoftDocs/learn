

Adaptive protection in Microsoft Purview uses machine learning (ML) to identify the most critical risks and proactively and dynamically apply protection controls from:

- Data Loss Prevention
- Microsoft Purview Data Lifecycle Management (preview)
- Microsoft Entra Conditional Access (preview)

Integration with data loss prevention, data lifecycle management, and Conditional Access can help organizations automate their response to insider risks and reduce the time required to identify and remediate potential threats. By using the capabilities of all four solutions, organizations can create a more comprehensive security framework that addresses both internal and external threats.

Adaptive protection helps mitigate potential risks by using:

- Context-aware detection. Helps identify the most critical risks with ML-driven analysis of both content and user activities.
- Dynamic controls. Helps enforce effective controls on high-risk users while others maintain productivity.
- Automated mitigation. Helps to minimize the impact of potential data security incidents and reduce admin overhead.

Adaptive protection dynamically assigns appropriate data loss prevention, data lifecycle management, and Conditional Access policies to users based on the insider risk levels (elevated, moderate, or minor) defined and analyzed by the machine learning models in Insider Risk Management. Policies become adaptive based on user context, ensuring that the most effective policy, such as blocking data sharing through data loss prevention or blocking application access through Conditional Access, is applied only to high-risk users while low-risk users maintain productivity.

#### Adaptive protection in Data Loss Prevention

Adaptive Protection in Microsoft Purview integrates Microsoft Purview Insider Risk Management with Microsoft Purview Data Loss Prevention (DLP). When Insider Risk Management identifies a user who is engaging in risky behavior, they're dynamically assigned an insider risk level. Then adaptive protection can automatically create a DLP policy to help protect the organization against the risky behavior that's associated with that insider risk level. As users insider risk levels change in insider risk management, the DLP policies applied to users can adjust.
