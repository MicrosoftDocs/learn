Broad inbound management-port rules can expose virtual machines to scanning, credential attacks, and exploit attempts wherever a network path exists. Deploying Azure Bastion doesn't remove those rules. Just-in-time (JIT) VM access helps restrict direct management access, but you must also review existing rules and resolve any that allow traffic outside the intended JIT window.

The following table describes new connection attempts after conflicting network rules have been resolved. Enabling JIT doesn't, by itself, prove that all previous access paths are closed.

| State | Expected behavior for new connections |
| --- | --- |
| Before remediation | Broad allow rules can expose management ports wherever a network path exists. |
| JIT configured, with no active grant | The protected direct-access path is denied when no other effective rule permits it. |
| Active JIT grant | The requested port is permitted from the approved source for the requested window, subject to the remaining network controls. |
| Grant expired | The temporary grant ends and the prior network-rule state is restored. Existing connections aren't automatically disconnected. |

## How just-in-time access works

JIT creates network restrictions for selected ports and changes the network rules to allow access when an authorized request meets the configured policy. Existing rules for those ports can take precedence over the restrictions added by JIT. NSGs evaluate rules by priority and stop at the first match, so review and remove or narrow broad management-port allows through your organization's change process.

An access request identifies the configured ports to open, the permitted connection source, and the requested time window. The policy constrains these values. The maximum request duration can be configured from five minutes to one day, although operational windows should normally be shorter.

When the window expires, Defender for Cloud restores the network rules. Established RDP and SSH connections aren't interrupted. New connections are evaluated against the resulting rules, so verify that no unintended allow path remains.

JIT can work with an NSG, a supported Azure Firewall configuration, or both. For a VM accessed through Azure Firewall, use the connection details returned after the request, including the destination network address translation (DNAT) port mapping.

> [!NOTE]
> A successful JIT request authorizes network access. It doesn't grant guest OS credentials or permissions, prove that a person connected, or terminate an existing guest session. Apply separate authentication, authorization, auditing, and session-timeout controls where required.

## Requirements for just-in-time access

This module uses Azure VMs deployed and managed through Azure Resource Manager in Azure public cloud. Enable Defender for Servers Plan 2 on the subscription. Plan 1 doesn't include JIT.

> [!NOTE]
> Check the effective Defender for Servers coverage of each target VM as well as the subscription setting. Resource-level configuration can select Plan 1 or disable coverage for individual machines in a subscription that uses Plan 2. Plan 2 can't be enabled directly at the individual resource level. If an override conflicts with the required coverage, have an authorized plan administrator resolve it and confirm the resulting coverage before rollout. Record approved exceptions rather than silently changing them. Review existing JIT policies and network rules separately from plan settings.

The VM must have an NSG associated with its network interface or subnet, or a supported Azure Firewall configuration. A firewall used for this integration must be in the same virtual network as the VM.

> [!NOTE]
> JIT's Azure Firewall integration requires **Rules (Classic)**. It doesn't support Azure Firewall Policies or firewalls controlled by Azure Firewall Manager. Don't change an organization's firewall architecture solely to make this example work. Assess the supported access design for that environment.

### Permissions to configure and request access

Viewing JIT status, configuring a policy, and requesting access are different operations. For a custom configuration role, the documented write actions are:

```text
Microsoft.Security/locations/jitNetworkAccessPolicies/write
Microsoft.Compute/virtualMachines/write
```

The portal configuration workflow requires these actions at the associated subscription scope. The documented API and PowerShell configuration workflows can use resource-group scope.

For users who request access to Azure VMs, the documented action set is:

```text
Microsoft.Security/locations/jitNetworkAccessPolicies/initiate/action
Microsoft.Security/locations/jitNetworkAccessPolicies/*/read
Microsoft.Compute/virtualMachines/read
Microsoft.Network/networkInterfaces/*/read
Microsoft.Network/publicIPAddresses/read
```

