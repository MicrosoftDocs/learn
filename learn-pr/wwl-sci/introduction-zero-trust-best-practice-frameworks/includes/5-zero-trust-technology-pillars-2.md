In this unit we continue and discuss the remaining Zero Trust deployment objectives.

## Secure data with Zero Trust

The three core elements of a data protection strategy are:

1.  **Know your data** - If you don't know what sensitive data you have on-premises and in cloud services, you can't adequately protect it. You need to discover data across your entire organization and classify all data by sensitivity level.
2.  **Protect your data and prevent data loss** -  Sensitive data needs to be protected by data protection policies that label and encrypt data or block over-sharing. This ensures only authorized users are able to access the data, even when data travels outside of your corporate environment.
3.  **Monitor and remediate** - You should continuously monitor sensitive data to detect policy violations and risky user behavior. This allows you to take appropriate action, such as revoking access, blocking users, and refining your protection policies.

### Data Zero Trust deployment objectives

An information protection strategy needs to encompass your organization's entire digital content. As a baseline, you need to define labels, discover sensitive data, and monitor the use of labels and actions across your environment. Use of sensitivity labels is discussed at the end of this guide.

When implementing an end-to-end Zero Trust framework for data, we recommend you focus first on these **initial deployment objectives**:

**I.** Access decisions are governed by encryption.<br>
**II.** Data is automatically classified and labeled.

After these are completed, focus on these **additional deployment objectives**:

**III.** Classification is augmented by smart machine learning models.<br>
**IV.** Access decisions are governed by a cloud security policy engine.<br>
**V.** Prevent data leakage through DLP policies based on a sensitivity label and content inspection.

# Secure endpoints with Zero Trust

Zero Trust adheres to the principle, "Never trust, always verify." In terms of endpoints, that means always verify _all_ endpoints. That includes not only contractor, partner, and guest devices, but also [apps](https://aka.ms/ZTApplications) and devices used by employees to access work data, regardless of device ownership.

In a Zero Trust approach, the same security policies are applied regardless of whether the device is corporate-owned or personally-owned through bring your own device (BYOD); whether the device is fully managed by IT, or only the apps and data are secured. The policies apply to all endpoints, whether PC, Mac, smartphone, tablet, wearable, or IoT device wherever they are connected, be it the secure corporate [network](https://aka.ms/ZTNetwork), home broadband, or public internet.

### Endpoint Zero Trust deployment objectives

When implementing an end-to-end Zero Trust framework for securing endpoints, we recommend you focus first on these **initial deployment objectives**:

**I.** Endpoints are registered with cloud identity providers. In order to monitor security and risk across multiple endpoints used by any one person, you need [visibility](https://aka.ms/ZTCrossPillars) in all devices and access points that may be accessing your resources.<br>

**II.** Access is only granted to cloud-managed and compliant endpoints and apps. Set compliance rules to ensure that devices meet minimum security requirements before access is granted. Also, set remediation rules for noncompliant devices so that people know how to resolve the issue.<br>

**III.** Data loss prevention (DLP) policies are enforced for corporate devices and BYOD. Control what the user can do with the data after they have access. For instance, restrict file saving to untrusted locations (such as local disk), or restrict copy-and-paste sharing with a consumer communication app or chat app to protect data.

After these are completed, focus on these **additional deployment objectives**:

**IV.** Endpoint threat detection is used to monitor device risk. Use a single pane of glass to manage all endpoints in a consistent way, and use a SIEM to route endpoint logs and transactions such that you get fewer, but actionable, alerts.

**V.** Access control is gated on endpoint risk for both corporate devices and BYOD. Integrate data from Microsoft Defender for Endpoint, or other Mobile Threat Defense (MTD) vendors, as an information source for device compliance policies and device Conditional Access rules. The device risk will then directly influence what resources will be accessible by the user of that device.

## Secure infrastructure with Zero Trust

Azure Blueprints, Azure Policies, Microsoft Defender for Cloud, Microsoft Sentinel, and Azure Sphere can greatly contribute to improving the security of your deployed infrastructure and enable a different approach to defining, designing, provisioning, deploying, and monitoring your infrastructure.

### Infrastructure Zero Trust deployment objectives

When implementing an end-to-end Zero Trust framework for managing and monitoring your infrastructure, we recommend you focus first on these **initial deployment objectives**:

**I.** Workloads are monitored and alerted to abnormal behavior.<br>
**II.** Every workload is assigned an app identity—and configured and deployed consistently.<br>
**III.** Human access to resources requires Just-In-Time.

After these are completed, focus on these **additional deployment objectives**:

**IV.** Unauthorized deployments are blocked, and alert is triggered.<br>
**V.** Granular visibility and access control are available across workloads.<br>
**VI.** User and resource access segmented for each workload.

## Secure networks with Zero Trust

Instead of believing everything behind the corporate firewall is safe, an end-to-end Zero Trust strategy assumes breaches are inevitable. That means you must verify each request as if it originates from an uncontrolled network—[identity](https://aka.ms/ZTIdentity) management plays a crucial role in this.

### Network Zero Trust deployment objectives

When implementing an end-to-end Zero Trust framework for securing networks, we recommend you focus first on these **initial deployment objectives**:

**I.** Network segmentation: Many ingress/egress cloud micro-perimeters with some micro-segmentation.<br>
**II.** Threat protection: Cloud native filtering and protection for known threats.<br>
**III.** Encryption: User-to-app internal traffic is encrypted.

After these are completed, focus on these **additional deployment objectives**:

**IV.** Network segmentation: Fully distributed ingress/egress cloud micro-perimeters and deeper micro-segmentation.<br>
**V.** Threat protection: Machine learning-based threat protection and filtering with context-based signals.<br>
**VI.** Encryption: All traffic is encrypted.