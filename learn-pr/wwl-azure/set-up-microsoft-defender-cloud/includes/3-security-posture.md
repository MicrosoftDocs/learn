## Cloud Security Posture Management (CSPM) - Remediate security issues and watch your security posture improve

In Defender for Cloud, the posture management features provide the following:

 -  **Hardening guidance** \- to help you efficiently and effectively improve your security
 -  **Visibility** \- to help you understand your current security situation

Defender for Cloud continually assesses your resources, subscriptions, and organization for security issues and shows your security posture in the secure score, an aggregated score of the security findings that tells you, at a glance, your current security situation: the higher the score, the lower the identified risk level.<br>

As soon as you open Defender for Cloud for the first time, Defender for Cloud:

 -  **Generates a secure score** for your subscriptions based on an assessment of your connected resources compared with the guidance in the **Microsoft cloud security benchmark**. Use the score to understand your security posture and the compliance dashboard to review your compliance with the built-in benchmark. When you've enabled the enhanced security features, you can customize the standards used to assess your compliance and add other regulations, such as the **National Institute of Standards and Technology (NIST)** and **Azure Center for Internet Security (CIS)** or organization-specific security requirements. You can also apply recommendations and score based on the **AWS Foundational Security Best practices standards**.
 -  **Provides hardening recommendations** based on any **identified security misconfigurations** and **weaknesses**. Use these security recommendations to strengthen the security posture of your organization's Azure, hybrid, and multicloud resources.
 -  **Analyzes and secure's your attack paths** through the cloud security graph, which is a graph-based context engine that exists within Defender for Cloud. The cloud security graph collects data from your multicloud environment and other data sources. **For example**, the cloud assets inventory, connections and lateral movement possibilities between resources, exposure to the internet, permissions, network connections, vulnerabilities, and more. The data collected is then used to build a graph representing your multicloud environment.
    
    Attack path analysis is a **graph-based algorithm that scans the cloud security graph**. The **scans expose exploitable paths attackers may use to breach your environment to reach your high-impact assets**. Attack path analysis exposes those attack paths and suggests recommendations as to how best to remediate the issues that will break the attack path and prevent a successful breach.
    
    By taking your environment's contextual information into account, such as internet exposure, permissions, lateral movement, and more. Attack path analysis identifies issues that may lead to a breach in your environment and helps you to remediate the highest risk ones first.

## Additional background and details

**National Institute of Standards and Technology (NIST)**

The National Institute of Standards and Technology (NIST) promotes and maintains measurement standards and guidance to help organizations assess risk. In response to Executive Order 13636 on strengthening the cybersecurity of federal networks and critical infrastructure, NIST released the Framework for Improving Critical Infrastructure Cybersecurity (FICIC) in February 2014.

The main priorities of the FICIC were to establish a set of standards and practices to help organizations manage cybersecurity risk, while enabling business efficiency. The NIST Framework addresses cybersecurity risk without imposing additional regulatory requirements for both government and private sector organizations.

The FICIC references globally recognized standards including NIST Special Publication 800-53 found in Appendix A of the NIST's Framework for Improving Critical Infrastructure Cybersecurity. Each control within the FICIC framework is mapped to corresponding NIST 800-53 controls within the FedRAMP Moderate Baseline.

**Center for Internet Security (CIS)**

The Center for Internet Security is a nonprofit entity whose mission is to identify, develop, validate, promote, and sustain best practice solutions for cyberdefense. It draws on the expertise of cybersecurity and IT professionals from government, business, and academia from around the world. To develop standards and best practices, including CIS benchmarks, controls, and hardened images, they follow a consensus decision-making model.

CIS benchmarks are configuration baselines and best practices for securely configuring a system. Each of the guidance recommendations references one or more CIS controls that were developed to help organizations improve their cyberdefense capabilities. CIS controls map to many established standards and regulatory frameworks, including the NIST Cybersecurity Framework (CSF) and NIST SP 800-53, the International Organization for Standardization (ISO) 27000 series of standards, Payment Card Industry (PCI) Data Security Standards (DSS), Health Insurance Portability and Accountability Act of 1996 (HIPAA), and others.

Each benchmark undergoes two phases of consensus review. The first occurs during initial development when experts convene to discuss, create, and test working drafts until they reach consensus on the benchmark. During the second phase, after the benchmark has been published, the consensus team reviews the feedback from the internet community for incorporation into the benchmark.

The Center for Internet Security (CIS) benchmarks provide two levels of security settings:

 -  Level 1 recommends essential basic security requirements that can be configured on any system and should cause little or no interruption of service or reduced functionality.
 -  Level 2 recommends security settings for environments requiring greater security that could result in some reduced functionality.

CIS Hardened Images are securely configured virtual machine images based on CIS Benchmarks hardened to either a Level 1 or Level 2 CIS benchmark profile. Hardening is a process that helps protect against unauthorized access, denial of service, and other cyberthreats by limiting potential weaknesses that make systems vulnerable to cyberattacks.
