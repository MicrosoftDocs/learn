Deploying network security rules is only the first step. Contoso's security team configured network security group (NSG) rules, application security groups, and Azure Virtual Network Manager (AVNM) security admin rules to segment their environment. But the Security Officer asks a critical question: "How do we know these controls are actually working together as intended?" Here, you learn how to verify that your layered security controls produce the expected security posture using Network Watcher diagnostic tools.

| Verification goal | Tool | Validates |
|-------------------|------|-----------|
| View all rules affecting a resource | Effective security rules | Combined effect of AVNM admin rules, subnet NSG, and network interface card (NIC) NSG |
| Test a specific traffic path | IP flow-verify | Whether traffic is allowed or denied and which rule makes the decision |
| Identify configuration conflicts | Both tools together | Gaps between intended policy and actual enforcement |

## Why effective rules differ from configured rules

Azure evaluates network traffic against multiple layers of security controls in a specific sequence: AVNM security admin rules first, then subnet NSG rules, then NIC NSG rules. A single virtual machine (VM) might have three or more rule sources affecting its traffic, and the **effective security rules** are the aggregated result of all these layers.

Misconfiguration is common in multi-layer environments. A deny rule on the NIC NSG might block traffic that the subnet NSG allows. An AVNM admin rule might allow traffic that team-level NSGs deny. Priority conflicts between rules create unexpected outcomes.

Consider this analogy: reviewing a single NSG rule list is like reading one page of a three-page contract. You need all pages together to understand the agreed outcome. Without verification, you rely on configuration review alone and miss rule conflicts or missing deny rules.

The challenge for Contoso's team is clear: they configured a deny rule for web-to-database traffic on port 1433, an allow rule for app-to-database traffic on the same port, and an AVNM admin rule blocking RDP from the internet. But do these rules work together correctly when Azure evaluates them in sequence?

## Use Network Watcher to view effective security rules

Network Watcher's **effective security rules** tool shows all NSG rules affecting a specific NIC, aggregated, and sorted by evaluation order. This includes AVNM admin rules, subnet NSG rules, and NIC NSG rules in a single unified view.

You access this tool through the Azure portal in two ways: navigate to Network Watcher → NSG diagnostic, or go directly to a VM's NIC screen and select **Effective security rules**. Both paths display the same aggregated view.

The output shows each rule with critical details that help you understand the complete security posture:

- **Source**: which configuration the rule comes from (AVNM security admin configuration, subnet NSG, or NIC NSG)
- **Priority**: the rule's priority within its rule set (lower numbers evaluate first)
- **Action**: Allow or Deny
- **Port range and protocol**: what traffic the rule matches
- **Inheritance indicator**: whether the rule was inherited from a subnet NSG, applied at the NIC level, or enforced via AVNM

When you review effective security rules for Contoso's database server NIC, look for specific patterns. Are there deny rules blocking the web-to-database path on port 1433? Are there allow rules permitting the app-to-database path on port 1433? Are there any unexpected allow rules that create paths you didn't intend? Do AVNM admin rules appear correctly with their distinct source indicator?

## Test specific traffic paths with IP flow verify

While effective security rules show all rules on a NIC, **IP flow verify** tests a specific traffic direction and tells you the exact outcome. You provide a source IP, destination IP, protocol, port, and direction—IP flow verify returns whether that traffic would be allowed or denied and identifies which rule is responsible for the decision.

Access IP flow-verify through Network Watcher in the Azure portal. The verification process follows these steps:

1. Select the target VM (for example, the database server)
2. Select the network interface
3. Set the traffic direction (Inbound or Outbound)
4. Set the protocol (TCP or UDP)
5. Set the local port (for example, 1433 for SQL Server)
6. Set the remote IP address (the source VM's private IP)
7. Set the remote port (typically Any for inbound tests)
8. Select **Check** to run the verification

The result displays **Allow** or **Deny** along with the specific rule name that made the decision. This pinpoints exactly which rule in your multi-layer configuration is controlling each traffic path.

> [!TIP]
> Run IP flow verify from both directions (inbound to the destination and outbound from the source) to get the complete picture. Some rules only block traffic in one direction, and testing both perspectives reveals asymmetric configurations.

Use IP flow verify to test Contoso's critical attack paths from the initial security assessment. Test web VM to database VM on port 1433—you expect a Deny result from the deny-web-to-db-1433 rule. Test app VM to database VM on port 1433—you expect an Allow result from the allow-app-to-db-1433 rule. Test any internet source to any VM on port 3389—you expect a Deny result from the AVNM admin rule deny-rdp-from-internet.

> [!NOTE]
> IP flow-verify evaluates NSG rules and security admin configurations based on their configuration and doesn't require the Network Watcher agent VM extension to be installed on the VM. The extension is required for features such as packet capture and Connection Monitor, not for IP flow verify.

## Handle unexpected verification results

When IP flow-verify returns unexpected results, the effective security rules view helps you diagnose the problem. If a path is denied that should be allowed, check for priority conflicts. A broad deny rule with a lower priority number (which evaluates earlier) might catch the traffic before your allow-rule processes it.

Verify that application security groups (ASGs) are correctly associated with NICs. Rules that reference an ASG only apply to NICs that are members of that ASG. A NIC that isn't assigned to the referenced ASG is excluded from those rules, even if the rule configuration appears correct.

If a path is allowed that should be denied, look for missing deny rules. Azure's default rules include AllowVNetInBound, which permits traffic between resources in the same virtual network unless you explicitly deny it. Check the AVNM deployment status—if you created a security admin configuration but haven't deployed it to the target network group, those admin rules don't take effect.

When you identify the rule causing unexpected behavior in the effective security rules list, you have several remediation options. Adjust rule priorities to ensure evaluation order matches your intent. Add explicit deny rules to block traffic that default allow rules currently permit. Verify ASG assignments on NICs. Deploy pending AVNM configurations to activate admin rules.

## Complete the verification workflow

Contoso's team runs effective security rules on the database server NIC and reviews the aggregated output. The results confirm all three layers of their security controls appear correctly:

- **AVNM admin rule**: deny-rdp-from-internet (priority 100, source: Internet, port: 3389, action: Deny) ✓
- **Subnet NSG rule**: deny-web-to-db-1433 (priority 100, source: asg-web-tier, destination port: 1433, action: Deny) ✓
- **Subnet NSG rule**: allow-app-to-db-1433 (priority 200, source: asg-app-tier, destination port: 1433, action: Allow) ✓

The team then runs IP flow verify for each critical path identified in their security assessment:

- **Web VM → Database VM, port 1433**: Deny—blocked by rule deny-web-to-db-1433 ✓
- **App VM → Database VM, port 1433**: Allow—permitted by rule allow-app-to-db-1433 ✓
- **Internet → Any VM, port 3389**: Deny—blocked by AVNM admin rule deny-rdp-from-internet ✓

This verification confirms the controls work as designed. Contoso started with a flat, unsegmented network, and no verifiable security posture. After the admin implements NSG rules, configuring application security groups, deploying AVNM security admin rules, and confirming them with Network Watcher, they have a systematic, layered segmentation approach with a documented security baseline. The organization can now demonstrate to auditors and stakeholders that network segmentation controls aren't only configured but actively enforced.
