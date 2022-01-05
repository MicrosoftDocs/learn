In the information security lexicon, a kill chain describes the structure of an attack against an objective. The series of steps that describe the progression of a cyberattack from reconnaissance to data exfiltration.

Understanding the intention of an attack can help you investigate and report the event more easily. Microsoft Defender for Cloud alerts include the 'intent' field to help with these efforts.

### Protect against threats

Security Center's threat protection enables you to detect and prevent threats at the Infrastructure as a Service (IaaS) layer, non-Azure servers as well as for Platforms as a Service (PaaS) in Azure.

Security Center's threat protection includes fusion kill-chain analysis, which automatically correlates alerts in your environment based on cyber kill-chain analysis, to help you better understand the full story of an attack campaign, where it started and what kind of impact it had on your resources. Security Center's supported kill chain intents are based on the MITRE ATT&amp;CK™ framework. As illustrated below, the typical steps that trace the stages of a cyberattack.

:::image type="content" source="../media/az500-kill-chain-8468a5e8.png" alt-text="Illustration of the Cyber Kill Chain, the 9 steps used to infiltrate and damage an organization.":::


 -  **Reconnaissance**: The observation stage where attackers assess your network and services to identify possible targets and techniques to gain entry.
 -  **Intrusion**: Attackers use knowledge gained in the reconnaissance phase to get access to a part of your network. This often involves exploring a flaw or security hole.
 -  **Exploitation**: This phase involves exploiting vulnerabilities and inserting malicious code onto the system to get more access.
 -  **Privilege Escalation**: Attackers often try to gain administrative access to compromised systems so they can get access to more critical data and move into other connected systems.
 -  **Lateral Movement**: This is the act of moving laterally to connected servers and gain greater access to potential data.
 -  **Obfuscation / Anti-forensics**: To successfully pull off a cyberattack, attackers need to cover their entry. They will often compromise data and clear audit logs to try to prevent detection by any security team.
 -  **Denial of Service**: This phase involves disruption of normal access for users and systems to keep the attack from being monitored, tracked, or blocked.
 -  **Exfiltration**: The final extraction stage: getting valuable data out of the compromised systems.

Different types of attacks are associated with each stage, and they target various subsystems.
