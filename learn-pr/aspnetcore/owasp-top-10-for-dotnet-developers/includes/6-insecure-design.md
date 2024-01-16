
So far, you've been focusing on unwanted coding errors leading to security flaws, i.e implementation issues surrounding user authenticating, data encryption etc. Insecure *design* is different from insecure *implementation*. Insecure design has more to do with risks related to design and architectural flaws. A secure implementation might have an insecure design, which still renders an application vulnerable to attacks and exploits.​

Exercise ***assume breach*** mentality - minimize the blast radius for breaches and prevent lateral movement by segmenting access by network, user, devices, and application awareness. Verify all sessions are encrypted end-to-end. Use analytics to get visibility, drive threat detection, and improve defenses. Authenticate and authorize based on all available data points. User identity, location, device health, service or workload are some of common data points.

You might be familiar with the term *'shift-left'*. It's often referred to testing your application early on during the application lifecycle to ensure high quality. Shift left also applies to security, even before we write the first line of code. A few activities to employ early on in the design process could include reviewing secure design patterns and principles, using reference architectures and performing threat modeling.

Let's discuss the latter in more detail. Threat modeling is an essential part of DevSecOps because it informs your security design process and helps find vulnerabilities in your application. While it does fall under DevSecOps, it also sits neatly under education too.

:::image type="content" source="../media/tm-1.png" alt-text="Diagram showing application logical components.":::

Threat modeling is something that can be used to help mitigate that from the early stages of application design.
Whenever an application’s design or code is changed, you run the threat modeling process again to reflect the new state of the application and to identify any new threats that could have emerged from the changes. It’s an iterative process, performed throughout the software development lifecycle.

> [!IMPORTANT]
> Threat modeling is a process to understand security threats to a system, determine risks from those threats, and establish appropriate mitigations.

:::image type="content" source="../media/tm-2.png" alt-text="Diagram showing data flow diagram with basic threat model.":::

Making threat modeling part of the design phase of the application helps make security into the design from the start. Threat modeling goes beyond the design stage, and can be performed at every stage of the Secure Development Lifecycle.

### Design review notes

Here, you focused your attention on the overall system architecture and design. Insecure design flows target systems as a whole and not its codebase.
Security should be not an afterthought. How you protect your system’s configuration secrets, handle customers data, and implement logging should be considered early on in the project lifecycle. A perfect implementation can't fix an insecure design.​
After conversations with your team, you better understand the functional and nonfunctional security requirements and learned about the bug bar - technique to help classify and prioritize security vulnerabilities based on their severity and potential impact.
As your new team adopts DevOps and Secure DevOps practices in an ongoing effort, you want to think of security as early and quickly as possible (by shifting security considerations left).
When contributing to your teams codebase consider following few techniques that can address insecure design:

- Least privilege​ principle - granting enough permissions to a user or service to successfully perform an operation.
- Attack surface reduction​ - limit and control what's visible to external users
- Zero Trust​ principle - never trust, always verify explicitly
- Defense in Depth​ - layered and tiered security approach
- Threat Modeling​ - understand how data flows through your system