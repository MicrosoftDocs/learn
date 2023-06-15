
The following are examples of detection and mitigation use cases. 

## Detection of Threat 
This scenario depicts a case where Microsoft Defender for Endpoint detects a malicious payload (which could come from any source, including personal email or a USB drive). 

:::image type="content" source="../media/compromised-endpoint.png" alt-text="Diagram the Detection of a Compromised endpoint.":::
 
The victim receives a malicious email on personal email account (not protected by Microsoft Defender for Office 365 (MDO) or a USB drive and opens the attachment. 
Once the attachment opens, the malware infects the computer. The user is unaware that an attack has taken place. But
Microsoft Defender for Endpoints (MDE) detects this attack, raises an alert to security operations, and provides details about the threat to the Security team.
Disable user access from device while infected - MDE communicates to Intune that risk level on this endpoint has changed. Intune marks the account in Azure Active Directory as noncompliant with organizations policy, and Conditional Access blocks user access based on that.  
 
### Remediation 
  
MDE remediates threat – either via automated remediation, security analyst approval of automated remediation, or analyst manual investigation of threat.  
MDE also remediates this threat across your enterprise and across our Microsoft MDE customers by adding information on this attack to Microsoft Threat Intelligence system 
  
### Share Intelligence and Restore Access  
  
Restore Access – Once the infected devices have been remediated, MDE signals Intune to change the device risk status and Azure AD Conditional Access then allows access to enterprise resources (more on the next slide). 
Remediate Threat Variants in MDO and others – The threat signals in Microsoft Threat intelligence are used by Microsoft tools securing other parts of your organization’s attack surface. MDO and Microsoft Defender for Cloud use the signals to detect and remediate threats in email, office collaboration, Azure, and more. 


## from the previous graphic when the user’s device was still compromised.   

:::image type="content" source="../media/suspend-access-compromise.png" alt-text="Diagram of steps to Suspend access during compromise.":::

  
### Access Restricted  
  
Conditional Access knows about device risk because Microsoft Defender for Endpoint (MDE) notified Intune, which then updated the compliance status of the device in Azure AD.   
  
During this time, the user is restricted from accessing corporate resources. This applies to all new resource requests and will block any current access to resources that support continuous access evaluation (CAE)  
People will still be able to do general internet productivity and research (YouTube, Wikipedia, and anything else that doesn’t require corporate authentication, but won’t have access to corporate resources.   
  
### Access Restored  
  
Once the threat has been remediated and cleaned up, MDE triggers Intune to update Azure AD, and Conditional Access restores the user’s access to corporate resources.
  
This mitigates risk to the organization by ensuring attackers who may be in control of these devices can't access corporate resources, while minimizing the impact on user productivity to minimize disruption of business processes.  
  
