
So far, you've focused on unwanted coding errors leading to security flaws; that is, implementation issues surrounding user authenticating, data encryption, and so on. Insecure *design* is different from insecure *implementation*. Insecure design has more to do with risks related to design and architectural flaws. A secure implementation might have an insecure design, which still renders an application vulnerable to attacks and exploits.​

Exercise ***assume breach*** mentality: minimize the blast radius for breaches and prevent lateral movement by segmenting access by network, user, devices, and application awareness. Verify all sessions are encrypted end-to-end. Use analytics to get visibility, drive threat detection, and improve defenses. Authenticate and authorize based on all available data points. User identity, location, device health, service, or workload are some common data points.

You might be familiar with the term *shift left*. It's often referred to as testing your application early on during the application lifecycle to ensure high quality. Shift left also applies to security, even before you write the first line of code. A few activities to employ early on in the design process could include reviewing secure design patterns and principles, using reference architectures, and performing threat modeling.

Let's discuss the latter in more detail. Threat modeling is an essential part of DevSecOps, because it informs your security design process and helps find vulnerabilities in your application. While it does fall under DevSecOps, it also sits neatly under education too.

:::image type="content" source="../media/tm-1.png" alt-text="Diagram showing application logical components.":::

You can use threat modeling to help mitigate that from the early stages of application design.

Whenever an application’s design or code is changed, you run the threat modeling process again to reflect the new state of the application and to identify any new threats that could have emerged from the changes. It’s an iterative process, performed throughout the software development lifecycle.

> [!IMPORTANT]
> Threat modeling is a process to understand security threats to a system, determine risks from those threats, and establish appropriate mitigations.

:::image type="content" source="../media/tm-2.png" alt-text="Diagram showing data flow diagram with basic threat model.":::

Making threat modeling part of the application design phase helps bake security into the design from the start. Threat modeling goes beyond the design stage, and you can perform it at every stage of the Secure Development Lifecycle.

### Design review notes

Here, you focused your attention on the overall system architecture and design. Insecure design flows target systems as a whole, and not its codebase.

Security shouldn't be an afterthought. How you protect your system's configuration secrets, handle customer data, and implement logging should be considered early on in the project lifecycle. A perfect implementation can't fix an insecure design.​

After conversations with your team, you better understood the functional and nonfunctional security requirements and learned about the bug bar, a technique to help classify and prioritize security vulnerabilities based on their severity and potential impact.

As your new team adopts DevOps and Secure DevOps practices in an ongoing effort, you want to think of security as early and quickly as possible by shifting security considerations left.

When you're contributing to your team's codebase, consider the following few techniques that can address insecure design:

- **Least privilege​ principle**: Granting enough permissions to a user or service to successfully perform an operation
- **Attack surface reduction**: Limit and control what's visible to external users
- **Zero Trust​ principle**: Never trust, always verify explicitly
- **Defense in Depth**​: Layered and tiered security approach
- **Threat Modeling**: Understand how data flows through your system
