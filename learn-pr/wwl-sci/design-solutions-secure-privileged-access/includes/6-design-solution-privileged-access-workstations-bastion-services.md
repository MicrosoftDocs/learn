As a security architect, you need to design solutions that protect the devices and pathways used for privileged access. A compromised administrative workstation can undermine every other security control in your environment. This unit covers design considerations for Privileged Access Workstations (PAW) and secure remote access solutions.

## Design principles for privileged access devices

When designing privileged access device strategies, apply these principles:

**Isolate privileged activities**: Separate administrative tasks from standard productivity activities like email and web browsing. These common attack vectors shouldn't exist on devices used for sensitive operations.

**Establish hardware trust**: Base your security on hardware-rooted trust using Trusted Platform Module (TPM), Secure Boot, and device attestation. Software-only protections can be bypassed by sophisticated attackers.

**Layer protections progressively**: Not all administrative tasks require the same protection level. Design device tiers that match security controls to the sensitivity of the tasks performed.

**Assume compromise of standard devices**: Treat non-hardened devices as potentially compromised. Design your architecture so that attackers who compromise a standard workstation can't pivot to privileged systems.

## Privileged Access Workstation architecture

A [Privileged Access Workstation (PAW)](/security/privileged-access-workstations/privileged-access-devices) is a hardened workstation configured specifically for sensitive administrative tasks. PAWs protect high-value accounts by providing a trusted device isolated from common attack vectors.

When designing your PAW strategy, consider three device security profiles that progressively increase protection:

| Security control | Enterprise | Specialized | Privileged |
|------------------|:----------:|:-----------:|:----------:|
| Intune managed | Yes | Yes | Yes |
| Deny BYOD enrollment | No | Yes | Yes |
| Security baseline applied | Yes | Yes | Yes |
| Microsoft Defender for Endpoint | Yes | Yes | Yes |
| Local admin rights removed | No | Yes | Yes |
| Application control (AppLocker/WDAC) | No | Audit | Enforced |
| Applications installed only by IT | No | Yes | Yes |
| Web browsing restricted | Allow most | Allow most | Deny default |

**Enterprise devices** provide baseline security for general users. **Specialized devices** remove local admin rights and restrict application installation for roles handling sensitive data. **Privileged Access Workstations** implement the strictest controls—blocking email, web browsing, and all non-essential applications—for administrators of critical systems.

> [!IMPORTANT]
> PAW users require separate accounts and often separate devices for productivity tasks. While this adds operational overhead, it's essential for protecting accounts that could compromise your entire environment.

### Design decisions for PAW deployment

When architecting your PAW solution, evaluate these options:

| Decision | Options | Considerations |
|----------|---------|----------------|
| **Physical vs. virtual** | Dedicated hardware or Azure Virtual Desktop | Physical provides stronger isolation; virtual offers centralized management |
| **Scope** | All admins or tiered by role criticality | Start with Tier 0 (identity/domain admins), expand based on risk |
| **Provisioning** | Windows Autopilot or manual build | Autopilot ensures consistent, trusted device state from OEM |
| **Application delivery** | Intune or Configuration Manager | Cloud-native management simplifies policy enforcement |

## Design for secure remote access

Remote privileged access requires protecting the communication channel and the endpoint. Design your remote access solution using these Zero Trust principles:

**Verify explicitly**: Require phishing-resistant authentication (FIDO2 security keys or certificate-based authentication) for all remote privileged sessions. Validate device health and compliance before granting access. Use Conditional Access to evaluate risk signals continuously.

**Use least privilege**: Grant remote access only to specific resources needed for the administrative task. Implement time-limited sessions that automatically terminate. Require just-in-time activation through PIM rather than standing remote access permissions.

**Assume breach**: Segment networks so that compromised remote sessions can't pivot to other resources. Monitor all remote session activity and alert on anomalies. Record privileged sessions for forensic analysis.

The following Microsoft solutions help you implement these principles.

### Azure Bastion for Azure resources

[Azure Bastion](/azure/bastion/bastion-overview) provides secure RDP and SSH connectivity to Azure virtual machines without exposing public IP addresses. When designing Bastion deployments:

- **Select the Standard SKU** for production workloads—it supports native client connections, custom ports, and session recording
- **Deploy zone-redundant** configurations for availability requirements
- **Enable session recording** to maintain audit trails of privileged sessions
- **Integrate with PIM** to require just-in-time role activation before granting remote access
- **Restrict source IPs** using Network Security Groups on the Bastion subnet

### Virtual desktop for privileged access

For organizations requiring centralized management, Azure Virtual Desktop or Windows 365 can host privileged access sessions:

- Create **dedicated host pools** for privileged users separate from general workforce pools
- Configure **single-session hosts** for privileged access to prevent session isolation issues
- Apply **Conditional Access policies** requiring compliant PAW devices and specific network locations
- Implement **session timeouts** appropriate to the security level

> [!TIP]
> Combine virtual desktop solutions with physical PAWs for defense in depth. Users connect from a hardened PAW to a managed virtual desktop, providing two layers of isolation from potentially compromised environments.

The combination of hardened endpoints, secure connectivity, and continuous verification creates a privileged access architecture that protects your most sensitive administrative operations.
