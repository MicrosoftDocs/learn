You can integrate Azure Security Center into your workflows and use it in many ways. Here are two example usage scenarios:

 -  Use Azure security center as part of your incident response plan.

Many organizations only respond to security incidents after an attack has occurred. To reduce costs and damage, it's necessary to have an incident response plan *before* an attack occurs.

:::image type="content" source="../media/security-center-incident-response-figure-1-cab022fe.png" alt-text="A set of circles linked with arrows illustrates the closure stages of an incident response plan detection, assessment, diagnosis, and stabilization.":::


The following examples are how you can use Azure Security Center to detect, assess, and diagnose your incident response plan stages.

 -  Detect. Review the first indication of an event investigation. For example, use the Azure Security Center dashboard to review a high-priority security alert's initial verification.
 -  Assess. Do the initial assessment to obtain more information about suspicious activity. For example, you can get more information from Azure Security Center about a security alert.
 -  Diagnose. Conduct a technical investigation and identify containment, mitigation, and workaround strategies. For example, you can follow the remediation steps described by Azure Security Center for a particular security alert.
 -  Use Azure Security Center recommendations to enhance security.

You can reduce the chances of a significant security event by configuring a security policy and then implementing the recommendations provided by Azure Security Center. A *security policy* defines the set of controls that are recommended for resources within a specified subscription or resource group. In Azure Security Center, you can define policies according to your company's security requirements.

Azure Security Center analyzes the security state of your Azure resources. When it identifies potential security vulnerabilities, it creates recommendations based on the controls set in the security policy.

The suggestions guide you through the process of configuring the corresponding security controls.

For example, if you have workloads that don't require the Azure SQL Database Transparent Data Encryption (TDE) policy, turn off the policy at the subscription level and enable it only on the resource groups where SQL Database TDE is required.

You can read more about the Azure security center at the [Azure security center](https://azure.microsoft.com/services/security-center/). More implementation and scenario details are also available in the [Azure security center planning and operations guide](/azure/security-center/security-center-planning-and-operations-guide).
