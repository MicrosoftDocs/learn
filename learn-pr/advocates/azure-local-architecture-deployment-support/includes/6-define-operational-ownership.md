A supportable architecture combines a qualified configuration, a maintained software and firmware state, valid commercial rights, and an operating agreement. The ability to install software or make a workload run isn't sufficient evidence for any of those conditions.

## Qualify the complete system

Validated Nodes, Integrated Systems, and Premier Solutions differ in integration and lifecycle responsibilities. Validated Nodes can require additional manufacturer-directed preparation, while Integrated Systems and Premier Solutions provide higher levels of integration. Automation varies by OEM, model, and supported lifecycle integration; don't infer a particular firmware-update method from the category alone. Confirm the exact catalog configuration, support agreement, and Solution Builder Extension compatibility. A familiar chassis with unqualified components isn't automatically an approved solution.

The qualification boundary can include server model, processor, memory arrangement, storage controller, drives, network adapters, driver versions, firmware, and the documented network pattern. Verify the configuration being purchased, not just a product-family name. Expansion or component replacement can change that evidence.

A *Solution Builder Extension* (SBE) is the hardware partner's integration with supported solution lifecycle operations. It helps coordinate relevant OEM software, drivers, or firmware with the platform's update process. It isn't blanket permission to install the latest independently downloaded driver. OEM means original equipment manufacturer: the partner responsible for the qualified hardware solution.

The [SBE guidance](/azure/azure-local/update/solution-builder-extension?view=azloc-2610&preserve-view=true) requires SBE implementation for new Integrated Systems and Premier Solution hardware, but older hardware and Validated Nodes can differ. Validate the exact supported update workflow rather than assuming that every catalog entry supplies identical automation.

The architect should establish an update baseline, support contacts, and an escalation route before the first incident. Firmware currency and platform currency must be evaluated together; "latest" isn't necessarily "qualified for this solution."

## Assign operational ownership explicitly

Microsoft supports the platform within its documented boundary; the manufacturer owns qualified hardware and relevant firmware or driver support. The customer still owns facilities, networking, identity, change control, backups, application health, and escalation coordination. Record who gathers evidence when a storage timeout could originate in software, a fabric, or an array.

Use the following responsibility map to assign an accountable customer role and identify the supporting evidence for each operational area.

| Responsibility | Accountable customer role | Supporting parties and required evidence |
| --- | --- | --- |
| Hardware qualification and replacement | Infrastructure owner | OEM catalog configuration, warranty, replacement process, and spare-part lead times |
| Platform configuration and lifecycle | Platform operations lead | Microsoft and OEM guidance, update baseline, health evidence, and change approval |
| Switching, routing, proxy, and DNS | Network/service owner | Fabric qualification, endpoint access, configuration records, and network incident support |
| Identity, certificates, and time | Identity/security owner | Access design, renewal ownership, recovery access, and authentication diagnostics |
| External storage, when selected | Storage owner | Array and fabric qualification, host compatibility, logs, and supplier escalation |
| Backup and disaster recovery | Recovery service owner | Retention, protected recovery assets, restore evidence, RPO and RTO results |
| Guest operating systems and applications | Workload owner | Guest support, application recovery validation, patching, and license entitlement |
| Cross-supplier incident coordination | Named incident lead | Severity rules, contact methods, evidence collection, and communication ownership |

The customer role remains accountable even when a managed service provider performs the work. Write the actual organization or team into the final operating agreement rather than leaving "vendor" as the owner.

For a storage-latency incident, start with the affected transaction, timestamps, scope, workload changes, host health, and storage or fabric events. Route the evidence to the relevant support parties without making the customer prove a final root cause before anyone coordinates the incident. Collection and transfer of logs must follow the organization's data-handling rules.

A support response time is the time to engage under contract conditions, not a guarantee that the application will recover by its RTO. If the business needs recovery faster than component replacement or supplier engagement, the architecture needs a recovery mechanism that can achieve it.

## Maintain a supported lifecycle

Lifecycle planning is continuous. It includes checking the supported release and servicing state, validating prerequisites, scheduling a maintenance window, maintaining recovery readiness, applying updates through supported mechanisms, and confirming service health afterward.

