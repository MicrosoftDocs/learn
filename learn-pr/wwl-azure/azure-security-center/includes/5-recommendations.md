Using the policies, Defender for Cloud periodically analyzes the compliance status of your resources to identify potential security misconfigurations and weaknesses. It then provides you with recommendations on how to remediate those issues. Recommendations are the result of assessing your resources against the relevant policies and identifying resources that aren't meeting your defined requirements.

Defender for Cloud makes its security recommendations based on your chosen initiatives. When a policy from your initiative is compared against your resources and finds one or more that aren't compliant it is presented as a recommendation in Defender for Cloud.

**Recommendations** are actions for you to take to secure and harden your resources. Each recommendation provides you with the following information:

 -  A short description of the issue
 -  The remediation steps to carry out in order to implement the recommendation
 -  The affected resources

In practice, it works like this:

1.  Azure Security Benchmark is an***initiative***that contains requirements.
    
    For example, Azure Storage accounts must restrict network access to reduce their attack surface.
2.  The initiative includes multiple ***policies***, each with a requirement of a specific resource type. These policies enforce the requirements in the initiative.
    
    To continue the example, the storage requirement is enforced with the policy "Storage accounts should restrict network access using virtual network rules".
3.  Microsoft Defender for Cloud continually assesses your connected subscriptions. If it finds a resource that doesn't satisfy a policy, it displays a ***recommendation*** to fix that situation and harden the security of resources that aren't meeting your security requirements.
    
    :::image type="content" source="../media/Microsoft-Defender-for-Cloud-Security-Recommendations-cd6022ce.jpg":::
    
    
    For example, if an Azure Storage account on any of your protected subscriptions isn't protected with virtual network rules, you'll see the recommendation to harden those resources.

So, (1) **an initiative includes** (2) **policies that generate** (3) **environment-specific recommendations**.
