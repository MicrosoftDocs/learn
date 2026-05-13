Contoso's security team successfully deployed network security group (NSG) rules in the previous unit using subnet CIDR ranges. Within a week, the development team added 12 new app-tier virtual machines (VMs) as part of a scale-out. The existing rules technically still work, but the team realizes that tracking individual VM IP addresses across 40 app-tier VMs and 20 database-tier VMs is unsustainable. When the app team moves to Azure Kubernetes Service next quarter, pod IPs change with every deployment. Here, you learn how **application security groups (ASGs)** solve this maintenance problem by grouping VMs by function instead of IP address, and how to update NSG rules to reference those groups.

| Task | Approach |
|------|----------|
| Group VMs by function | Create ASGs for each tier (web, app, database) |
| Apply group membership | Associate each VM's network interface card (NIC) to the appropriate ASG |
| Update NSG rules | Replace CIDR sources with ASG references |
| Add new VMs | Associate NIC to ASG—rules apply automatically |

## Why IP-based rules break at scale

IP addresses change constantly as infrastructure evolves. VMs are redeployed, scaled, migrated, and replaced—each event changes the IP address and potentially breaks NSG rules that reference specific Classless Inter-Domain Routing (CIDR) ranges.

With large deployments, rule sets become unmanageable. A flat virtual network (virtual network) with 60 VMs across three tiers requires tracking 60 individual IPs or maintaining multiple CIDR ranges that include addresses you don't control. As Contoso discovered, adding 12 VMs to an existing tier means recalculating which CIDR blocks are in use and verifying that existing rules still cover the right endpoints.

Stale rules create security risks. A rule that was accurate last quarter can permit traffic from VMs that teams repurposed—or can block VMs that now need access. Manual tracking doesn't scale, and IP-based documentation becomes outdated in the moment documented.

The core problem is coupling. IP-based rules couple security policies to infrastructure topology. When topology changes—and it always does—security policy breaks. Application security groups decouple them.

## What application security groups are

An **application security group (ASG)** is a logical group of VMs defined by NIC membership, not IP address. ASGs exist at the Azure resource level—you create an ASG as a named resource, then associate one or more NICs to it.

The NSG rule references the ASG as a source or destination. When a NIC joins the ASG, traffic from that NIC automatically inherits the rules that reference that ASG. When you remove a NIC from the ASG, the rules no longer apply to that NIC's traffic—no rule edits required.

Compare this to the CIDR approach from the previous unit. Instead of writing "source = 10.0.2.0/24" in an NSG rule, you write "source = asg-app-tier." Any VM whose NIC is associated to `asg-app-tier` matches that rule. Adding a new VM means associating its NIC to the ASG—the NSG rule doesn't change.

ASGs don't replace NSGs. They make NSG rule sources and destinations easier to maintain. The NSG still enforces the rules; ASGs provide a dynamic, membership-based way to identify traffic sources and destinations.

> [!TIP]
> Associate all NICs to the appropriate ASG before updating NSG rules to reference those ASGs. An NSG rule that references an ASG only applies to NICs that are members of that ASG—if you update the rule first, traffic can be blocked until NIC associations are complete.

## How ASGs simplify rule management

Contoso creates three ASGs in the Azure portal to represent their three-tier architecture: `asg-web-tier`, `asg-app-tier`, and `asg-database-tier`. The team then associates each VM's network interface to the appropriate ASG. For a web-tier VM, they open the VM's network interface in the portal, navigate to **Application security groups**, and add the NIC to `asg-web-tier`.

With NICs associated to ASGs, the team updates the existing NSG rules to replace CIDR-based sources with ASG-based sources. Here's how Contoso's database-tier rules change:

**Before (CIDR-based):**

| Goal | Source | Destination port | Action |
|------|--------|------------------|--------|
| Block web → database | 10.0.1.0/24 (web subnet) | 1433 | Deny |
| Allow app → database | 10.0.2.0/24 (app subnet) | 1433 | Allow |

**After (ASG-based):**

| Goal | Source | Destination port | Action |
|------|--------|------------------|--------|
| Block web → database | asg-web-tier | 1433 | Deny |
| Allow app → database | asg-app-tier | 1433 | Allow |

The security benefit becomes clear when the app team adds new VMs. Each new VM's NIC is associated to `asg-app-tier` during provisioning. The NSG rule that permits `asg-app-tier` to reach port 1433 automatically applies to the new VM—no rule changes, no IP tracking, no downtime. If a VM is decommissioned, removing its NIC from the ASG immediately revokes the access granted by rules that reference that ASG.

ASGs also support complex scenarios. A single NIC can be a member of multiple ASGs, allowing you to grant different types of access based on overlapping group memberships. ASGs can serve as both source and destination in the same rule, as long as both ASGs are in the same virtual network.

## ASG scope and limitations

ASGs simplify rule management, but they have scope limits. ASGs are scoped to a single virtual network—you can't use an ASG created in VNet-A as a source in an NSG rule applied to resources in VNet-B. ASGs also don't span subscriptions for NSG rule purposes. If Contoso has workloads in multiple subscriptions, each subscription needs its own ASGs.

ASGs don't create subnets or change routing. They only affect NSG rule matching. An ASG has no challenge on traffic flow unless an NSG rule references it. Without the rule, the ASG is just an empty container.

Azure enforces limits on ASG usage. Each subscription supports up to 3,000 ASGs, and each NIC supports up to 20 ASG associations. In practice, these limits rarely become constraints—most organizations use fewer than 20 ASGs per virtual network to represent functional tiers, environments, or security zones.

ASGs let you write NSG rules that adapt to your workload topology without constant IP tracking. But ASGs are scoped to a single virtual network and don't help when NSG rules vary across subscriptions. When different teams manage their own VNets and NSG configurations, inconsistency creeps back in—and a single team can create rules that undermine the organization's security baseline. In the next unit, you use Azure Virtual Network Manager to enforce consistent network policy across all subscriptions from a single control plane.
