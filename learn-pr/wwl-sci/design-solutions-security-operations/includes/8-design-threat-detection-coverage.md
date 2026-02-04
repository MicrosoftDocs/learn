[MITRE ATT&CK](https://attack.mitre.org/) is a publicly accessible knowledge base of tactics and techniques commonly used by attackers. Created and maintained through real-world observations, many organizations use MITRE ATT&CK to develop threat models and methodologies for verifying security status in their environments.

## MITRE ATT&CK matrices

MITRE ATT&CK includes multiple matrices, each representing a threat model for different environments:

| Matrix | Description | Focus areas |
|--------|-------------|-------------|
| **Enterprise** | Tactics and techniques for attacks on corporate networks | Windows, macOS, Linux, network infrastructure, containers |
| **Cloud** | Tactics and techniques specific to cloud environments | Azure, AWS, GCP, Microsoft 365, Google Workspace, SaaS, IaaS, identity providers |
| **Mobile** | Tactics and techniques for infiltrating mobile devices | iOS, Android device attacks |
| **ICS** | Tactics and techniques for attacks on Industrial Control Systems | Operational technology, SCADA systems, industrial processes |

> [!NOTE]
> The Cloud matrix is integrated within the Enterprise matrix but focuses specifically on cloud-native attack techniques. Many organizations require coverage across both traditional Enterprise techniques and Cloud-specific techniques.

Each matrix contains multiple tactics (attacker goals) along with techniques (methods to achieve those goals). Security architects should evaluate coverage across relevant matrices based on their organization's technology environment.

## Design guidance for threat detection coverage

When evaluating threat detection coverage using MITRE ATT&CK:

- **Assess current coverage** by mapping existing detections to ATT&CK techniques
- **Identify gaps** where techniques lack corresponding detection rules
- **Prioritize based on risk** focusing on techniques most relevant to your environment and threat landscape
- **Plan incremental improvements** to systematically expand coverage
- **Consider multiple matrices** (Enterprise, Mobile, ICS) based on your technology footprint

> [!TIP]
> Use the MITRE ATT&CK framework as a common language for discussing threats and detection capabilities with stakeholders across your organization.

## Microsoft Sentinel MITRE coverage

Microsoft Sentinel provides built-in capabilities to visualize and evaluate threat detection coverage based on MITRE ATT&CK.

### View current MITRE coverage

The **MITRE** page in Microsoft Sentinel displays the coverage matrix showing currently active scheduled query and near real-time (NRT) analytics rules:

- **Coverage indicators** show how many detections are currently active for each technique
- **Search functionality** allows finding specific techniques by name or ID
- **Technique details** provide links to the MITRE ATT&CK knowledge base and active detections

Microsoft Sentinel aligns to current MITRE ATT&CK framework versions as they're released.

### Simulate possible coverage

The MITRE coverage matrix also shows *simulated* coverage—detections that are available but not currently configured. This helps you understand your organization's possible security status if all available detections were configured.

Simulated coverage includes:

- **Analytics rule templates** available in solutions from the Content Hub
- **Hunting queries** that can be converted to detections
- **Solution-specific detections** from installed solutions

When you select a specific technique, the details pane shows the number of active detections out of all available detections, helping you identify coverage opportunities.

### SOC optimization recommendations

Microsoft Sentinel provides SOC optimization recommendations that include:

- **Threat-based coverage optimizations** with scoring (High, Medium, Low) based on the percentage of recommended rules activated
- **Spider charts** showing coverage across different tactics and techniques for both user-defined and out-of-the-box detections
- **Threat scenario analysis** with the ability to view full threat scenarios and drill down into specific MITRE ATT&CK techniques
- **View by threat scenario** toggle on the MITRE ATT&CK page to filter coverage by specific threat scenarios
- **AI MITRE ATT&CK tagging recommendations** (preview) that use AI to suggest tagging detections with MITRE tactics and techniques
- **Risk-based recommendations** (preview) for adding controls to address business risks including operational, financial, and compliance risks

## Using MITRE ATT&CK in security operations

### Analytics rules

- When configuring analytics rules, **select specific MITRE techniques** to apply to your rule
- When searching for analytics rules, **filter by technique** to find relevant rules quickly
- Use technique mapping to **understand the attack coverage** each rule provides

### Incidents

When incidents are created for alerts surfaced by rules with MITRE techniques configured:

- Techniques are automatically added to incidents
- Investigators can quickly understand the attack stage and methods used
- Incident correlation considers technique relationships

### Threat hunting

- **Select tactics and techniques** when creating new hunting queries
- **Filter queries by tactics** when searching for active hunting queries
- **Use technique mapping** in bookmarks inherited from hunting queries or create custom mappings

## Coverage considerations by matrix type

### Enterprise matrix

Focus areas for corporate environment coverage:

| Domain | Key techniques to monitor |
|--------|--------------------------|
| **Initial Access** | Phishing, exploits, valid accounts |
| **Execution** | PowerShell, scripting, command-line |
| **Persistence** | Registry modifications, scheduled tasks, account creation |
| **Privilege Escalation** | Access token manipulation, UAC bypass |
| **Defense Evasion** | Obfuscation, disabling security tools |
| **Credential Access** | Credential dumping, brute force |
| **Lateral Movement** | Remote services, pass-the-hash |
| **Exfiltration** | Data compressed, transfer to cloud |

### Cloud matrix

For organizations using cloud services, evaluate coverage for cloud-specific techniques:

| Domain | Key techniques to monitor |
|--------|--------------------------|
| **Initial Access** | Valid cloud accounts, trusted relationship abuse, cloud service exploitation |
| **Persistence** | Account manipulation, implant cloud resources, modify cloud compute infrastructure |
| **Privilege Escalation** | Cloud IAM abuse, temporary elevated cloud access |
| **Defense Evasion** | Disable cloud logs, modify cloud authentication process |
| **Credential Access** | Steal application access tokens, unsecured cloud credentials |
| **Discovery** | Cloud service discovery, cloud infrastructure discovery |
| **Collection** | Data from cloud storage, data staged in cloud |
| **Impact** | Resource hijacking, data destruction in cloud |

### Mobile matrix

For organizations with mobile device deployments:

- Device compromise techniques
- Network-based attacks
- Application-level threats
- Data exfiltration from mobile devices

### ICS matrix

For organizations with operational technology environments:

- Use Microsoft Defender for IoT integrated with Microsoft Sentinel
- Monitor for techniques targeting industrial processes
- Map alerts to MITRE ATT&CK for ICS tactics
- Deploy OT-specific analytics rules and workbooks

## AI and machine learning attack coverage

Organizations deploying AI systems should also consider the **MITRE ATLAS** (Adversarial Threat Landscape for Artificial Intelligence Systems) framework. ATLAS extends threat modeling to AI-specific attack techniques:

| Tactic | Example techniques |
|--------|-------------------|
| **Reconnaissance** | Search for victim's ML artifacts, identify ML model capabilities |
| **Resource development** | Acquire ML attack tools, develop adversarial examples |
| **Initial access** | Supply chain compromise of ML models, compromised ML dependencies |
| **ML attack staging** | Backdoor ML models, craft adversarial data |
| **ML model access** | Model inference API access, physical environment access |
| **Exfiltration** | Model extraction, training data extraction |
| **Impact** | Evade ML model, denial of ML service, erode ML model integrity |

As AI workloads become more prevalent, security architects should evaluate detection coverage for both traditional MITRE ATT&CK techniques and AI-specific attack patterns described in ATLAS.

## Design recommendations

| Consideration | Recommendation |
|---------------|----------------|
| **Baseline coverage** | Start with high-priority techniques based on threat intelligence and industry reports |
| **Continuous improvement** | Regularly review and expand coverage as new techniques emerge |
| **Cross-matrix coverage** | Evaluate coverage across Enterprise, Cloud, Mobile, and ICS based on your environment |
| **AI workload coverage** | For organizations with AI deployments, evaluate coverage against MITRE ATLAS techniques |
| **Integration** | Use MITRE ATT&CK mappings across analytics rules, hunting queries, and incident response |
| **Metrics** | Track coverage percentage and improvement over time as a security maturity indicator |
