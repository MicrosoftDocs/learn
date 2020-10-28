You can integrate Security Center into your workflows and use it in many ways. Here are two examples.

**Example 1 - Use Security Center for an incident response**


Many organizations learn how to respond to security incidents only after suffering an attack. To reduce costs and damage, it’s standard to have an incident response plan in place before an attack occurs. You can use Azure Security Center in different stages of an incident response.

:::image type="content" source="../media/security-center-response.png" alt-text="Circular arrows point from the words detect, to assess, to diagnose, to stabilize, to close.":::

You can use Security Center during the detect, assess, and diagnose stages. Here are examples of how Security Center can be useful during the three initial incident response stages:

+ **Detect** - Review the first indication of an event investigation. For example, use the Security Center dashboard to review the initial verification that a high-priority security alert was raised.

+ **Assess** - Perform the initial assessment to obtain more information about the suspicious activity. For example, obtain more information about the security alert.

+ **Diagnose** - Conduct a technical investigation and identify containment, mitigation, and workaround strategies. For example, follow the remediation steps described by Security Center in that particular security alert.


**Example 2 - Use Security Center recommendations to enhance security**

You can reduce the chances of a significant security event by configuring a security policy, and then implementing the recommendations provided by Azure Security Center. 

**Security policies and recommendations**
        
A **security policy** defines the set of controls that are recommended for resources within that specified subscription or resource group. In Security Center, you define policies according to your company's security requirements. 
    
Security Center analyzes the security state of your Azure resources. When Security Center identifies potential security vulnerabilities, it creates **recommendations** based on the controls set in the security policy. The recommendations guide you through the process of configuring the needed security controls. For example, if you have workloads that do not require the *Azure SQL Database Transparent Data Encryption* (TDE) policy, turn off the policy at the subscription level and enable it only in the resources groups where SQL TDE is required.

More implementation and scenario detail is also available in the [Azure Security Center planning and operations guide](https://docs.microsoft.com/azure/security-center/security-center-planning-and-operations-guide?azure-portal=true).

> [!Note]
> This lab is using the **Azure Sandbox**, so all you need to do is close your Azure Portal to shutdown all the resources created in this lab.  Please do not delete the resource group provided.
