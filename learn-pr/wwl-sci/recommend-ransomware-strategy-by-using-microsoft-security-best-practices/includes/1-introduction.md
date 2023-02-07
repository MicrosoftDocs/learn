---
uid: learn.wwl.recommend-ransomware-strategy-by-using-microsoft-security-best-practices.introduction
title: introduction
description: introduction
durationInMinutes: 10
---
In this module, you'll learn how to:

- Recognize different types of malware
- Help an organization mitigate risk of a ransomware attack by:
    - creating a recovery plan
    - limiting the scope of damage
    - hardening key infrastructure elements

The content in the module will help you prepare for the certification exam SC-100: Microsoft Cybersecurity Architect.

## Prerequisites

- Conceptual knowledge of security policies, requirements, zero trust architecture, and management of hybrid environments
- Working experience with zero trust strategies, applying security policies, and developing security requirements based on business goals

## Ransomware overview

*Ransomware* is a type of cyber security attack that destroys or encrypts files and folders, preventing the owner of the affected device from accessing their data. The cybercriminal can then extort money from the business owner in exchange for a key to unlock the encrypted data. But, even when paid, cybercriminals may not provide the key to return access to the business owner.

### Automated ransomware attacks

Commodity ransomware attacks are usually automated. These cyber attacks can spread like a virus, infect devices through methods like email phishing and malware delivery, and require malware remediation. That means one ransomware prevention technique is to safeguard your mail with a system like *Microsoft Defender for Office 365*, or *Microsoft 365 Defender*, to detect malware and phishing attempts early.

### Human-operated ransomware attacks

*Human-operated ransomware* is the result of an **active attack** by cybercriminals that infiltrate an organization’s on-premises or cloud IT infrastructure, elevate their privileges, and deploy ransomware to critical data.

These “hands-on-keyboard” attacks target an organization rather than a single device. *Human-operated* means there's a human attacker using their  insights to infiltrate the organization, navigate the network, and adapt to the environment.

Hallmarks of these human-operated ransomware attacks typically include **credential theft** and **lateral movement** with an elevation of the privileges in stolen accounts. Activities might take place during maintenance windows and involve security configuration gaps discovered by cybercriminals. The goal is the **deployment of a ransomware payload** to whatever *high business impact resources* the attackers choose.

These attacks can be catastrophic to business operations and are difficult to clean up, requiring complete adversary eviction to protect against future attacks. Unlike commodity ransomware that usually only requires malware remediation, human-operated ransomware will continue to threaten your business operations after the initial encounter.

The graphic below shows how this extortion-based attack is growing in impact and likelihood.

![The impact and likelihood that human-operated ransomware attacks will continue](../media/ransomware-extortion-based-attack.png)

### Ransomware protection for your organization

For a comprehensive view of ransomware and extortion and how to protect your organization, use the information in the **[Human-Operated Ransomware Mitigation Project Plan](https://download.microsoft.com/download/7/5/1/751682ca-5aae-405b-afa0-e4832138e436/RansomwareRecommendations.pptx)** PowerPoint presentation. But here's a summary of the guidance:

![The summary of the guidance in the Human-Operated Ransomware Mitigation Project Plan](../media/stakes-weaknesses-plan.png)

- The stakes of ransomware and extortion-based attacks are high.
- However, the attacks have weaknesses that can reduce your likelihood of being attacked.
- There are three phases to configuring your infrastructure to exploit attack weaknesses.
    1. Prepare your organization to recover from an attack without having to pay the ransom.
    2. Limit the scope of damage of a ransomware attack by protecting privileged roles.
    3. Make it harder for an attacker to get into your environment by incrementally removing risks.

[![The three phases to protecting against ransomware and extortion](../media/protect-against-ransomware-phases.png)

Download the [Protect your organization from ransomware poster](https://download.microsoft.com/download/5/e/3/5e37cbff-9a7a-45b2-8b95-6d3cc5426301/protect-your-organization-from-ransomware.pdf) for an overview of the three phases as layers of protection against ransomware attackers.

[![The "Protect your organization from ransomware" poster](../media/ransomware-poster-thumbnail.png)](https://download.microsoft.com/download/5/e/3/5e37cbff-9a7a-45b2-8b95-6d3cc5426301/protect-your-organization-from-ransomware.pdf)