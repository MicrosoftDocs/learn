---
title: Infrastructure threat modeling security assessment answers
description: Capture the state of security for your infrastructure by collecting the answers to each question.
author: rodrigosantos
ms.author: rodsan
ms.date: 03/01/2021
ms.prod: non-product-specific
ms.topic: how-to
ms.custom: infrastructure-threat-modeling-security-guide
ms.customer.intent: As an IT professional, I need to collect the answers to each security assessment question to help secure my infrastructure by using threat modeling.
---

To help you navigate the infrastructure threat modeling module, we created a fictitious company, called Woodgrove Bank.

## Company background

|Icon|About the company|
|----|-----------------|
|![Woodgrove bank](../media/WoodgroveBank.svg)|<p>Established in 2018, Woodgrove Bank is an online banking provider that gives customers the ability to conduct financial transactions and bill payments online.</p><p>With no physical locations, Woodgrove relies on an online portal and cross-platform applications for their daily operations.</p><p>Customers can choose from free online transfers, high-interest yield savings accounts, and bill payment services.</p><p>Transactions are secured using best-in-class encryption, and customer service is available 24 hours a day, 7 days a week.</p><p>With transparent fees, real-time status updates, and money back guarantee, Woodgrove has what it takes to gain your business.</p>|

## Your Task

|Icon|Task|
|----|----|
|![Task icon](../media/Task.svg)|<p>You were recently brought in by Woodgrove Bank's senior leadership team to:</p><p>a) Identify infrastructure security gaps, and</p><p>b) Find ways to reduce or eliminate risk.</p><p>After meeting with various employees from different departments and asking them the assessment questions, here's what you found out:</p>|

## Meeting Notes

