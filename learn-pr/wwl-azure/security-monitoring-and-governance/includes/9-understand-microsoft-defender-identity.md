**Microsoft Defender for Identity** (formerly Azure Advanced Threat Protection) is cloud-based security solution detecting identity-based threats, compromised accounts, and malicious insider activities targeting on-premises Active Directory environments. Defender for Identity monitors user activities, authentication events, and domain controller traffic to identify suspicious behaviors indicating credential theft, lateral movement, domain dominance attempts, and account compromise.

Identity-based attacks represent primary attack vector for modern cyber threats. Attackers target user credentials through phishing, password spraying, credential theft, and privilege escalation to gain unauthorized access to networks and data. Defender for Identity provides continuous monitoring and behavioral analytics detecting these threats early in attack lifecycle before significant damage occurs.

## Architecture and deployment

**Defender for Identity architecture:**

**Components:**

- **Defender for Identity portal:** Cloud-based management portal accessed at `https://security.microsoft.com/` for viewing alerts, investigating threats, and configuring policies.
- **Defender for Identity sensors:** Lightweight agents installed directly on domain controllers monitoring authentication traffic, Kerberos events, NTLM authentication, LDAP queries, and network activities without requiring dedicated servers or port mirroring.
- **Microsoft Defender XDR integration:** Defender for Identity integrates with Microsoft Defender XDR (formerly Microsoft 365 Defender) providing unified security operations across identities, endpoints, email, applications, and cloud resources.
- **Cloud service:** Azure-hosted analytics engine processing sensor data, correlating events, applying behavioral analytics and machine learning models, generating security alerts, and providing threat intelligence.

**Deployment prerequisites:**

- **Active Directory environment:** On-premises Active Directory Domain Services (AD DS).
- **Domain controllers:** Windows Server 2012 or later for sensor installation.
- **Network connectivity:** Domain controllers require outbound HTTPS (port 443) connectivity to Defender for Identity cloud service.
- **Licensing:** Microsoft Defender for Identity licenses (included in Microsoft 365 E5, Enterprise Mobility + Security E5, or standalone).
- **Permissions:** Domain Administrator or Enterprise Administrator rights for sensor installation.

**Install Defender for Identity sensor:**

1. **Download sensor installer** from Defender for Identity portal.
2. **Copy installer** to domain controller.
3. **Run installer** as administrator with **Access Key** from portal.
4. **Sensor registers** with cloud service and begins monitoring.
5. **Repeat installation** on all domain controllers for comprehensive coverage.

## Threat detection capabilities

**Credential theft detection:**

- **Pass-the-Hash attacks:** Detects authentication attempts using stolen NTLM hashes.
- **Pass-the-Ticket attacks:** Identifies Kerberos ticket theft and reuse.
- **Over-pass-the-Hash attacks:** Recognizes NTLM hash conversion to Kerberos tickets.
- **Golden Ticket attacks:** Detects forged Kerberos TGTs providing domain-wide access.
- **Silver Ticket attacks:** Identifies forged service tickets for specific resources.
- **Skeleton Key attacks:** Detects backdoor passwords providing access to any account.

**Reconnaissance activities:**

- **Account enumeration:** Identifies attackers probing for valid usernames.
- **Network mapping:** Detects SMB session enumeration revealing network structure.
- **DNS reconnaissance:** Identifies suspicious DNS queries mapping domain infrastructure.
- **Directory services queries:** Detects unusual LDAP queries gathering domain information.

**Lateral movement:**

- **Remote execution:** Detects PsExec, WMI, PowerShell remoting, and scheduled tasks creating remote sessions.
- **Suspicious service creation:** Identifies services created for persistence or execution.
- **Overpass-the-hash:** Recognizes credential reuse across multiple systems.

**Domain dominance:**

- **DCSync attacks:** Detects replication requests extracting all domain credentials.
- **DCShadow attacks:** Identifies unauthorized domain controller registration.
- **Suspicious domain controller promotions:** Detects unauthorized DC installations.
- **Skeleton key malware:** Recognizes domain controller backdoors.

**Compromised accounts:**

- **Abnormal behavior:** Detects unusual authentication patterns, working hours violations, geographic anomalies.
- **Brute force attacks:** Identifies password spraying and credential stuffing attempts.
- **Suspicious authentications:** Recognizes broken trust relationships, expired account access, unusual protocols.
- **VPN connection anomalies:** Detects suspicious remote access patterns.