The [release support policy](/azure/azure-local/release-information-23h2?view=azloc-2610&preserve-view=true#end-of-support-for-azure-local-versions) states that a solution not updated within six months is no longer supported; Microsoft Support can then help update it to a supported version, rather than provide ordinary troubleshooting for that unsupported state. Consult the current release table for the exact version and end-of-support date. OEM validation can affect when a feature release becomes available for a particular system.

Before an update, verify that the system is healthy enough to enter maintenance, that the surviving nodes can carry the workload, and that the documented update path applies. A failed node or incomplete storage repair can make a normally safe rolling update unsafe. Don't force an operation around a health gate merely to preserve a calendar appointment.

During procurement, include the cost of maintenance headroom, platform management resources, hardware replacement, and engineering time. During operation, record evidence that the actual configuration still matches the supported baseline. Unsupported host changes can turn a routine update into an avoidable recovery event.

## Separate the service meter from guest rights

The following cost breakdown avoids hiding recurring services behind a server purchase.

| Cost component | Budget basis | Common omission |
| --- | --- | --- |
| Hardware and facilities | Servers, storage, switches, power, space, lifecycle replacements | Spare parts and expansion ports |
| Support | Microsoft, manufacturer, array, application agreements | Cross-vendor incident ownership |
| Azure Local service | Physical cores and applicable deployment tier | Charging doesn't follow allocated virtual processors |
| Guest software | Operating system and application rights | Activation isn't proof of entitlement |
| Operations services | Monitoring ingestion, retention, backup, recovery, security | Replication storage, restores, and security-service charges |
| People and lifecycle | Maintenance, qualification, recovery rehearsal | Failure-state capacity and operational staffing |

The billing documentation distinguishes L1 hyperconverged local-storage deployments, L2 external-storage or advanced deployments, and L3 disconnected operations. Adding external storage can change the meter after applicable trial periods. Don't budget permanently at trial rates. The billing page also contains cloud-connected-management language for L2/L3; resolve the selected disconnected offering's commercial requirements with Microsoft rather than inferring them from connected-cluster billing text.

Three separate questions prevent common licensing mistakes: what's charged for the infrastructure service, what rights cover each guest operating system, and what rights cover each application? A fourth question is how the software is activated. Activation answers a technical state question, not all three entitlement questions.

For example, four servers with 32 physical cores each provide a 128-physical-core inventory for commercial assessment. Allocating 80 virtual CPUs to guests doesn't turn that hardware into an 80-core platform meter. This example identifies the physical inventory; the selected offering's terms determine the actual bill and any licensing minimums or other conditions.

## Evaluate benefits without extending their scope

Azure Hybrid Benefit for Azure Local requires eligible Windows Server Datacenter licenses with active Software Assurance, allocated against physical cores. At this baseline it applies to cloud-connected L1 hyperconverged deployments without external storage, not L2 or L3. It can waive the host fee and Windows Server subscription fee, but doesn't waive hardware, support, monitoring, or unrelated services.

Windows Server subscription is a separate guest entitlement mechanism charged per physical core unless a qualifying benefit applies. Automatic Virtual Machine Activation simplifies activation on properly entitled hosts; it doesn't license SQL Server or make arbitrary guest versions eligible. Validate every possible migration target and the applicable guest-version matrix.

Software Assurance is a licensing program benefit, not a property detected by a guest VM. An architecture record should identify who verifies the organization's eligible licenses and assignments. Never infer entitlement solely from a successful activation, a portal setting, or the fact that an older deployment used a benefit.

When choosing between existing licenses and a Windows Server subscription, include all possible hosts for normal placement, live migration, and failover. If a benefit expires or the deployment changes to external storage, reassess eligibility and costs before the change. Application licenses and third-party support remain separate decisions.

Extended Security Updates aren't universally free. The documented April 1, 2026 pricing boundary distinguishes earlier eligible products from later releases, including Windows Server 2016, subject to the new pricing approach. Azure verification, product lifecycle dates, and update delivery still matter. Security updates don't restore general product support.

*Extended Security Updates* (ESUs) provide eligible security updates under defined product and program terms after the relevant support lifecycle ends. They're a time-bounded risk treatment, not a modernization plan or a guarantee of new features and general fixes.

> [!NOTE]
> A pricing example isn't proof that updates are still available. As of this module's October 27, 2026 baseline, the three-year Windows Server 2012/R2 ESU period ended on October 13, 2026. The referenced Windows Server 2016 ESU billing period starts January 13, 2027. Check the [product-specific ESU dates](/azure/azure-arc/servers/prepare-extended-security-updates) as well as eligibility, pricing, activation, and update delivery.

Use the current [billing guidance](/azure/azure-local/concepts/billing?view=azloc-2610&preserve-view=true), [Azure Hybrid Benefit eligibility](/azure/azure-local/concepts/azure-hybrid-benefit?view=azloc-2610&preserve-view=true), [Windows Server subscription and activation guidance](/azure/azure-local/manage/vm-activate?view=azloc-2610&preserve-view=true), and [ESU guidance](/azure/azure-local/manage/azure-benefits-esu?view=azloc-2610&preserve-view=true) when preparing a quote. Commercial terms and the chosen offer take precedence over this training example.

## Produce an operating agreement

Before design approval, record the qualified system and version, the chosen connectivity model, the normal and degraded workload budgets, ownership of each dependency, and the commercial assumptions. Include planned update procedures, restore and recovery evidence, incident escalation, and the events that trigger reassessment.

An operating agreement isn't a promise that failures won't occur. It makes clear which failures the design addresses, which residual risks have been accepted, and who must act when an assumption stops being true.
