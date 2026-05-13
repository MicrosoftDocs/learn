Microsoft Defender for Endpoint integration, agentless scanning capabilities, and File Integrity Monitoring work together to create multiple layers of visibility and protection on your server estate. Each capability addresses a different detection need—from real-time behavioral threat detection to offline malware scanning to detecting unauthorized file changes that might indicate lateral movement by an attacker.

| Capability | What It Provides | Plan Requirement | Data Source |
|-----------|-----------------|------------------|-------------|
| Microsoft Defender for Endpoint (MDE) integration | EDR, behavioral analytics, threat intelligence | Plan 1 or Plan 2 | MDE agent sensor |
| Agentless scanning | Software inventory, vulnerability assessment, secrets scanning, malware scanning | Plan 2 | Disk snapshots analyzed offline |
| File Integrity Monitoring | Change detection for OS files, registries, application files | Plan 2 | MDE agent + agentless scanning |

## Manage the Microsoft Defender for Endpoint integration

The Microsoft Defender for Endpoint extension autoprovisions to every supported VM when you enable Defender for Servers. This extension deploys the MDE sensor, which provides endpoint detection and response (EDR) capabilities including behavioral analysis, threat intelligence integration, and vulnerability assessment through continuous software monitoring. The sensor runs as a lightweight service on Windows and Linux machines, monitoring process behavior, network connections, and file system changes to detect suspicious activity in real-time.

The extension appears in the Azure portal with the name **MDE.Windows** on Windows VMs and **MDE.Linux** on Linux VMs. You can verify deployment status by navigating to a VM's **Extensions** screen or by checking the **Asset Inventory** in Defender for Cloud, where each VM displays its MDE integration status. A status of **Monitored** indicates the sensor is deployed, reporting data, and actively protecting the machine.

In most environments, you leave autoprovisioning enabled to ensure consistent protection across all VMs without manual intervention. However, you can disable autoprovisioning if you need to manually control which machines receive the MDE sensor or if you want to deploy Defender for Endpoint through an alternative method like Microsoft Intune or Group Policy. To disable autoprovisioning, navigate to **Environment Settings** > **Settings & Monitoring** > **Endpoint protection** and toggle the setting to **Off**. After disabling autoprovisioning, you become responsible for deploying and maintaining the MDE sensor through your chosen deployment method.

## Configure agentless scanning capabilities for Plan 2

Agentless scanning in Defender for Servers Plan 2 provides four distinct security capabilities that run during the daily disk snapshot analysis. These capabilities operate as a unified feature set—when you enable agentless scanning, all four capabilities activate together and you can't selectively disable individual features.

**Software inventory** catalogs every installed application, package, and component on scanned VMs. The inventory data feeds into Defender for Cloud's asset management views, giving you a complete picture of what software runs across your server estate. This visibility helps you identify unauthorized software installations, locate machines running deprecated frameworks, and track software version distribution across environments.

**Vulnerability assessment** uses the same Defender Vulnerability Management engine that powers agent-based scanning. During disk analysis, the agentless scanner identifies installed software versions, compares them against vulnerability databases, and reports exploitable weaknesses. The findings appear alongside agent-based vulnerability results in the Defender portal, providing redundant coverage that persists even if the agent is disabled or removed.

**Secrets scanning** analyzes disk contents to identify exposed credentials, API keys, certificates, connection strings, and other secrets that could grant attackers unauthorized access to systems and data. The scanner examines configuration files, scripts, environment variable files, and application directories where developers commonly store secrets during development but forget to remove before deploying to production. When secrets are detected, Defender for Cloud generates high-severity alerts with remediation guidance.

**Malware scanning** inspects files in the disk snapshot to detect malicious code, backdoors, rootkits, and other indicators of compromise. This capability is exclusive to Defender for Servers Plan 2—it isn't available if you enable agentless scanning through Defender CSPM alone. The offline analysis approach means the scanner can detect dormant malware that isn't actively running, fileless malware artifacts stored on disk, and malicious code that might evade runtime detection by hiding in encrypted archives or obfuscated scripts.

