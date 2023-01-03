<!-- ## A04: Insecure Design -->

Addresses design level flaw, others focus more on code-level issues​. An example could be an error including the exact location of a configuration file​ or a password stored as a plain text – intentional design decision​​.

Insecure Design is a new entry on the OWASP Top 10 in 2021. It's different from insecure implementation in that it has more to do with risks related to design and architectural flaws. A secure implementation might have an insecure design, which still renders an application vulnerable to attacks and exploits.​
An insecure design can not be fixed by a perfect implementation.​

If you genuinely want to 'shift left' as an industry, you need more threat modeling, secure design patterns and principles, and reference architectures. ​
:::image type="content" source="../media/enterprise-app-threats.png" alt-text="angles of attack in complex system":::
Security should be not an afterthought  - how you protect your system’s configuration secrets, handle customers data, leak implementation details during logging and so on​.
Security matters not only in development and prediction but at design as well.
Consult with security experts to ensure appropriate requirements and design decisions are being made early on​.
Use industry security standards and architectures, dedicated services like Azure KeyVault or Azure Web Application Firewall​.

A few techniques that can address insecure design are:
    - Least privilege​ principle
    - Attack surface reduction​
    - Zero Trust​ principle
    - Defense in Depth​
    - Threat Modeling​

Threat modeling is an essential part of DevSecOps because it informs your security design process and helps find vulnerabilities in your application. While it does fall under DevSecOps, it also sits neatly under education too.

:::image type="content" source="../media/tm-1.png" alt-text="Application logical components":::

Threat modeling is something that can be used to help mitigate that from the early stages of application design.
Whenever an application’s design or code is changed, you run the threat modeling process again to reflect the new state of the application and to identify any new threats that could have emerged from the changes. It’s an iterative process, performed throughout the software development lifecycle.

> [!IMPORTANT]
> Threat modeling is a process to understand security threats to a system, determine risks from those threats, and establish appropriate mitigations.

:::image type="content" source="../media/tm-2.png" alt-text="Data flow diagram with basic threat model":::

Making threat modeling part of the design phase of the application helps bake security into the design from the start, which is always going to be more effective that trying to tack it on at the end. But it’s not only useful at the design stage – it should be performed at every stage of the SDLC – requirements gathering; design; coding; testing; even deployment.
