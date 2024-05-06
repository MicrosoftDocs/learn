**Microsoft Defender for Identity** (formerly Azure Advanced Threat Protection, also known as Azure ATP) is a cloud-based security solution that identifies and detects:

 -  Advanced threats.
 -  Compromised identities.
 -  Malicious insider actions directed at your organization.

Microsoft Defender can detect known malicious attacks and techniques and help you investigate security issues and network vulnerabilities.

## Microsoft Defender components

Microsoft Defender consists of the following components:

 -  Microsoft Defender portal. Microsoft Defender has its portal. You can monitor and respond to suspicious activity through the Microsoft Defender portal. The Microsoft Defender portal allows you to manage your Microsoft Defender instance and review data received from Microsoft Defender sensors.

You can also use the Microsoft Defender portal to monitor, manage, and investigate threats to your network environment.

You can sign into the Microsoft Defender portal at [https://security.microsoft.com/](https://security.microsoft.com/).

Sign in with a user account assigned to an Azure AD security group with access to the Microsoft Defender portal.

 -  Microsoft Defender sensor. Microsoft Defender sensors are installed directly on your domain controllers. The sensors monitor domain controller traffic without requiring a dedicated server or port mirroring configurations.
 -  Microsoft Defender cloud service. The Microsoft Defender cloud service runs on the Azure infrastructure and is deployed in the United States, Europe, and Asia. The Microsoft Defender cloud service is connected to the Microsoft Intelligent Security Graph.

:::image type="content" source="../media/azure-defender-62d904d7.png" alt-text="Screenshot of the Azure Defender dashboard and event timeline. Security events display, such as honey token activity, remote execution attempt detected, and suspicious service created.":::


## Cryptocurrency mining and other-advanced attacks

Azure Defender for container registries (deprecated) can be enabled at the subscription level.

Once it's enabled:

 -  Microsoft Defender will then scan images that are pushed to the registry.
 -  Scan imported into the registry.
 -  Or any images pulled within the last 30 days.

There's a per-image charge for this feature.

When issues are found, a notification appears in the Microsoft Defender dashboard.

There are three triggers for image scans:

 -  On push (a new image is pushed to the registry)
 -  Recently pulled (any image pulled in the last 30 days)
 -  On import (when an image is imported from other locations like Docker Hub)

> [!IMPORTANT]
> Microsoft Defender for container registries has been replaced with [Microsoft Defender for Containers](/azure/defender-for-cloud/defender-for-containers-introduction). If you've already enabled Defender for container registries on a subscription, you can continue to use it. However, you won't get Defender for Containers' improvements and new features.<br><br>This plan is no longer available for subscriptions where it isn't already enabled.<br><br>To upgrade to Microsoft Defender for Containers, open the Defender plans page in the portal and enable the new plan:<br><br>:::image type="content" source="../media/enable-defender-for-containers-5a259ec9.png" alt-text="Screenshot of Microsoft Defender for Containers.":::<br><br><br>Learn more about this change in [the release note](/azure/defender-for-cloud/release-notes-archive).

## Purchasing Microsoft Defender

Microsoft Defender is available as part of the Microsoft *Enterprise Mobility + Security E5* offering and a standalone license.

You can acquire a license directly from the [Enterprise Mobility + Security pricing options](https://www.microsoft.com/cloud-platform/enterprise-mobility-security-pricing) page or the Cloud Solution Provider (CSP) licensing model.

> [!NOTE]
> Microsoft Defender isn't available for purchase via the Azure portal. For more information about Microsoft Defender review the [Azure Defender \| Microsoft Azure](https://azure.microsoft.com/services/azure-defender/) webpage.