## Alert investigation

**Security alerts:**

When Defender for Identity detects suspicious activity, security alert is generated in Defender portal.

**Alert properties:**

- **Severity:** High, Medium, Low based on threat level and potential impact.
- **Category:** Credential theft, reconnaissance, lateral movement, domain dominance, exfiltration.
- **MITRE ATT&CK mapping:** Alignment with MITRE framework tactics and techniques.
- **Affected entities:** User accounts, computers, domain controllers involved in suspicious activity.
- **Evidence:** Detailed timeline of events, source IPs, authentication attempts, network activities.

**Investigation workflow:**

1. **Review alert** in Microsoft Defender portal Security Alerts section.
2. **Examine alert details:**
   - Timeline of suspicious activities.
   - Affected user accounts and computers.
   - Source and destination IP addresses.
   - Authentication methods and protocols used.
3. **Check user risk level:** Review user's risk score and previous suspicious activities.
4. **Investigate related alerts:** Identify correlated alerts indicating multi-stage attack.
5. **Review user activity timeline:** Examine all user activities surrounding alert timestamp.
6. **Take response actions:**
   - **Disable compromised account:** Prevent further unauthorized access.
   - **Reset password:** Force password change for affected accounts.
   - **Require MFA re-enrollment:** Reset multifactor authentication registration.
   - **Isolate affected systems:** Disconnect compromised computers from network.

**Automated investigation and response:**

Microsoft Defender XDR provides automated investigation capabilities:

- **Automatic alert correlation:** Groups related alerts into incidents representing complete attack campaigns.
- **Automated investigation:** Analyzes alerts, examines related entities, identifies attack scope.
- **Recommended actions:** Provides remediation recommendations based on investigation findings.
- **Automated remediation:** Optionally executes automatic response actions (disable accounts, quarantine devices).

## Integration with Microsoft Defender XDR

Defender for Identity integrates with Microsoft Defender XDR providing unified security operations.

**Unified incident management:**

- **Cross-domain incidents:** Alerts from Defender for Identity, Defender for Endpoint, Defender for Office 365, and Defender for Cloud Apps correlated into unified incidents.
- **Complete attack story:** Full attack timeline spanning identity, endpoint, email, and cloud resources.
- **Single investigation interface:** Investigate attacks across entire attack surface from single portal.

**Advanced hunting:**

Query Defender for Identity data using Kusto Query Language (KQL):

```kql
// Find all Pass-the-Hash attacks in last 7 days
IdentityLogonEvents
| where Timestamp > ago(7d)
| where ActionType == "PassTheHashDetection"
| project Timestamp, AccountName, DeviceName, LogonType, IPAddress
| order by Timestamp desc
```

**Automated response:**

Configure automated response actions triggered by Defender for Identity alerts:

- **Disable user accounts** automatically when high-confidence compromise detected.
- **Require MFA re-enrollment** for accounts exhibiting suspicious behavior.
- **Isolate devices** attempting lateral movement.
- **Generate tickets** in ServiceNow, Jira, or other ITSM systems for security team review.

## Best practices

**Comprehensive sensor deployment:**

Install sensors on all domain controllers ensuring complete visibility into authentication traffic and user activities across entire domain.

**Enable audit policies:**

Configure advanced audit policies on domain controllers capturing detailed security events:

```powershell
# Enable advanced audit policies
auditpol /set /category:"Account Logon" /success:enable /failure:enable
auditpol /set /category:"Account Management" /success:enable /failure:enable
auditpol /set /category:"DS Access" /success:enable /failure:enable
auditpol /set /category:"Logon/Logoff" /success:enable /failure:enable
```

**Regular alert review:**

Security teams should review Defender for Identity alerts daily, investigating high and medium severity alerts promptly.

**Tune alert sensitivity:**

Configure learning period allowing Defender for Identity to baseline normal user behaviors, reducing false positives.

**Integrate with SIEM:**

Export Defender for Identity alerts to Security Information and Event Management (SIEM) systems for correlation with other security data.

Microsoft Defender for Identity provides essential identity threat detection capabilities identifying compromised accounts, credential theft, lateral movement, and domain dominance attempts targeting Active Directory environments. Through continuous monitoring, behavioral analytics, and integration with Microsoft Defender XDR, organizations achieve comprehensive protection against identity-based attacks throughout attack lifecycle. The next unit explores integrating GitHub Advanced Security with Microsoft Defender for Cloud for unified security visibility.
