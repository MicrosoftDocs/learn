Data centers and the applications that they host are under constant attack. We tend to imagine CSPs' hyperscale facilities as massive fortresses with impenetrable firewalls and heavily guarded ports of entry, withstanding a constant barrage of enemy mortar attacks. In practice, the "castle defense" model proves impractical for any cloud. A castle becomes indefensible, regardless of the strength of its perimeter, when its own foundation becomes susceptible to corruption.

For this reason, any public cloud customer's pro-active cybersecurity threat response model must incorporate a *resilience* protocol. Resilience in this context refers to the capability of an information system (which includes the public cloud-based portion) to withstand threats from both inside and outside the system, and continue to provide service to customers at the level they expect. Every component of an information system may be a contributor to resilience. The guiding principle of implementing a resilience model is to treat every component as though it were under constant threat, and to implement recovery and remediation measures now rather than wait for evidence of a serious or catastrophic attack to manifest itself.

In a 2019 survey, members of the (ISC)<sup>2</sup> security organization shared their views about their system security as it relates to cloud infrastructure. Some 28 percent of respondents said they had experienced a public cloud-related security incident over the previous 12 months. Among those who admitted to an incident, over one-quarter (27 percent) said their data was exposed to unauthorized access (though not necessarily accessed without authorization), with another 19 percent saying their user accounts and passwords had been compromised. One in five who experienced a breach admitted to systems being infected with malware, while only 17 percent said they were the victims of a vulnerability exploit.

Nearly two-thirds of respondents to the (ISC)<sup>2</sup> survey (64 percent) said their biggest concern about cloud security was the possibility of data loss or leakage. When the question was rephrased more pointedly, asking participants to choose the biggest security threats that cloud services faced (being allowed to choose more than one answer), 42 percent of respondents cited unauthorized access.

With each successive tier of cloud service -- from infrastructure to deployment platforms to applications -- the enterprise customer cedes control of its assets to the management and oversight of the CSP. When public cloud services first became available, respondents to surveys similar to this one often cited loss of control over their information assets as among the biggest barrier, if not the biggest, to cloud adoption. But this fear has subsided over the years, as CSPs prove themselves at least as capable of securing customer data, if not more so, than enterprises' own security engineers. As Figure 2 shows, only 22 percent of respondents to the 2019 (ISC)<sup>2</sup> survey cited "Loss of control" as a significant barrier to their organizations' cloud adoption, ranking \#7 in a list of 20.

![Figure 2: Top barriers to cloud adoption, from the 2019 (ISC)^2 Cloud Security Report. \[Courtesy (ISC)^2\]](../media/fig8-2.jpg)

_Figure 2: Top barriers to cloud adoption, from the 2019 (ISC)<sup>2</sup> Cloud Security Report. \[Courtesy (ISC)<sup>2</sup>\]_

What surveys such as this reveal is that the nature of the security threat changes depending upon whether it's being discussed in the context of strategy or the context of loss -- the subject with which risk management concerns itself. In a general sense, the most significant threat as organizations perceive it is to the privacy and integrity of their data.

## Threat taxonomy

The Cloud Security Alliance is an organization whose members comprise leaders in the IT security community serving the public cloud. From time to time, CSA publishes its taxonomy of threats to the public cloud, ranked in order of importance, based on its survey of 241 members.<sup>[1][^1]</sup> Each of the threats CSA categorizes is capable of affecting all three principal service tiers: IaaS, PaaS, and SaaS. The 2019 "Egregious Eleven" are summarized below.

### 1: Data breaches

As the CSA perceives it, a data breach is any incident of unauthorized access of information, by any unauthorized individual or automated entity, of any magnitude. A breach need not be malicious to be dangerous. Personal information may be exposed or made publicly accessible without authentication through human error or by accident in software design, even if the data itself is never accessed. An analysis of the business impact of such a breach reads like a primer for the FAIR Framework.

### 2: Misconfiguration and inadequate change control

*Change control* refers to the processes and best practices that an organization may have in place and may be following to provide resilience in the event of changes to the infrastructure and support platforms. One common cause of security incidents is a fixed configuration (a manifest or script that sets up components in an information system) that applied to a previous state of the system but no longer applies to its present state. CSA acknowledges that public cloud-based components are subject to change daily, if not even more frequently, and that change-control practices in enterprises that were accustomed to quarterly or even annual adjustments are incapable of being applied to an environment that is continually evolving.

### 3: Lack of cloud security architecture and strategy

CSA admits that enterprise customers are often led to believe by their CSPs that their existing IT environments can survive a "lift-and-shift" migration process essentially unchanged. Often because the Shared Responsibility Model is left unexplained or unintroduced, critical services become unattended once they've been migrated, and as a result, services that were relatively secure on-premises become vulnerable in the cloud. CSA goes on to suggest that customers' security practices become more robust, not less, once they've made the cloud transition - not because cloud platforms are less secure, but because they fall under a new and more aggressive threat model.

### 4: Insufficient identity, credential, access, and key management

Cryptographic protection of information access is pointless if the keys that unlock that protection are available to outsiders, particularly if they are stored on the same platforms as the assets they protect. In far too many cases, software developers have allowed for administrative access to certain resources with one or more access keys whose values they embed in comments within their source code for convenient access. CSA suggests that the same identity-management lifecycle processes that guided the enterprise when all its assets were on-premises should be applied just as rigorously, if not more so, for cloud-based platforms. By definition, any purely centralized key or secret management platform becomes a high-value target. Enterprises should strongly consider multi-factor identification systems, including physical keys such as the ones produced by Yubico<sup>[2][^2]</sup> and endorsed by the FIDO Alliance.<sup>[3][^3]</sup>

