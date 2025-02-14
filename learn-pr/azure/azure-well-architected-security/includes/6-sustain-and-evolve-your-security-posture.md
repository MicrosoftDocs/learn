| :::image type="icon" source="../media/goal.svg":::  Incorporate continuous improvement and apply vigilance to stay ahead of attackers who are continuously evolving their attack strategies |
| :----------------------------------------------------------------------------------------------------------------------------- |

Your security posture must not degrade over time. You must continually improve security operations so that new disruptions are handled more efficiently. Strive to align improvements with the phases defined by industry standards. Doing so leads to better preparedness, reduced time to incident detection, and effective containment and mitigation. Continuous improvement should be based on lessons learned from past incidents.

It's important to measure your security posture, enforce policies to maintain that posture, and regularly validate your security mitigations and compensating controls in order to continuously improve your security posture in the face of evolving threats.

**Example scenario**

Contoso Race Day Performance creates data capture systems for professional rally car race teams. Most of the system is embedded in the cars and provides local feedback to the driving crew, but at end of the race all telemetry is uploaded to the cloud for analytical processing. The processing combines track and environmental conditions and vehicle telemetry data into reports that can be used by the race team to evaluate their run and fine tune their strategies. The cloud system uses Azure Spark in Azure Synapse Analytics. Ancillary systems in the workload all use PaaS offerings. The system is already in use by three of the top five race teams in the world.

Race teams are highly protective of their data, and want to know what Contoso Race Day Performance is doing to keep up to date with evolving security threats that might compromise their data.

## Perform threat modeling to identify and mitigate potential threats

**Analyze each component of your workflow and evaluate potential threats that each component could be subject to. Classify the identified threats using an industry-standard methodology.**

By adopting this approach, you can produce a report of attack vectors prioritized by their severity level. Additionally, you can  identify threats and vulnerabilities quickly and set up countermeasures.

*Contoso's challenge*

- While they haven’t had a security incident yet, the workload team doesn’t have a standardized way to evaluate if there are any threat vectors that aren’t adequately addressed in existing security controls.
- The team realizes they have a blind spot with regard to the security of their workload and they are at risk of being caught off-guard if there’s a security incident.

*Applying the approach and outcomes*

- The team engages a security consulting specialist to learn how to perform threat modeling.
- After performing an initial threat modeling exercise, they find that they have well-designed controls for most threat vectors, but they do find a gap in one of the data cleanup tasks that happens after Azure Spark jobs are complete and found two insider threat vectors for data exfiltration.
- These gaps are scheduled for remediation in the next development cycle.
- The team also finds a legacy system used by a race team no longer using the service, which has significant access to race telemetry. Part of the remediation will be to decommission this system.

## Independently verify your controls

**Run periodic security tests that are conducted by experts external to the workload team who attempt to ethically hack the system. Perform routine and integrated vulnerability scanning to detect exploits in infrastructure, dependencies, and application code.**

These tests enable you to validate security defenses by simulating real-world attacks by using techniques like penetration testing.

Threats can be introduced as part of your change management. Integrating scanners into the deployment pipelines enables you to automatically detect vulnerabilities and even quarantine usage until the vulnerabilities are removed.

*Contoso's challenge*

- The threat modeling exercise helped the team uncover security gaps and they’re  now interested in validating their controls, especially after implementing their remediation.
- The team has experimented with open source tools in the past to test their security, and found the exercise fun and educational. However, they and the stakeholders would like to bring in security professionals to perform thorough and rigorous testing regularly.

*Applying the approach and outcomes*

- The team engages with a well-known Microsoft partner specializing in cloud security to discuss penetration testing.
- The workload team signs a Statement of Work for quarterly penetration testing service, mixing in one white-box test per year to ensure higher confidence.
- The consulting team also helps the dev team get antimalware installed on dev boxes and the self-hosted build agents.
- These measures give the workload team and the stakeholders a high degree of confidence that they’ll be prepared for evolving threats moving forward. 

## Get current, and stay current

**Stay current on updates, patching, and security fixes. Continuously evaluate the system and improve it based on audit reports, benchmarking, and lessons from testing activities. Consider automation, as appropriate. Use threat intelligence powered by security analytics for dynamic detection of threats. At regular intervals, review the workload's conformance to Security Development Lifecycle (SDL) best practices.**

By adopting this approach, you'll be able to ensure that your security posture doesn't degrade over time. By integrating findings from real-world attacks and testing activities, you'll be able to combat attackers who continuously improve and exploit new categories of vulnerabilities. Automation of repetitive tasks decreases the chance of human error that can create risk.

SDL reviews bring clarity around security features. SDL can help you maintain an inventory of workload assets and their security reports, which cover origin, usage, operational weaknesses, and other factors.

*Contoso's challenge*

- The developers responsible for writing the Apache Spark jobs are hesitant to introduce changes and generally take a “if it’s not broken, don’t fix it” approach to the jobs.  This means that the Python and R packages they bring into the solution are likely to get stale over time.

*Applying the approach and outcomes*

- After the workload team reviews internal processes, they see that there’s a risk of unpatched components being in the workload if the process for maintaining the Spark jobs isn't addressed.
- The teams adopt a new standard for the Apache jobs that requires that all technologies in use must be updated along with their regularly recurring update and patch schedules.
- By addressing this gap in security controls, the workload as a whole is less likely to be at risk of unpatched components. Their use of PaaS and SaaS services also helps limit their exposure to this risk as they don’t have to patch underlying infrastructure.
