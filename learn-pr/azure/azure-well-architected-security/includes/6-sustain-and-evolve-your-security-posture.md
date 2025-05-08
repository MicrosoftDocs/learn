| :::image type="icon" source="../media/goal.svg"::: Hackers are always coming up with new methods, so your security approach needs to keep up. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Don't let your defenses get stale. Keep tuning your security operations so you can spot and handle problems faster. Try to align your improvements with industry best practices. That way, you're better prepared to catch problems sooner and contain and resolve them more effectively. You'll learn from past incidents to get better over time.

Make sure you're regularly checking how strong your security is, enforcing the right policies, and testing your protections to make sure they still work. It's important to keep improving and stay ahead of new threats.

**Example scenario**

Contoso builds data systems for pro rally car teams. Most of the system is embedded in the cars and gives real-time feedback to drivers. After each race, data about the track, weather, and car performance gets uploaded to the cloud for analytical processing. The cloud system uses Apache Spark in Azure Synapse Analytics to turn that data into reports that help teams evaluate and improve their performance. The system is already used by three of the top five race teams in the world.

These teams are very protective of their data. They want to know that Contoso is staying on top of security and ready to handle any new threats that could put their data at risk.

## Do threat modeling to find and resolve potential threats

**Analyze each part of your workflow and consider what could go wrong. Use an industry-standard methodology to classify the identified threats.**

Threat modeling is the process of identifying, understanding, and addressing potential security threats before they become real problems. Analyzing your workload helps you create a report that ranks attack paths by how serious they are and makes it easier to spot threats and weak spots quickly.

*Contoso's challenge*

- Even though they haven't had a security problem yet, the workload team doesn't have a clear way to check if all possible threats are covered by their current security setup. 

- They realize that there's a gap in their security, and if something goes wrong, they might not be ready.

*Applying the approach and outcomes*

- The team brings in a security consulting specialist to learn how to do threat modeling.

- After their first exercise, they find that they have well-designed controls for most threat vectors, but there are some gaps:
  - One problem was in a data cleanup task that runs after Apache Spark jobs. It had two insider threat risks for data leaks.
  - An old system used by a race team that's no longer active still had access to sensitive race data.
- They've scheduled fixes for the next development cycle, including shutting down the old system.

## Test controls yourself

**Have security experts try to safely hack your system occasionally to find weak spots. Regularly scan your infrastructure, code, and tools to catch any vulnerabilities before they become real problems.**

Running security tests that mimic real-world attacks, like penetration testing, helps you see if your defenses actually work.

Threats can sneak in during updates or changes, so it's smart to build vulnerability scanners right into your deployment process. That way, you can catch problems early and even block risky code from going live until it's fixed.

*Contoso's challenge*

- The threat modeling exercise helped the team find some gaps in their security setup. Now they want to make sure their fixes are strong and that nothing was missed.

- They've used open-source tools to test security and found it fun and useful. However, the team and stakeholders want to bring in security professionals to do thorough and rigorous testing regularly.

*Applying the approach and outcomes*

- The team contacts a well-known Microsoft partner that specializes in cloud security to talk about penetration testing.

- The workload team signs a Statement of Work for quarterly penetration testing, including one *white-box test* each year for extra confidence.
- The consulting team also helps the development team install anti-malware on dev boxes and the self-hosted build agents.
- Now, both the team and stakeholders feel a lot more confident that they're ready for potential threats.

## Get current, and stay current

**Ensure that your systems always run the latest updates and security patches. Keep checking how things are working by using audit reports, benchmarks, and test results to spot areas to improve. Consider automation where possible. Use smart threat detection tools that can spot problems as they happen. And every so often, check that your setup still follows Security Development Lifecycle (SDL) best practices.**

Keeping your security strong takes ongoing effort. By learning from real-world attacks and test results, you can stay ahead of attackers who are always finding new ways to break in. Automating repetitive tasks also helps reduce human mistakes that could create risks.

SDL reviews bring clarity around security features. They also help you keep track of your workload's assets and their security reports, which cover where they came from, how they're used, and any weak spots they might have.

*Contoso's challenge*

- The developers that write the Apache Spark jobs are hesitant to make changes. They don't think that it's necessary. But this means that the Python and R packages they bring into the solution are likely to get stale over time.

*Applying the approach and outcomes*

- After the workload team reviews internal processes, they realize that if they don't keep the Apache Spark jobs up-to-date, they could end up with unpatched components in their system.

- The teams use a new standard for the Apache Spark jobs that all technologies in use must be updated, along with their regular update and patch schedules.
- This method helps close the security gap and lowers the risk of the entire workload running outdated software. Plus, their PaaS and SaaS services help limit their exposure to this risk because they don't have to patch underlying infrastructure.
