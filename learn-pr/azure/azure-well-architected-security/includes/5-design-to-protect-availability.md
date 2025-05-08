| :::image type="icon" source="../media/goal.svg"::: Use strong security controls to help your system stay up and running, even if there's a security incident. Ensure that your data stays accurate during the incident and after the system recovers. |
| :----------------------------------------------------------------------------------------------------------------------------- |


You should find the right balance between keeping things running smoothly and keeping them secure. The system should always be up so people can get to the data they need. But at the same time, only the right people should have access, and the data should be trustworthy. Security controls should block bad actors but not slow down legitimate users.

**Example scenario**

Contoso Concierge runs a hotel management software system used by over 50 hotel brands across the United States. It handles bookings, check-ins, guest services, and housekeeping. The system is cloud-based, runs in two United States regions, and is mostly hosted on virtual machine scale sets. Hotel staff access it through a browser.

## Enhance reliability through robust security

**Use security controls and design patterns to stop attacks and bugs from overloading the system or locking people out.**

This approach helps keep the system up and running, even if someone tries to take it down with something like a distributed denial of service (DDoS) attack.

*Contoso's challenge*

- The workload team and the workload's stakeholders know that this system must be extremely reliable because hotel guests rely on it for both business and leisure travel. If it goes down, hotels can't run properly.

- They team has put a lot of effort into testing functional and nonfunctional requirements to make sure the system works well and stays operational, including using safe ways to roll out updates.
- They've focused on keeping things reliable, but they haven't paid as much attention to security. A recent update had a bug that hackers took advantage of, crashing the system for several hotels. The attack overloaded servers in one region for over four hours, causing major problems for guests and staff.
- The attacker used the app's servers to sneak in requests to a regional storage system and pull up fake folio data. One of those fake folios was huge and caused the servers to run out of memory. Then, when users tried again, it spread the problem to all the servers.

*Applying the approach and outcomes*

- The team changed the design so the app servers no longer handle folio requests directly. Instead, they're using a Valet Key approach to limit access. This approach wouldn't have stopped the attack completely, but it would have kept the damage contained.

- They also added better input checks to clean up anything suspicious before it reaches the system.
- With stronger input filtering and a smarter design, they've reduced the risk of this kind of attack happening again.

## Proactively reduce risky entry points

**Set up protections ahead of time to block common ways that attackers try to break in, like bugs in your code, weak network setups, or missing antivirus.**

Regularly scan your code, install security updates, keep software current, and run antivirus tools. These practices help reduce the ways that attackers can get in, and they help keep things running smoothly.

*Contoso's challenge*

- The system runs on Azure VMs (virtual machines) that use the latest Ubuntu images from Azure Marketplace. When each VM starts up, it installs some certificates, adjusts a few SSH settings, and loads the app code. But it doesn't use any antivirus or anti-malware tools.

- Azure Application Gateway fronts the solution, but it's only used as an internet gateway. The web application firewall (WAF) function isn't enabled currently.
- These choices leave the system exposed to potential risks, like vulnerabilities in the code or accidental malware installs.

*Applying the approach and outcomes*

- After talking with the security team in Contoso, the VMs are now enrolled in an enterprise-managed antivirus solution.

- The team also enables and fine-tunes the WAF function to block risky traffic, like SQL injection attempts, before it even reaches the app.
- Both the app and its platform now have stronger layered defenses to help keep the system stable and secure.

## Secure your recovery strategy

**Make sure your backup and recovery setup is just as secure as your main environment, including security controls and frequency of backup.**

You should always have a clean, safe version of your system ready to go in case something goes wrong. That way, you can switch over to a secure backup system and restore data without introducing any threats.

If your recovery process isn't well-designed, a security problem like encrypted backup data that you can't decipher or corrupted backup data can slow down recovery.

*Contoso's challenge*

- The system runs in active-active mode across regions, and the team has a disaster recovery plan to help restore operations in worst case scenarios.

- Part of this plan involves sending backups to a third region in the United States.
- But during a recent drill, they found out those backups were being stored in a system that wasn't checked often and didn't have strong security
- All of the backups have been infected with malware. If they had a real disaster at that time, they wouldn't have been able to recover successfully.

*Applying the approach and outcomes*

- The team invested time and effort to secure the backup location. They added stronger network and identity protections, and now backups are stored in a way that can't be changed or tampered with.

- After reviewing their security controls, the team finds that during the recovery process, the application runs without a WAF for a period of time. They change the order of operations to close that gap.
- Now the team is confident that the backups and the recovery process are much more secure and not easy targets anymore.
