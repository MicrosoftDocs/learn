Tailwind Traders is interested in more of Microsoft Defender for Cloud’s enhanced security features. These enhanced security features include vulnerability assessments, file integrity monitoring, and adaptive application controls. In this unit, you learn how Azure Arc-enabled servers together with Microsoft Defender for Servers can unlock even more security functionality.

## Overview of Microsoft Defender for Servers

Microsoft Defender for Servers is one of the enhanced security features of Microsoft Defender for Cloud. Defender for Servers adds threat detection and advanced defenses to your Windows and Linux machines whether they're running in Azure, on-premises, or in a multicloud environment. Core benefits of Defender for Servers include:

- Microsoft Defender for Endpoint Integration
- Virtual machine behavioral analytics (and security alerts)
- Fileless security alerts
- Integrated Qualys vulnerability scanner
- File integrity monitoring
- Adaptive application controls
- Regulatory compliance dashboard and reports
- Missing OS patches assessment
- Security misconfigurations assessment
- Endpoint protection assessment
- Non-Microsoft vulnerability assessment

## Integration with Microsoft Defender for Endpoint

Defender for Servers includes Microsoft Defender for Endpoint. Together, they provide comprehensive endpoint detection and response (EDR) capabilities.

When Defender for Endpoint detects a threat, it triggers an alert. The alert is shown in Defender for Cloud. From Defender for Cloud, you can also pivot to the Defender for Endpoint console and perform a detailed investigation to uncover the scope of the attack. When you enable Defender for Servers, you give Defender for Cloud access to the Defender for Endpoint data related to vulnerabilities, installed software, and alerts.

## Vulnerability assessment tools

Defender for Servers includes a choice of vulnerability discovery and management tools. From Defender for Cloud's settings pages, you can choose whether to deploy these tools to your machines. Any discovered vulnerabilities are shown in a security recommendation.

- **Microsoft threat and vulnerability management**: Discover vulnerabilities and misconfigurations in real time with Defender for Endpoint, without the need for more agents or periodic scans. Threat and vulnerability management prioritizes vulnerabilities based on the threat landscape, sensitive information, and business context.  
- **Vulnerability scanner powered by Qualys**: Qualys is one of the leading tools for real-time identification of vulnerabilities in your hybrid virtual machines. You don't need a Qualys license or even a Qualys account; everything is handled seamlessly inside Defender for Cloud.  

## File integrity monitoring (FIM)

File integrity monitoring (FIM) examines files and registries of operating systems and application software for changes that might indicate an attack. A comparison method is used to determine if the current state of the file is different from the last scan of the file. You can use this comparison to determine if valid or suspicious modifications were made to your files.

When you enable Defender for Servers, you can use FIM to validate the integrity of Windows files, your Windows registries, and Linux files.  

## Adaptive application controls (AAC)

Adaptive application controls are an intelligent and automated solution for defining allowlists of known-safe applications for your machines. When you've configured adaptive application controls, you get security alerts if any application runs other than the ones you defined as safe.

## Fileless attack detection

Fileless attacks inject malicious payloads into memory to avoid detection by disk-based scanning techniques. The attacker's payload then persists within the memory of compromised processes and performs a wide range of malicious activities.

With fileless attack detection, automated memory forensic techniques identify fileless attack toolkits, techniques, and behaviors. This solution, available by default, periodically scans your machine at runtime, and extracts insights directly from the memory of processes. Specific insights include the identification of:

- Well-known toolkits and crypto mining software
- Shellcode, which is a small piece of code typically used as the payload in the exploitation of software vulnerabilities
- Injected malicious executable in process memory

Fileless attack detection generates detailed security alerts that include descriptions with process metadata such as network activity. These details accelerate alert triage, correlation, and downstream response time.  