### 5: Account hijacking

This is the classic model of malicious use, where an individual gains access to an account for which he is not authorized. Although "hacking" may theoretically compromise multiple accounts, one need not go to so much trouble if he can instead use social exploitation ("phishing") to cleverly ferret out this information -- for example, by duping users into entering user names and passwords into an illicit form or login dialog that mimics the real thing.

### 6: Insider threat

The threat from malicious insiders expands when assets are deployed in public clouds. CSA (wisely) cites the Carnegie Mellon Computer Emergency Response Team (CERT) definition of an *insider threat* as "the potential for an individual who has or had authorized access to an organization's assets to use their access, either maliciously or unintentionally, to act in a way that could negatively affect the organization." In other words, unlike the case with account hijacking, an insider threat comes from maliciously leveraging authorized use of an account. In the case of a public cloud, there are two levels of potential insider threat: from the customer and from the provider. To counter these threats, CSPs enforce strict standards for their employees, vigorously monitor their networks' behavior, and conduct detailed audits. They also define HR and breach notification policies in their customer service contracts.

### 7: Insecure interfaces and APIs

CSPs provide easy-to-use, browser-based consoles and dashboards for customers to administer and provision their services. Communication through these interfaces brings with it the potential for threats to customer services should any of the handoffs between customer and provider be compromised. No matter how secure the cloud infrastructure, a single vulnerability in the provider\'s Web site may allow an attacker to take over a customer\'s account.

Most vendors now use strong, multi-factor authentication, detailed logging, anomaly detection, and secure defaults to counter this threat. Web interfaces are made generally available only after automated CI/CD checks for vulnerabilities in the code (white-box testing) as well as implementation (black-box testing).

### 8: Weak control plane

Sophisticated orchestration systems such as Kubernetes create virtual networks inside of physical ones, where resources become addressable using IP addresses. In these virtual network *overlays*, traffic pertaining to service control (the *control plane*) is separated from traffic generated by the applications that clients are using (the *data plane*). This is the guiding principle of software-defined networking (SDN), and it is what makes cloud computing possible. CSA now acknowledges that it perceives a security threat after these planes have been separated, and no individual within the customer organization has any visibility or control over the logical processes being maintained within the control plane.

### 9: Metastructure and applistructure failures

Neither of these terms has entered the common vernacular, and both deserve further explanation. You are familiar with the concept of infrastructure, which is the support layer for system services whose existence should not be seen or felt by the end user. CSA defines *metastructure* as the interface between infrastructure and the resources it supports, comprised of components of the control plane or management plane that may be remotely accessible to administrators.<sup>[4][^4]</sup> *Applistructure* in the CSA model is comprised of the application components themselves, coupled with the services that deploy and manage them. Both are new concepts in information systems, and not even software developers use these words to describe them. Nevertheless, CSA depicts the handoff point between metastructure services and customer-controlled services as the *customer line of demarcation*, or the "waterline." Above this waterline, it suggests, customers should familiarize themselves with the proper procedures for deploying and implementing applications and services. To the extent that they don't understand these procedures, CSA suggests, this part of the transaction chain becomes vulnerable to exploit.

### 10: Limited cloud usage visibility

This condition occurs within organizations, CSA says, when their IT staff lack visibility into the nature of how their cloud resources are being utilized, and thus have no way of ascertaining or estimating whether a utilization pattern may be consistent with nefarious use. This happens most often in cases of "shadow IT," where employees or contractors provision cloud-based services (for example, block storage or file storage) without permission from their IT departments, and certainly without their oversight or management. Lack of visibility may also occur, says CSA, when administrators are unable to see or analyze behavior within sanctioned applications after users have been authenticated and access has been granted.

### 11: Abuse and nefarious use of cloud services

Malicious individuals may be capable of leveraging vulnerable aspects of the public cloud transaction process (see the above explanation of the "waterline") to launch attacks targeting individual users or the cloud services themselves. Public clouds have been unwittingly used for command-and-control botnets, CAPTCHA cracking, and rainbow table computations (a method for cracking hash functions) -- actions that successfully apply brute force rather than logic to achieve unauthorized access. CSPs attempt to counter this threat through strict registration checks and comprehensive monitoring of all network traffic -- for example, filtering metadata from e-mail logs to ascertain whether a customer's account may be sending spam.

### References

1. _Cybersecurity Insiders (2019). *Cloud Security Report*. <https://crowdresearchpartners.com/2019-cloud-security-report/>._

2. _Yubico. *YubiKey*. <https://www.yubico.com/products/yubikey-hardware/>._

3. _FIDO Alliance. <https://fidoalliance.org/>._

4. _Cloud Security Alliance. *Cloud Security Alliance Guidance 4.0 project on GitHub*. <https://github.com/CloudSecurityAlliancePublic/CSA-Guidance/blob/master/Domain%201-%20Cloud%20Computing%20Concepts%20and%20Architectures.md>._

[^1]:  <https://crowdresearchpartners.com/2019-cloud-security-report/>  "Cybersecurity Insiders (2019). *Cloud Security Report*."

[^2]:  <https://www.yubico.com/products/yubikey-hardware/>  "Yubico. *YubiKey*."

[^3]:  <https://fidoalliance.org/>  "FIDO Alliance."

[^4]:  <https://github.com/CloudSecurityAlliancePublic/CSA-Guidance/blob/master/Domain%201-%20Cloud%20Computing%20Concepts%20and%20Architectures.md>  "Cloud Security Alliance. *Cloud Security Alliance Guidance 4.0 project on GitHub*."
