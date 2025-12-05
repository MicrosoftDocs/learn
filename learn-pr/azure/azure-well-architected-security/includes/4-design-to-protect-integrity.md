| :::image type="icon" source="../media/goal.svg":::  Make sure your system stays reliable and does what it's supposed to, without getting tampered with or disrupted. The system should keep your data safe and trustworthy from start to finish. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Add controls to protect everything from your code and workflows to your data, and even the underlying infrastructure like the OS and run process. If any part of the system is compromised, it can open the door to bigger problems like data leaks or outages.

**Example scenario**

Contoso Paint Systems creates vapor sensing and ventilation control systems for industrial spray painting machines. Their system also tracks air quality for environmental reporting. They have a cloud-based app that supports their IoT devices in the painting booths. On-premises components of the app run on Azure Stack HCI and custom IoT devices. Right now, they're in the prototype phase, but the workload team aims to launch the production version within a year.

## Defend your supply chain

**Make sure your tools, libraries, and build systems are safe from tampering. Scan for vulnerabilities during builds and while things are running.**

Knowing where your software comes from and checking that it's legitimate throughout the life cycle helps you catch problems early and fix them before they reach production.

*Contoso's challenge*

- The engineering team is setting up their build and release pipelines, but they haven't made sure the build system is secure or reliable yet.

- They're using some open-source tools in both their firmware and cloud systems.
- They've heard how supply chain attacks or insider threats can sneak in bad code that could mess with systems or leak data. If their customer's environmental reporting gets compromised, it could be a huge problem for both Contoso and the customers.

*Applying the approach and outcomes*

- The team updates their build processes for both firmware and back-end cloud systems to include security scans for common vulnerabilities and exposures (CVEs) and malware in dependencies, code, and packages.

- They also look at anti-malware options for their Azure Stack HCI setup, such as Windows Defender Application Control.
- These steps help make sure the software and firmware that they ship doesn't do anything unexpected, and that their customers' reporting stays accurate and secure.

## Employ strong cryptographic mechanisms

**Use strong cryptography, like encryption, certificates, and code signing, to build trust. Make sure only trusted sources can decrypt these mechanisms.**

When you adopt this approach, only trusted sources can access or change your system and data.

Even if someone intercepts encrypted data, they can't read it without the right key. And digital signatures help confirm that nothing was tampered with along the way.

*Contoso's challenge*

- The devices that they chose for sensing and data transfer don't have enough processing power to support HTTPS or custom encryption. 

- The workload team plans to use network boundaries as their primary isolation technique.
- A risk review flagged that unencrypted communication between IoT devices and control systems could be a big problem. Just segmenting the network isn't enough.

*Applying the approach and outcomes*

- They worked with the device manufacturer to upgrade to a more powerful model. The new devices support certificate-based communication and can verify signed firmware before running it.

## Optimize the security of your backups

**Make sure your backups are encrypted and can't be changed after they're saved, especially when they're being moved or copied.**

When you adopt this approach, if you ever need to recover data, you can trust that the backup wasn't tampered with, either by accident or on purpose.

*Contoso's challenge*

- Contoso generates the Environment Protection Agency emissions report every month, but they only need to submit it three times a year.

- They store the report in an Azure Storage account as a backup, just in case something goes wrong with the main system.
- The backup report isn't encrypted and is sent over HTTPS to the storage account. 

*Applying the approach and outcomes*

- After doing a security gap analysis, the team realizes that the unencrypted backup is a risk.

- They now encrypt the report and store it in Azure Blob Storage by using the write-once, read-many (WORM) setting, which keeps the file from being changed.
- They also add a check. The system now compares a Secure Hash Algorithm (SHA) hash of the report with the backup to make sure nothing is altered.