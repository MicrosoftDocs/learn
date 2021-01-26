## Respond to Azure Defender for Key Vault alerts

When you receive an alert from Azure Defender for Key Vault, we recommend you investigate and respond to the alert as described below. Azure Defender for Key Vault protects applications and credentials, so even if you're familiar with the application or user that triggered the alert, it's important to verify the situation surrounding every alert.

Every alert from Azure Defender for Key Vault includes the following elements:

- Object ID

- User Principal Name or IP Address of the suspicious resource

### Contact

- Verify whether the traffic originated from within your Azure tenant. If the key vault firewall is enabled, it's likely that you've provided access to the user or application that triggered this alert.

- If you can't verify the source of the traffic, continue to Step 2. Immediate mitigation.

- If you can identify the source of the traffic in your tenant, contact the user or owner of the application.

### Immediate mitigation

If you don't recognize the user or application, or if you think the access shouldn't have been authorized:

- If the traffic came from an unrecognized IP Address:

  - Enable the Azure Key Vault firewall as described in Configure Azure Key Vault firewalls and virtual networks.

  - Configure the firewall with trusted resources and virtual networks.

- If the source of the alert was an unauthorized application or suspicious user:

  - Open the key vault's access policy settings.

  - Remove the corresponding security principal, or restrict the operations the security principal can perform.

- If the source of the alert has an Azure Active Directory role in your tenant:

  - Contact your administrator.

  - Determine whether there's a need to reduce or revoke Azure Active Directory permissions.

### Identify impact

When the impact has been mitigated, investigate the secrets in your key vault that were affected:

1. Open the “Security” page on your Azure Key Vault and view the triggered alert.

1. Select the specific alert that was triggered. Review the list of the secrets that were accessed and the timestamp.

1. Optionally, if you have key vault diagnostic logs enabled, review the previous operations for the corresponding caller IP, user principal, or object ID.

### Take action

When you've compiled your list of the secrets, keys, and certificates that the suspicious user or application accessed, you should immediately rotate those objects.

- Affected secrets should be disabled or deleted from your key vault.

- If the credentials were used for a specific application:

  - Contact the administrator of the application and ask them to audit their environment for any uses of the compromised credentials since they were compromised.

  - If the compromised credentials were used, the application owner should identify the information that was accessed and mitigate the impact.

## Respond to Azure Defender for DNS alerts

When you receive an alert from Azure Defender for DNS, we recommend you investigate and respond to the alert as described below. Azure Defender for DNS protects all connected resources, so even if you're familiar with the application or user that triggered the alert, it's important to verify the situation surrounding every alert.

### Contact

Contact the resource owner to determine whether the behavior was expected or intentional.

- If the activity is expected, dismiss the alert.

- If the activity is unexpected, treat the resource as potentially compromised and mitigate as described in the next step.

### Immediate mitigation

Isolate the resource from the network to prevent lateral movement.

- Run a full antimalware scan on the resource, following any resulting remediation advice.

- Review installed and running software on the resource, removing any unknown or unwanted packages.

- Revert the machine to a known good state, reinstalling the operating system if required, and restore software from a verified malware-free source.

- Resolve any Azure Security Center recommendations for the machine, remediating highlighted security issues to prevent future breaches.

## Respond to Azure Defender for Resource Manager alerts

When you receive an alert from Azure Defender for Resource Manager, we recommend you investigate and respond to the alert as described below. Azure Defender for Resource Manager protects all connected resources, so even if you're familiar with the application or user that triggered the alert, it's important to verify the situation surrounding every alert.

### Contact

Contact the resource owner to determine whether the behavior was expected or intentional.

- If the activity is expected, dismiss the alert.

- If the activity is unexpected, treat the related user accounts, subscriptions, and virtual machines as compromised and mitigate as described in the following step.

### Immediate mitigation

- Remediate compromised user accounts:

  - If they’re unfamiliar, delete them as they may have been created by a threat actor

  - If they’re familiar, change their authentication credentials

  - Use Azure Activity Logs to review all activities performed by the user and identify any that are suspicious

- Remediate compromised subscriptions:

  - Remove any unfamiliar Runbooks from the compromised automation account

  - Review IAM permissions for the subscription and remove permissions for any unfamiliar user account

  - Review all Azure resources in the subscription and delete any that are unfamiliar

  - Review and investigate any security alerts for the subscription in Azure Security Center

  - Use Azure Activity Logs to review all activities performed in the subscription and identify any that are suspicious

- Remediate the compromised virtual machines

  - Change the passwords for all users

  - Run a full antimalware scan on the machine

  - Reimage the machines from a malware-free source

