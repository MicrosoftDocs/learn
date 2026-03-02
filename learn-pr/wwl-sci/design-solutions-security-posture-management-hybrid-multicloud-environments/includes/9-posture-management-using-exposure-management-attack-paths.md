Microsoft Security Exposure Management provides a unified view of security posture across your entire digital estate—endpoints, cloud resources, identities, and external attack surfaces. As a security architect, you design a posture management process that uses Exposure Management's capabilities to identify, prioritize, and remediate security risks before attackers exploit them.

## Understanding Security Exposure Management components

Security Exposure Management builds on four interconnected capabilities that work together for continuous threat exposure management:

| Component | Purpose | Design consideration |
|-----------|---------|---------------------|
| Attack paths | Show end-to-end routes attackers could use to reach critical assets | Define critical assets first—attack path value depends on this |
| Attack surface | Visualizes assets, relationships, and exposure across environments | Requires licensed workloads for comprehensive coverage |
| Security insights | Aggregates recommendations, metrics, and events from multiple sources | Combines Secure Score, Defender for Cloud, and other sources |
| Initiatives | Groups related metrics and recommendations by security area or threat | Use to track progress toward specific security goals |

**Design consideration**: Exposure Management consolidates data from Defender for Endpoint, Defender for Identity, Defender for Cloud Apps, Defender for Cloud, Microsoft Entra ID, and Defender EASM. Ensure these workloads are licensed and configured to maximize attack path accuracy and insight coverage.

## Designing attack path analysis

Attack paths show how an attacker could move from an entry point to a critical asset by exploiting vulnerabilities and misconfigurations. Your design must address how to use attack paths for prioritized remediation.

**Attack path generation**: The system automatically generates attack paths based on real-time environment data—asset inventory, configurations, permissions, and vulnerabilities. Paths update dynamically as your environment changes.

**Critical asset definition**: Attack paths terminate at critical assets. Before attack paths provide value, classify your critical assets:
- Predefined classifications (domain controllers, certificate authorities)
- Custom classifications for business-critical systems
- Criticality levels that prioritize protection efforts

**Choke points**: Where multiple attack paths converge, addressing a single choke point can eliminate multiple attack vectors simultaneously. Design your remediation workflow to identify and prioritize choke points for maximum impact.

**Blast radius**: Understanding how compromising one asset affects others helps prioritize protection. Use blast radius visualization to assess which assets, if compromised, would cause the greatest downstream impact.

**Hybrid attack paths**: With Defender for Cloud integration, attack paths can span on-premises and cloud environments—showing how an attacker might move from a compromised on-premises server to cloud resources or vice versa.

## Designing attack surface management

The enterprise exposure graph and attack surface map visualize your entire attack surface across endpoints, identities, cloud resources, and external exposure.

**Enterprise exposure graph**: Queries across your entire asset inventory to identify relationships, permissions, and potential vulnerabilities. Use graph queries to:
- Identify assets with specific risk characteristics
- Map relationships between users, devices, and resources
- Hunt for threats across hybrid environments

**Attack surface map**: Provides visual exploration of assets and their connections. Use the map to understand how assets relate and where exposure exists.

**Design consideration**: Cloud attack paths require Defender for Cloud with the CSPM plan enabled. Without this, cloud-related metrics and attack paths won't appear. For complete hybrid visibility, ensure both cloud and on-premises workloads contribute data.

## Designing security insights usage

Security insights aggregate actionable information from multiple sources into a unified view.

**Recommendations**: Exposure Management consolidates recommendations from:
- Microsoft Secure Score
- Microsoft Defender for Cloud
- Microsoft Defender Vulnerability Management
- Other integrated workloads

Design your remediation process to address recommendations based on their impact on initiatives and metrics rather than treating each source separately.

**Metrics**: Metrics group related recommendations for similar assets, providing exposure measurement at a glance. Each metric shows:
- Current exposure state (progress from 0 to 100)
- Affected assets
- Associated recommendations
- Weight (impact on initiative scores)

**Events**: Security events notify you when initiative or metric scores drop, indicating increased exposure. Design alerting and response workflows around these events.

## Designing initiative-based prioritization

Initiatives provide structure for managing exposure across specific security areas. Design your posture management process around initiatives that align with organizational priorities.

**Initiative types**:

| Initiative type | Examples | Use case |
|----------------|----------|----------|
| Workload initiatives | Endpoint security, Identity security, Cloud security | Assess domain-specific risk |
| Horizontal threat initiatives | Ransomware protection, Business email compromise | Address specific threat vectors |
| Threat analytics initiatives | Based on current Microsoft threat research | Respond to emerging threats |
| Zero Trust initiative | Aligned with Zero Trust adoption framework | Drive Zero Trust implementation |
| External attack surface | Integrated with Defender EASM | Manage external exposure |

**Initiative elements**:
- **Score**: Overall measure of security posture for that area
- **Target score**: Your organization's goal for the initiative
- **Metrics**: Grouped measurements contributing to the score
- **Recommendations**: Actions to improve the score
- **Events**: Notifications when scores change significantly

**Design consideration**: Mark key initiatives as favorites to display them on the overview dashboard. This ensures visibility into your highest-priority security areas.

## Specifying requirements for posture management

Design your posture management process with these requirements:

**Critical asset identification**: Before Exposure Management provides maximum value, identify and classify critical assets. Without proper classification, attack paths may not reflect your true business risk.

**Licensing and integration**: Ensure all relevant Defender workloads are licensed and contributing data. Attack paths are only as complete as the data sources feeding them.

**Scope management**: For large organizations, use device group scoping to filter data by business unit, geography, or environment. Initiative scores calculate based on the selected scope.

**Remediation workflows**: Design processes for:
- Reviewing new attack paths (especially high-risk paths to critical assets)
- Addressing choke points for maximum impact
- Responding to security events when scores drop
- Tracking initiative progress toward target scores

## Setting priorities for remediation

Structure your remediation priorities using Exposure Management data:

**Priority 1 - Choke points on paths to critical assets**: These represent the highest-impact remediation opportunities. Fixing one choke point can eliminate multiple attack paths.

**Priority 2 - High-risk attack paths**: Paths exploiting known vulnerabilities with available exploits, especially those with external entry points.

**Priority 3 - Initiative score improvements**: Focus on initiatives with the largest gap between current and target scores, particularly those aligned with compliance requirements or business objectives.

**Priority 4 - Metric-specific remediation**: Address metrics showing significant exposure (low progress scores) within your priority initiatives.

## Integrating with security operations

Design how Exposure Management integrates with your broader security operations:

**Incident context**: During incident investigation, use blast radius analysis to understand potential impact and prioritize containment.

**Proactive hunting**: Use the enterprise exposure graph to query for specific risk conditions before they become incidents.

**Continuous improvement**: Track initiative scores over time to demonstrate security posture improvements. Use the 14-day trend graphs to identify positive or negative trajectories.

**Collaboration**: Share initiative progress with stakeholders to demonstrate security investments' effectiveness and justify additional resources for remaining gaps.

Your posture management design should create a continuous cycle: discover assets and attack paths, prioritize based on critical asset risk, remediate through initiative-aligned actions, and validate improvements through score tracking.
