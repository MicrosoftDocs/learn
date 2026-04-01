
A defense-in-depth strategy uses a layered approach to security, rather than relying on a single perimeter. Instead of depending on one mechanism to keep attackers out, defense in depth combines multiple overlapping layers of controls. Each layer provides protection so that, if one layer is breached, the next layer prevents an attacker from gaining unauthorized access to data.

Think of it like the security measures protecting a high-security vault: a locked outer door, cameras, motion sensors, an access keypad, the vault door itself, and then secured containers inside. If an attacker gets past the outer door, they still face several other barriers. The same principle applies to IT security.

## Defense-in-depth layers

A defense-in-depth strategy typically includes the following layers of security:

- **Physical security** limits access to computing infrastructure. This layer includes locked facilities, security guards, badge readers, and surveillance cameras. Ensuring that only authorized personnel can physically access servers, networking equipment, and storage hardware prevents attackers from tampering with or stealing physical components.

- **Identity and access controls** authenticate and authorize users before granting them access to resources. This layer includes multifactor authentication (MFA), role-based access control (RBAC), and conditional access policies that evaluate signals—such as sign-in location, device compliance, and risk level—before permitting access. Even if an attacker obtains a valid password, strong identity controls at this layer can prevent unauthorized access.

- **Perimeter security** protects the boundary of a network from large-scale external attacks. This layer includes distributed denial-of-service (DDoS) protection, which filters attack traffic before it can disrupt services for users, and perimeter firewalls that inspect and control traffic entering and leaving the network.

- **Network security** controls communication between resources within a network. This layer includes network segmentation—dividing the network into isolated zones so that a compromise in one zone doesn't automatically expose everything else—along with network security groups (NSGs) that restrict traffic flow based on defined rules. By limiting which systems can communicate with which other systems, network security reduces the damage an attacker can cause after compromising a single resource.

- **Compute security** protects virtual machines, containers, and other compute resources. This layer includes keeping operating systems and software patched and up to date, closing unnecessary network ports, restricting administrative access, and monitoring compute resources for unusual behavior. Attackers frequently target unpatched or misconfigured compute resources as an entry point.

- **Application security** ensures that applications are designed and deployed without exploitable vulnerabilities. This layer covers secure development practices, input validation to prevent common attacks such as SQL injection and cross-site scripting (XSS), and application-level authentication and authorization. Security testing during development—before code reaches production—is much more cost-effective than discovering vulnerabilities after deployment.

- **Data security** is the innermost and most critical layer, focused on protecting the information that matters most to an organization. This layer includes access controls that limit who can read or modify data, encryption that makes data unreadable without the appropriate keys, and data classification that identifies which data requires the strongest protections.

:::image type="content" source="../media/4-defense-depth.png" alt-text="Diagram showing defense in depth layers of security, from physical security on the outside to data at the center." lightbox="../media/4-defense-depth.png":::

### Why layered defense matters

Each layer in a defense-in-depth strategy slows down an attacker and gives defenders more opportunities to detect and respond to a threat before damage is done. A single security control—even a strong one—can fail because of a software vulnerability, a misconfiguration, or a business process that requires an exception. When multiple layers are in place, the failure of one layer doesn't immediately lead to a breach.

Defense in depth also supports a key principle of modern security: designing your strategy as if attackers will eventually get through your outer defenses, and focusing on limiting what they can do once inside. Perimeters get tested constantly, so each additional layer of protection adds meaningful resilience.

## Confidentiality, integrity, and availability (CIA)

The defense-in-depth layers described above work toward a common set of security goals, captured in the *CIA triad*: confidentiality, integrity, and availability. These three properties represent what effective security is ultimately designed to protect.

:::image type="content" source="../media/4-confidentiality-integrity-availability.png" alt-text="Diagram showing the Confidentiality, Integrity, Availability (CIA) triangle." lightbox="../media/4-confidentiality-integrity-availability.png":::

### Confidentiality

Confidentiality refers to keeping sensitive information accessible only to those who are authorized to see it. This includes customer records, financial data, passwords, private communications, intellectual property, and any other data that shouldn't be readable by unauthorized individuals.

Protecting confidentiality requires more than just encryption, though encryption is one of the most important technical controls. You also need access controls that restrict who can read data, secure transmission methods, and policies that define who is permitted to view what information and under what circumstances.

A confidentiality breach—commonly called a data breach—occurs when unauthorized parties gain access to protected information. These incidents can have serious consequences for individuals whose data is exposed and for the organizations responsible for protecting it, including regulatory penalties, legal liability, and loss of customer trust.

### Integrity

Integrity means keeping data accurate, complete, and unmodified except through authorized processes. When you send a message or store data in a database, you need assurance that what the recipient reads—or what you retrieve later—is exactly what you originally sent or stored.

Integrity can be violated by malicious actors who deliberately tamper with data, by software bugs that cause data corruption, or by problems during transmission. Unauthorized deletion—removing records that should exist—is also a form of integrity violation.

Controls that protect integrity include cryptographic hashing, which generates a unique fingerprint of data that changes if the data is modified, digital signatures, audit logs that record changes to data, and database transaction controls. When you verify the hash of a downloaded software file against the publisher's expected value, you're performing an integrity check.

### Availability

Availability means ensuring that data and systems are accessible to authorized users when they need them. An organization's systems serve no useful purpose if legitimate users can't access them.

Availability can be threatened by DDoS attacks that flood services with traffic until they stop responding, ransomware that encrypts data until a ransom is paid, hardware failures, software bugs, and natural disasters. Controls that support availability include redundant infrastructure, load balancing, automatic failover, regular backups and tested recovery plans, and DDoS protection services.

### Balancing the CIA triad

In practice, confidentiality, integrity, and availability can sometimes pull in different directions. For example, encrypting everything strongly protects confidentiality, but if encryption keys are lost, data becomes permanently inaccessible—hurting availability. Requiring complex authentication protects confidentiality and integrity but adds friction that can affect productivity.

Security teams work to find the right balance based on the sensitivity of the data, the potential impact of a breach, and the operational requirements of the business. Understanding the tradeoffs between these three properties helps organizations make informed, risk-based security decisions.

The CIA triad also helps frame the impact of attacks: attackers who steal data are targeting confidentiality, attackers who modify records are targeting integrity, and attackers who take systems offline are targeting availability. Keeping the CIA triad in mind helps organizations think about the full range of threats they need to defend against.