## Extend agentless scanning to Arc servers and multicloud environments

Agentless scanning supports not only Azure VMs but also AWS EC2 instances and GCP compute instances connected through Defender for Cloud's multicloud onboarding. For AWS and GCP resources, you configure agentless scanning through the same **Environment Settings** interface, ensuring consistent vulnerability and malware visibility across your entire hybrid and multicloud server estate.

The same 24-hour scanning schedule applies to all supported platforms. For Azure VMs, agentless scanning supports disks encrypted with customer-managed keys (CMK), ensuring that even highly regulated workloads with strict encryption requirements can benefit from agentless capabilities. This encryption support is critical for Contoso Manufacturing, where compliance requirements mandate CMK encryption for all data at rest.

## Enable and configure File Integrity Monitoring

File Integrity Monitoring (FIM) detects unauthorized changes to operating system files, Windows registries, application software files, and Linux system files. These changes might indicate an attack in progress—for example, an attacker modifying system binaries for establishing persistence, altering registry keys to disable security controls, or tampering with application configuration files to redirect data flows.

FIM requires Defender for Servers Plan 2 and has one core prerequisite: the Microsoft Defender for Endpoint agent must be deployed to the VM through the Defender for Servers extension. Enabling agentless scanning is optional but recommended—it extends FIM coverage to custom file paths beyond the default monitored locations and adds a daily validation layer through disk snapshot analysis.

To enable FIM, navigate to **Microsoft Defender for Cloud** > **Environment settings** > select the relevant subscription > locate the Defender for Servers plan and select **Settings** > in the **File Integrity Monitoring** section, toggle the setting to **On** > select **Edit configuration** to choose a Log Analytics workspace. After enablement, configure the monitored paths by selecting specific files, directories, or registry keys to watch. Default paths cover critical OS locations including system binaries, security policy files, and authentication components. Custom paths allow you to monitor application-specific configuration files—for Contoso Manufacturing, this includes PLC integration software configuration files and OT device communication settings.

FIM uses two complementary data sources. The MDE agent sensor monitors file changes in real-time, generating change events within seconds of a modification. Agentless scanning extends monitoring to custom paths and provides a daily validation layer that detects changes even if an attacker disables the agent. This dual-source approach ensures resilient change detection that's difficult for attackers to evade completely.

## Review and respond to File Integrity Monitoring events

Change events appear in **Defender for Cloud** under the **File Integrity Monitoring** dashboard. Each event shows what file changed, when the change occurred, who made the change (if identifiable through process tracking), and whether the change matches a known threat pattern. The dashboard allows you to filter events by severity, time range, and affected machines to focus on suspicious modifications that require investigation.

For baseline changes during scheduled maintenance windows, you can mark events as expected to reduce alert noise. Over time, FIM learns your environment's normal change patterns and surfaces anomalous modifications more effectively. However, the system doesn't automatically suppress alerts—you must explicitly acknowledge expected changes to refine the baseline.

In Contoso Manufacturing's factory environment, FIM provides critical visibility into OT system integrity. If an attacker compromises a factory server and modifies a PLC communication driver to intercept production commands, FIM detects the binary modification and alerts the security team within seconds. Even if the attacker disables the MDE agent to hide their activities, the next agentless scan detects the unauthorized file change and generates an alert, ensuring the compromise doesn't remain undetected for long.

The combination of MDE integration, agentless scanning capabilities, and File Integrity Monitoring transforms Contoso's factory servers from opaque assets into comprehensively monitored systems with multiple overlapping detection layers. An attacker must evade agent-based monitoring, avoid leaving file system artifacts that agentless scanning detects, and make changes that don't trigger FIM alerts—a nearly impossible task that drastically increases the cost and complexity of successful attacks.
