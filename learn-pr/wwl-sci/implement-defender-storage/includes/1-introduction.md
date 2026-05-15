Contoso's AI document processing pipeline accepts file uploads from external partners for automated analysis and distribution. Last month, a malicious file entered through a legitimate partner upload, bypassed the network controls and access policies, and spread to internal systems before the security team detected the threat. The upload used a valid SAS token, so the existing access controls treated it as authorized traffic. Network security rules allowed the connection because it came from a known partner IP address. By the time the team noticed unusual activity, the malware executed in downstream processing systems.

The cloud security team realizes they need a threat detection layer that works outside network controls and access policies—one that inspects content and analyzes access patterns regardless of how the access was granted. Microsoft Defender for Storage provides this layer. It continuously monitors storage activity for suspicious patterns and scans uploaded files for malware. It also identifies when AI agents or applications use compromised or overly permissive SAS tokens.

Enabling Microsoft Defender for Storage is now a clear mandate for Contoso's cloud security team. They need to enable Microsoft Defender for Storage across every storage account in the AI pipeline—not just the partner upload bucket, but the processed documents store and the ML training data repository too. As they work through the configuration, three priorities emerge. First, malware scanning costs must stay within budget as file volumes grow. Second, sensitive data alerts need the right priority context. Third, every detection must reach the right people at the right time. By the end, the team needs to walk away knowing the detection pipeline is working—not just configured.

## Learning objectives

After completing this module, you'll be able to:

- Describe the three detection pillars of Microsoft Defender for Storage and how they differ from the classic plan
- Enable Defender for Storage at subscription and resource level using policy-driven deployment
- Configure malware scanning with monthly GB caps for cost control
- Configure sensitive data threat detection
- Configure alert notifications and verify that Defender outputs reach the appropriate security team
