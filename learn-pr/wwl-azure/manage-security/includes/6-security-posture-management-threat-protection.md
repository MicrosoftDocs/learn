Microsoft Defender for Cloud provides security posture management and threat protection capabilities for Azure Virtual Desktop VMs in the following ways:

 -  Secure configuration assessment and Secure Score.
 -  Industry-tested vulnerability assessment.
 -  Host level detections.
 -  Agentless cloud network micro-segmentation &amp; detection.
 -  File integrity monitoring.
 -  Just-in-time VM access.
 -  Adaptive Application Controls.

Using the Microsoft Defender for Cloud portal you can view Azure Virtual Desktop host pool VMs under **Inventory**:

:::image type="content" source="../media/configure-security-center-image-1-37b7904a.png" alt-text="Image of Azure Virtual Desktop host pools.":::


Choose a specific VM to view recommendations and Severity:

:::image type="content" source="../media/configure-security-center-image-2-0bdf4ed7.png" alt-text="Showing full recommendation list and as Severity level of a specific virtual machine.":::


Security alerts can be viewed under **General** and **Security Alerts**:

:::image type="content" source="../media/configure-security-center-image-3-42a81064.png" alt-text="Showing VM security findings under Threat Protection blade followed by Security Alerts.":::


Security alerts and recommendations can be consumed and managed from the Security Center portal or exported to analysis tools for remediation.

## Enabling Microsoft Defender for Cloud for Azure Virtual Desktop environment

Microsoft Defender for Cloud Free tier provides security recommendations and Secure Score for Azure Virtual Desktop deployments.

To enable all protection capabilities, do the following:

1.  Make sure you have Microsoft Defender for Cloud Standard tier (as shown below).
2.  Enable threat protection for Virtual Machines.

:::image type="content" source="../media/configure-security-center-image-4-d4677356.png" alt-text="Enabling threat protection for Virtual Machines in Azure Security Center.":::