|Domain|Answers Received|
|------|----------------|
|![Access Control domain](../media/policies/AccessControl-small.svg)<br>Access control|<ul><li>Engineers use VPN to access the network.</li><li>Sensitive files are accessed by anyone across all file shares.</li><li>File shares include Network Attached Storage (NAS) device, local shares, and build servers.</li><li>The 2 IT admins have write access to all shared drives.</li><li>IT admins grant write access to employees as the need comes up.</li><li>Access to O365 and source code repositories on GitHub requires only basic credentials.</li><li>Domain controller is used mainly for local machine access.</li><li>There are no group policies enforced, like password requirements.</li><li>Linux machines can be accessed with local Linux credentials.</li><li>Shared service accounts with shared passwords are used for conference room machine access.</li><li>Shared accounts have the same permission levels as regular users.</li><li>A separate Azure Active Directory grants employees access to O365.</li><li>Since they don't have federation, there are multiple credentials for multiple resources: VPN, local machines, GitHub, and at least 10 SaaS services.</li><li>2FA is enabled on some resources, but not enforced.</li><li>Engineers use their own user accounts to make changes to the system.</li></ul>|
|![Secure Development domain](../media/policies/SecureDevelopment-small.svg)<br>Secure development|<ul><li>Since they’re growing so fast, engineers adopted portions of the Security Development Lifecycle (SDL), but not all.</li><li>They do code reviews and run a few static and dynamic analysis tools.</li><li>There are no formal security reviews or threat models.</li><li>No security training, bug bar guidance, or penetration testing teams.</li><li>They use GitHub to store their source code.</li><li>They use an open-source bug management solution to create, triage, and fix bugs.</li></ul>|
|![Business Continuity domain](../media/policies/BusinessContinuity-small.svg)<br>Business continuity|<ul><li>Backups of critical systems are done weekly on the NAS and monthly on a removable drive, which is kept offsite.</li><li>Unencrypted backups.</li><li>They haven't formalized a disaster recovery plan.</li><li>They haven’t done audits or recovery tests to ensure the backups are working properly.</li></ul>|
|![Cryptography domain](../media/policies/Cryptography-small.svg)<br>Cryptography|<ul><li>They use self-signed certificates for their development environment.</li><li>Verisign certificates are used for the public facing website.</li><li>There are no guidelines on key rotation.</li></ul>|
|![Asset Management domain](../media/policies/Asset-small.svg)<br>Asset management|<ul><li>Data is kept indefinitely.</li><li>There are no classification or labeling mechanisms in place today.</li><li>Instead of classification, employees use specific folders to store documents, like "Financial," or "Human Resources". Access to those folders is unrestricted.</li><li>Since they're relatively new, they haven't disposed of any assets, so they don't have a formalized deprecation plan.</li><li>Unencrypted data at-rest.</li><li>No formal way to prevent accidental sharing of information.</li><li>The NAS stores: code artifacts, configuration files, and backups from the SQL server, domain controller, and build servers.</li><li>OneDrive was recently implemented to store company documents.</li><li>Unencrypted enterprise machine disks.</li><li>There are no requirements requiring engineers to lock their stations when they leave.</li></ul>|
|![Legal domain](../media/policies/Legal-small.svg)<br>Legal|<ul><li>Employees sign Non-Disclosure Agreements when they start, along with a recommended use of company property</li><li>There's a specialized team that handles regulatory compliance.</li></ul>|
|![Incident Response domain](../media/policies/IncidentResponse-small.svg)<br>Incident response|<ul><li>No formal incident response program for either the enterprise or product.</li></ul>|
|![Network domain](../media/policies/Network-small.svg)<br>Network|<ul><li>Network is unsegmented.</li><li>Firewall has a basic set of inbound and outbound rules.</li><li>VPN takes credentials and a pre-generated token to create a secure connection to the corporate network.</li></ul>|
|![Operations domain](../media/policies/Operations-small.svg)<br>Operations|<ul><li>Patches and updates are done manually every now and then by either one of the IT administrators.</li><li>Machines have a basic antivirus solution installed, but there isn’t a way to verify if they’re running properly.</li><li>Machines are not domain joined.</li><li>No time-out sessions to autolock machines.</li><li>The only resource engineers access on their phones is email, so they haven't yet enforced a Mobile Device Management (MDM) solution.</li><li>The amount of logging and monitoring done in the enterprise is minimal, made up of only of basic VPN and firewall actions.</li><li>No intelligence platform used today to help the enterprise sift through their logs for potential attacks.</li><li>Only default rules are used for the firewall.</li><li>Firewall logs are kept locally for seven days, and then erased to make space for the more recent logs.</li><li>Changes to the production environment require management approval.</li></ul>|
|![Physical and environmental domain](../media/policies/Physical-small.svg)<br>Physical and environmental|<ul><li>There are five build servers, one domain controller, and a NAS device in an unlocked IT room.</li><li>No cameras or log sheets available.</li><li>Access to the building requires an RFID badge, but the building owner has access to all the rooms.</li><li>There are no cameras or guards in the building.</li><li>No official visitor check-in process.</li></ul>|
|![Governance domain](../media/policies/Governance-small.svg)<br>Governance|<ul><li>No formalized information security policy or risk management program.</li><li>There are no specialized security training offerings for employees at this time.</li></ul>|
|![Security architecture domain](../media/policies/SecurityArchitecture-small.svg)<br>Security architecture|<ul><li>Virtual machines are created using default images.</li><li>No security baselines used.</li><li>Woodgrove Bank's internal infrastructure is a hybrid of both on-premises and cloud systems.</li><li>Woodgrove is moving to a cloud-only infrastructure in Azure.</li><li>There are no IoT devices or container usage in the company.</li><li>No operating system baselines.</li></ul>|
|![Supplier risk domain](../media/policies/Supplier-small.svg)<br>Supplier|<ul><li>They use many third-party SaaS offerings.</li><li>No formal way to measure security maturity levels or enforce SLAs.</li></ul>|

> [!NOTE]
> It is good practice to condense your original notes to use for threat modeling. [Here's an example](3-gather-data-summary.md) of what it would look like.