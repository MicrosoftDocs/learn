| :::image type="icon" source="../media/goal.svg":::  Prevent corruption of design, implementation, operations, and data to avoid disruptions that can stop the system from delivering its intended utility or cause it to operate outside the prescribed limits. The system should provide information assurance throughout the workload lifecycle. |
| :----------------------------------------------------------------------------------------------------------------------------- |

The key is to implement controls that prevent tampering of business logic, flows, deployment processes, data, and even the lower stack components, like the operating system and boot sequence. Lack of integrity can introduce vulnerabilities that can lead to breaches in confidentiality and availability.

**Example scenario**

Contoso Paint Systems creates vapor sensing and ventilation control systems for industrial spray painting machines. The system is also used to automatically capture air quality data for environmental impact reporting purposes. They have a cloud-based application backing their IoT devices that are distributed throughout painting booths. On-premises components of the application run on Azure Stack HCI and custom IoT devices. The system is in early prototype phase, and the workload team plans to release the production version within a year. 

## Defend your supply chain

**Continuously protect against vulnerabilities and detect them in your supply chain to block attackers from injecting software faults into your infrastructure, build system, tools, libraries, and other dependencies. Vulnerabilities should be scanned for during build time and runtime**

Knowing the origin of software and verifying its authenticity throughout the lifecycle will provide predictability. You'll know about vulnerabilities well in advance so that you can proactively remediate them and keep the system secure in production.

*Contoso's challenge*

- The engineering team is implementing their build and release pipelines, but haven't yet addressed the integrity of the build system.
- They've opted to use a few open-source solutions in both the firmware and the cloud components.
- They’ve heard how a supply chain compromise or malicious insiders can corrupt code which can then be used to disrupt systems or even exfiltrate data. If their customer's  environmental reporting were impacted in such a way that resulted in a failure to report or a misrepresentation that is found in an audit, the effect on Contoso and their customer could be catastrophic.

*Applying the approach and outcomes*

- The team modifies their build processes for both firmware and the backend cloud systems, and now include security scanning steps to alert on known common vulnerabilities and exposures (CVEs) in dependencies. Additionally, they now include malware scanning of the code and packages as well.
- They also look at antimalware options for running on Azure Stack HCI, such as Windows Defender Application Control.
- These measures help increase confidence that the firmware and software that get deployed as part of this solution won’t perform unexpected actions, impacting the integrity of the system or the customer’s environmental reporting requirements.

## Employ strong cryptographic mechanisms

**Establish trust and verify by using cryptography techniques like code signing, certificates, and encryption. Protect those mechanisms by allowing reputable decryption.**

By adopting this approach, you'll know that changes to data or access to the system is verified by a trusted source.

Even if encrypted data is intercepted in transit by a malicious actor, the actor won't be able to unlock or decipher the content. You can use digital signatures to ensure that the data wasn't tampered with during transmission.

*Contoso's challenge*

- The devices selected for sensing and data transfer are currently not capable of enough processing power to support HTTPS or even custom encryption.
- The workload team plans to use network boundaries as primary isolation technique.
- A risk analysis review highlighted that unencrypted communication between IoT devices and control systems can lead to tampering, and network segmentation shouldn’t be considered sufficient. 

*Applying the approach and outcomes*

- Working with the manufacturer of their custom IoT device, the team decides to use a higher powered device that supports not only certificate based communication, but also supports code signing validation on chip, so that only signed firmware will execute.

## Optimize the security of your backups

**Ensure backup data is immutable and encrypted when data is replicated or transferred.**

By adopting this approach, you'll be able to recover data with confidence that backup data wasn't changed at rest, inadvertently or maliciously.

*Contoso's challenge*

- Every month the Environment Protection Agency emissions report is generated, but these reports only need to be submitted three times a year.
- The report gets generated and then stored in an Azure Storage account until it’s needed to be sent. This is done as a backup in case the reporting system experiences a disaster.
- The backup report itself isn’t encrypted, but is transferred over HTTPs to the storage account. 

*Applying the approach and outcomes*

- After performing a security gap analysis, the team sees that leaving the backup unencrypted is a risk that should be addressed. The team addresses the risk by encrypting the report and storing it in Azure blob Storage’s Write One, Read Many (WORM) immutable storage option.
- The new approach ensures that the integrity of the backup is maintained.
- As an additional integrity measure, the report generated out of the main system now compares a SHA hash against the authoritative backup to detect any tampering with the primary data source.