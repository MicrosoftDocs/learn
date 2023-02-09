In the information security lexicon, a kill chain describes the structure of an attack against an objective. The series of steps that describe the progression of a cyberattack from reconnaissance to data exfiltration.

Understanding the intention of an attack can help you investigate and report the event more easily. Microsoft Defender for Cloud alerts include the 'intent' field to help with these efforts.

### Protect against threats

Security Center's threat protection enables you to detect and prevent threats at the Infrastructure as a Service (IaaS) layer, non-Azure servers as well as for Platforms as a Service (PaaS) in Azure.

Security Center's threat protection includes fusion kill-chain analysis, which automatically correlates alerts in your environment based on cyber kill-chain analysis, to help you better understand the full story of an attack campaign, where it started and what kind of impact it had on your resources. Security Center's supported kill chain intents are based on the MITRE ATT&CK™ framework. As illustrated below, the typical steps that trace the stages of a cyberattack.

### The cloud kill chain model

When attacking cloud infrastructure, adversaries often attack multiple resources to try to obtain access to customer data or company secrets. The cloud kill chain model explains how attackers attempt to gain access to any of your resources running in the public cloud through a four-step process: exposure, access, lateral movement, and actions.

:::image type="content" source="../media/the-cloud-kill-chain-model-27165b83.png" alt-text="Image demonstrating the cloud kill chain model.":::


1.  Exposure is where attackers look for opportunities to gain access to your infrastructure. For example, attackers know customer-facing applications must be open for legitimate users to access them. Those applications are exposed to the Internet and therefore susceptible to attacks. Attackers will attempt to attack vulnerabilities or exploit weak credentials in the exposed applications. Exposure can also be found in vulnerabilities or malware-based attacks to compromise user credentials.
2.  Attackers will try to exploit an exposure to gain access to your public cloud infrastructure. This can be done through compromised user credentials, compromised instances, or misconfigured resources. With compromised instances, attackers can gain access to instances by exploiting a vulnerability, such as on a publicly facing web application or exploiting weak credentials, such as brute-forcing a publicly facing SSH server. Without security controls in place, 68% of breaches take months or longer to discover.
3.  During the lateral movement stage, attackers discover what resources they have access to and what the scope of that access is. Successful attacks on instances give attackers access to databases and other sensitive information. The attacker then searches for additional credentials. Without a security tool to quickly notify you of the attack, it takes organizations on average 101 days to discover a breach. Meanwhile, in just 24-48 hours after a breach, the attacker will usually have complete control of the network.
4.  The actions an attacker takes after lateral movement are largely dependent on the resources they were able to gain access to during the lateral movement phase. Attackers can take actions that cause data exfiltration, data loss, or launch other attacks. For enterprises, the average financial impact of data loss is now reaching $1.23 million.

Different types of attacks are associated with each stage, and they target various subsystems.
