
Governance in the cloud age must have an active component that continuously engages with other teams. Security posture management is an emerging function. It represents a step forward in the long-term convergence of security functions. These functions answer the question "how secure is the environment?", including vulnerability management and security compliance reporting. 

## Posture management and the Security operating model 

In the on-premises world, security governance followed the cadence of data it could get about the environment. This way of getting data might take time and be constantly out of date. Cloud technology now provides on-demand visibility into the current security posture and asset coverage. This visibility drives a major transformation of governance into a more dynamic organization. This organization provides a closer relationship to other security teams to monitor security standards, provide guidance, and improve processes. In its ideal state, governance is the heart of continuous improvement. This improvement engages across your organization to constantly improve security posture, which is called Posture Management and it fits in the overall security governance as shown in the diagram below: 

:::image type="content" source="../media/security-governance.png" alt-text="Diagram showing how Security Governance functions within a security organization." lightbox="../media/security-governance.png":::

Continuous improvement of asset security posture means that governance teams should focus on improving standards, and enforcement of those standards, to keep up with the cloud and attackers. Information technology (IT) organizations must react quickly to new threats and adapt accordingly. Attackers are continuously evolving their techniques, and defenses are continuously improving and might need to be enabled. You can't always get all the security you need into the initial configuration.

This Rapid Modernization Plan (RaMP) shown in the diagram below will enable you to quickly improve your security posture with the least number of challenges.

:::image type="content" source="../media/posture-management.png" alt-text="Diagram showing the Rapid Modernization Plan (RaMP)." lightbox="../media/posture-management.png":::
 
The posture management function will need to grow and continuously improve to tackle the full set of technical debt that the organization has accrued from over 30+ years of security being a low priority. Posture management will need to secure all the technologies and teams in the organization plus meet the needs of the organization as it changes (new platforms are adopted, new security tools become available to monitor and reduce risk, etc.). Any expansions in scope will take preparation to build leadership support, relationships across technical teams, posture management team skillsets, and processes.


Security posture refers to the current state of an organization's security---that is, its overall state of protection to its identities, endpoints, user data, apps and infrastructure.. The diagram below shows the three major pillars of security posture management.

![Diagram showing the three pillars of security posture management.](../media/your-security-posture.png) 

These three pillars are:

-   Protect: An organization's security posture is not static, it changes constantly in response to emerging new threats and variabilities in the environment. Enabling protections, like multifactor authentication (MFA) for administrators, strengthens a company's posture. A lack of vigilance, such as failing to update endpoints or use available protections can weaken an organizations security posture. The security hygiene of your environment helps to reduce the likelihood that threat actors will successfully compromise your workloads.
-   Detect: After mitigating all security recommendations, you also must ensure that you have threat detection in place to quickly identify suspicious activities in your workloads and trigger an alert to bring awareness about it.
-   Respond: Finally, ensure that you have automation in place to take immediate action on the alerts that you receive by appropriately responding to it with actions that can contain and mitigate the attack.

The use of benchmarks to evaluate your current environment, understand
the current gaps and provide guidance on how to improve, is a very common
practice in the IT industry. When it comes to security posture
enhancement, benchmarks can give you tangible actions based on industry
standards, such as ISO 27001 or by using cloud provider's benchmark,
such as Azure Security Benchmark for Azure workloads, or Center for
Internet Security (CIS) AWS Foundations Benchmark which is crafted for
AWS workloads. Benchmarks will also help you to accelerate the
identification of security gaps by providing remediation steps to harden
your workloads. As you remediate these security recommendations, your
workloads will get more secure, and your overall cloud security posture
is enhanced. As an architect, you'll look to benchmarks as a tool to
guide your efforts to improve the cloud security posture while follow
industry standards.

When evaluating your security hygiene for cloud workloads, consider all
available options. Take into account that every security program may
include multiple workflows. These processes might include notifying
relevant stakeholders, launching a change management process, and
applying specific remediation steps. Consider automating as many steps
of those procedures as you can, since automation reduces overhead. It
can also improve your security by ensuring the process steps are done
quickly, consistently, and according to your predefined requirements.

To improve the security hygiene of the cloud workloads, you also need to
ensure that you're using security best practices to harden these
workloads. Each workload has a different set of security best practices
that must be in place to improve its security hygiene. Make sure to
visit <https://aka.ms/MyASIS> for more information about security best
practices for Azure workloads.

## Evaluating security posture in Azure workloads

One option to evaluate the security posture of your workloads is by
using Azure Security Benchmark (ASB), which is widely used by
organizations to meet security control requirements in Azure. ASB
provides clear and concrete guidance on how to securely configure Azure
resources to meet both security and compliance requirements. ASB often
plays a key role in Azure onboarding, enabling organizations to
accelerate both initial Azure onboarding as well as ongoing
onboarding/assessment of Azure Cloud Services.

Customers often have to reconcile and harmonize multiple control
frameworks when planning and evaluating their Azure environments to meet
security and compliance requirements. This often requires security teams
to repeat the same evaluation process for the various control
frameworks, creating unnecessary overhead, cost, and effort. To address
this concern, Microsoft developed ASB to function as a harmonizing
control framework to help you quickly work with established standards in
the context of a cloud environment---standards such as CIS Controls v8
and v7, NIST SP800-53 Rev4, and PCI-DSS v3.2.1. Organizations can use
ASB to evaluate their Azure deployment's security posture consistently
and easily against these industry standards with minimal repeated work.

![Diagram showing Azure centric controls coming from C I S, P C I and NIST.](../media/azure-centric-controls.png) 

Azure Security Benchmark is surfaced in Microsoft Defender for Cloud
regulatory compliance dashboard as shown in the following image:

![Screenshot showing Azure Security Benchmark surfaced in Microsoft Defender for Cloud regulatory compliance dashboard.](../media/microsoft-defender-cloud-regulatory-compliance.png) 

This benchmark gives you visibility of which security recommendations
are open per compliance control. Under each applicable compliance
control, you have a set of assessments run by Defender for Cloud that
are associated with that control. If they're all green, it means those
assessments are currently passing; this does not ensure you're fully
compliant with that control. Furthermore, not all controls for any
particular regulation are covered by Defender for Cloud assessments, and
therefore this report is only a partial view of your overall compliance
status.

While this is the preferred benchmark for Azure, you may need to use a
different benchmark according to your organization's needs. You can
navigate through different tabs that have assigned regulatory standards to visualize the applicable compliance controls that were assessed
and the current status of each item.
