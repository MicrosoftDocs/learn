
Defender for Cloud continually assesses your resources, subscriptions,
and organization for security issues. It then aggregates all the
findings into a single score so that you can tell, at a glance, your
current security situation: the higher the score, the lower the
identified risk level.

For security analysts, it's essential to identify the potential risks
associated with security recommendations and understand the attack
vectors, so they can prioritize more effectively. To make prioritization
easier, Microsoft Defender for Cloud maps its security recommendations
against the [MITRE ATTACK framework](https://attack.mitre.org/), a
globally accessible knowledge base of adversary tactics and techniques
based on real-world observations. Using this capability, customers can
strengthen the security posture of their environment with
recommendations that are mapped to the MITRE ATTACK framework and
prioritize based on the potential risk across the cyber kill chain.

![Diagram showing MITRE ATTACK framework.](../media/mitre-attack-framework.png) 

The advantage of using MITRE ATTACK when evaluating your security
posture is that you can create campaigns to remediate recommendations
based on the different phases of the MITRE ATTACK framework. The
rationale is that if you remediate recommendations that are mapped to
early stages of the MITRE ATTACK framework, you can prevent a threat
actor from gaining further access to your workloads. Defender for Cloud
has a filter that enables you to create this visualization as shown in
the image below:

![Screenshot showing the filter in Defender for Cloud that allows you to view which phase of the MITRE ATTACK framework each remediation is mapped to.](../media/mitre-attack-tactics-filter.png)


For a walkthrough of Using Microsoft Defender for Cloud along with other technologies to secure your resources view the following interactive guide.

[:::image type="content" source="../media/secure-azure-hybrid-multicloud-interactive-guide.png" alt-text="Cover for an interactive guide that says Secure your Azure, hybrid, and multicloud environment." border="true":::](https://mslearn.cloudguides.com/guides/Secure%20your%20Azure%20hybrid%20and%20multicloud%20environment)