Assign the actions at scopes that cover the JIT policy and the relevant VM and network resources. The policy is a separate `Microsoft.Security` resource, so an assignment on the VM alone doesn't necessarily cover it. Reader and Security Reader can provide viewing access but don't grant the JIT initiate action. Use an appropriately scoped custom role when a user only needs to request access.

Defender for Cloud checks authorization and the configured policy when processing a request. JIT doesn't supply a separate human approval queue. If an organization requires human approval, implement that as an additional process before granting or using the necessary Azure permissions. The user still needs the required guest OS access rights.

### Permissions for supporting tasks

The JIT roles above don't automatically authorize all the network, monitoring, and governance operations used in this module. Assign these tasks to the appropriate administrators. A person who only requests JIT access doesn't need permission to change network controls, export logs, or assign policies.

The following table identifies the additional access needed for the supporting tasks. Role names are examples, not a requirement to assign every role to one person.

| Task | Additional permission or role guidance | Scope |
| --- | --- | --- |
| View effective NIC security rules | `Microsoft.Network/networkInterfaces/effectiveNetworkSecurityGroups/action`, with the resource-read permissions needed to locate the VM and NIC. Network Contributor includes the network action, or use a narrower custom role. | The relevant NICs, including each NIC inspected on a multi-NIC VM. |
| Resolve conflicting NSG rules | NSG or security-rule write permissions, and rule-delete permission if removing a rule. The exact actions depend on whether the workflow updates the NSG or an individual rule. Delegate this to the network administrator or use a suitable custom role. | Every NSG changed, with the supporting resource-group read access required by the operation. |
| Read Activity Log | Monitoring Reader, or a suitable custom role with Activity Log read access. Retain separate access to the JIT policy when correlating request details. | The relevant subscription for the subscription-level review used here. |
| Configure Activity Log export | Permission to write subscription diagnostic settings, such as through Monitoring Contributor, plus access required by the selected destination. Storage and Event Hubs destinations can require additional key-listing permissions on that destination. | The source subscription and the specific destination resources. |
| Assign the JIT audit policy | Resource Policy Contributor, or a custom role with policy-assignment write and supporting read permissions. Contributor alone can't create the assignment. | The assignment scope. A management-group assignment needs rights at that management group, not just at a child subscription. |

> [!IMPORTANT]
> Keep request-only permissions separate from permissions that can change the protection or its audit trail. Use the narrowest suitable scope, and coordinate tasks with the network, monitoring, and governance teams instead of granting Owner to make every step succeed. Access to an export destination's stored log data is also separate from permission to configure export.

## Virtual machine eligibility states

Defender for Cloud groups VMs into three states in the JIT interface:

- **Configured**: A JIT policy is present. Confirm that its protected ports, sources, durations, and effective network rules meet the intended control.
- **Not configured**: The VM supports JIT but doesn't have it enabled. This state doesn't prove that its management ports are open.
- **Unsupported**: The VM doesn't meet JIT requirements. In this module's Resource Manager estate, investigate missing NSG or supported firewall associations and whether JIT is disabled by the applicable security configuration.

Prioritize eligible VMs using effective network exposure, workload requirements, and Defender for Cloud recommendations. Configuration state and actual network exposure are distinct observations.

## Supported environments

The procedures in this module focus on Azure Resource Manager VMs in Azure public cloud. Before adapting them to another Azure cloud, confirm that Defender for Servers Plan 2 and JIT are currently available there and use that cloud's endpoints and authentication configuration. An ARM deployment or an existing plan setting alone doesn't establish current service availability.

JIT also supports AWS EC2 instances connected to Defender for Cloud in Preview, but those workflows are outside this module's scope.

Contoso's Resource Manager VMs with subnet NSGs are candidates for JIT configuration. Some VMs don't yet have a supported NSG or firewall association. Contoso first configures and validates that network protection, then reassesses JIT eligibility rather than assuming that a VM must be redeployed.

Now that you understand JIT eligibility requirements and the access control model, you're ready to enable JIT on eligible virtual machines and configure port-specific access policies.
