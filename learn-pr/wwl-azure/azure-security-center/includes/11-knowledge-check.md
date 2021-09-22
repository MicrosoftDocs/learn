Use the knowledge check question to cofirm your knowledge of Azure Security Center.
## Review Questions

## Multiple Choice 
Which of following is not included in the Security Center free tier? Select one.  
() Monitor IoT hubs and resources{{You can monitor IoT hubs with Security Center free tier.}}
() Monitor network access and endpoint security{{Verifying endpoint and network access is part of Security Center free tier.}}
(x) Monitor non-Azure resources{{Monitor non-Azure resources. The Security Center free tier does not support monitoring external cloud or non-Azure resources, JIT VM access, regulatory compliance reports, adaptive network hardening recommendations, and several other features.}}


## Multiple Choice 
Your organization compliance group requires client authentication use Azure AD, and Key Vault diagnostic logs to be enabled. What is the easiest way to accomplish this? Select one. 
() Configure management groups{{A management group is not a good choice for this requirement.}}
(x) Implement Security Center policies{{Implement Security Center policies. Security Center can monitor policy compliance across all your subscriptions using a default set of security policies. A security policy defines the set of controls that are recommended for resources within the specified subscription or resource group.}}
() Create Desired Configuration State scripts{{Desired state scripts are not the easiest way to accomplish this task.}}

 

## Multiple Choice 
Your Azure Security Center dashboard presents a Secure Score. How would you describe that score? Select one. 
(x) The Secure Score is a calculation based on the ratio of healthy resources vs. total resources.{{The Secure Score is a calculation based on the ratio of healthy resources vs. total resources. Security Center reviews your security recommendations across all workloads, uses algorithms to determine how critical each recommendation is, and calculates a Secure Score which is displayed on the Overview page.}} 
() The Secure Score is a count of recommendations made against your monitored resources.{{There is way more to secure score than just a count of recommendations.}}
() The Secure Score is a machine-learning based prediction of how likely your resources are to be infiltrated by a hacker.{{Secure Score is not a track of how likely a success hacker attack will be.}}

 

## Multiple Choice 
Your organization is working with an outside agency that needs to access a virtual machine. There is a real concern about brute-force login attacks targeted at virtual machine management ports. Which of the following can be used to open the management ports for a defined time range? Select one. 
() Azure Firewall{{A firewall would not block the brute force attack, it using a valid port.}} 
() Bastion service{{Bastion is not the right choice for blocking brute force attacks on a VM.}}
(x) Just-in-Time virtual machine access{{Just-in-Time VM access. Azure Security Center supports Just-in-time (JIT) virtual machine (VM) access. When just-in-time access is enabled, Security Center uses network security group (NSG) rules to restrict access to management ports when they are not in use so they cannot be targeted by attackers. Protected ports are the SSH and RDP ports.}} 



## Multiple Choice 
You are using Azure Security Center (ASC) to provide visibility into your virtual machine security settings. With ASC monitoring you can be notified of all the following, except? Select one.  
(x) A newer operating system version is available.{{A newer operating system version is available. ASC examines OS-level settings using a monitor service that it installs into each Windows and Linux VM. In addition to the choices above, ASC can provide a vulnerability assessment with remediation recommendations.}} 
() System security updates and critical updates that are missing.{{Tracking critical updates is an available notification.}} 
() Disk encryption should be applied on virtual machines.{{You can be notified of missing disk encryption on virtual machines.}}  

 