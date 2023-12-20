| :::image type="icon" source="../media/goal.svg"::: Prevent or minimize system and workload downtime and degradation in the event of a security incident by using strong security controls. You must maintain data integrity during the incident and after the system recovers. |
| :----------------------------------------------------------------------------------------------------------------------------- |

You need to balance availability architecture choices with security architecture choices. The system should have availability guarantees to ensure that users have access to data and that data is reachable. From a security perspective, users should operate within the allowed access scope, and the data must be trusted. Security controls should block bad actors, but they shouldn't block legitimate users from accessing the system and data.

**Example scenario**

Contoso Concierge runs a hotel management software system used in over 50 hotel brands in the United States. It’s responsible for booking, guest check-in, and tracks guest services and housekeeping staffing. It’s a cloud-based system that runs out of two regions in the United States. It’s mostly hosted on virtual machine scale sets. The clients in the hotels are browser-based. 

## Enhance reliability through robust security

**Use security controls and design patterns to prevent attacks and code flaws from causing resource exhaustion and blocking access.**

Adopting this approach helps ensure the system doesn't experience downtime caused by malicious actions, like distributed denial of service (DDoS) attacks.

*Contoso's challenge*

- The workload team and the workload's stakeholders consider the reliability of this system to be of the utmost importance because so many hotel guests depend on it for business and leisure travel. It must be up for hotels to run their business.
- The team has invested considerable resources into testing functional and nonfunctional requirements to ensure reliability stays high, including using safe deployment practices to reliably release application updates.
- While they have been focused  heavily on reliability, the team has been less attentive to security.  Recently, an update was released that contained a code flaw that was exploited by an attacker to bring down the whole system for many hotels. The attack overwhelmed the application servers in one region for over four hours one evening, causing issues for customers and hotel guests.
- The attacker used the Contoso application servers to proxy requests to a regional storage account to receive pregenerated folio information. An inordinately large malicious folio was generated which caused the application servers to exhaust resources on the application server as it was being loaded into memory, and client retries spread the issue across all application servers.

*Applying the approach and outcomes*

- The team looked into a design pattern to remove their application servers from the folio request flow, opting instead for a Valet Key approach. While this wouldn’t have prevented the problem, it would’ve isolated the impact.
- They also added more input validation into the system to sanitize input, which will help prevent malicious attempts like this in the future.
- Now with input sanitization and a strengthened design, one type of risk has been mitigated.

## Proactively limit attack vectors

**Implement preventative measures for attack vectors that exploit vulnerabilities in application code, networking protocols, identity systems, malware protection, and other areas.**

Implement code scanners, apply the latest security patches, update software, and protect your system with effective antimalware on an ongoing basis. Doing so  helps to reduce the attack surface to ensure business continuity.

*Contoso's challenge*

- The VMs used to host the system are Azure Marketplace images with the latest Ubuntu OS. The bootstrapping processes for a VM set up a few certificates, tweaks some SSH configuration, and installs the application code, but no antimalware tools are employed.
- While Azure Application Gateway fronts the solution, it’s only used as an Internet gateway; the web application firewall (WAF) function is not enabled currently.
- Both of these configuration choices leave the compute environment unprotected from vulnerabilities in code or through unintended installation of malware.

*Applying the approach and outcomes*

- After consulting with the security team in Contoso, the virtual machines are now enrolled in an enterprise-managed antivirus solution.
- The team also decides to enable and tune the WAF function to help protect the application code by eliminating known risky requests, such as SQL injection attempts, at the gateway level.
- The application and application platform now have additional defense in depth, to help protect against exploits that might impact the availability of the system.

## Secure your recovery strategy

**Apply at least the same level of security rigor in your recovery resources and processes as you do in the primary environment, including security controls and frequency of backup.**

You should have a preserved safe system state available in disaster recovery. If you do, you can fail over to a secure secondary system or location and restore backups that won't introduce a threat.

A well-designed process can prevent a security incident from hindering the recovery process. Corrupted backup data or encrypted data that can't be deciphered can slow down recovery.

*Contoso's challenge*

- While the system functions as active-active across regions, the team has a disaster recovery plan in place to help restore business continuity in worst case scenarios.
- Part of this plan includes shipping backups to a third region in the US.
- Unfortunately, the backups were landing in a system that wasn’t frequently monitored and had relatively lax security controls. During a drill, they realized that all of the backups have been infected with malware. If they had a real disaster at that time, they wouldn't have been able to recover successfully.

*Applying the approach and outcomes*

- The team invested time and effort to secure the backup location, adding additional network and identity controls to protect the data. Backups are now also stored in immutable storage to prevent tampering.
- After reviewing their security controls, the team finds that during the recovery process, the application runs without a WAF for a period of time. They change the order of operations to close that gap.
- Now the team is confident that the backups and the recovery process for the system are no longer an easy-to-exploit attack vector.
