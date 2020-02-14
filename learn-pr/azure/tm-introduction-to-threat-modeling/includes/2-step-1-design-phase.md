Capture system requirements and security assumptions in writing with **as much context as possible**. Examples include:

- **Use-case scenarios** - How will my system be used? How could it be misused?
- **Access control requirements** - Who needs access to which resources? How do I know they are who they say they are?
- **Process descriptions** - What does each part of the system do? How will they interact with each other?
- **Security assumptions** - What are the security features available from my cloud providers, operating systems, internal and external services? What do I need to enable or disable? What do I need to watch out for?

> [!NOTE]
> If you have a dedicated security team, schedule a white-boarding session with them to go over the initial design. It can save you a considerable amount of time.

Use that information to create a data-flow diagram. It is a graphical representation of your system that shows data across each stage in the data lifecycle, especially as it crosses different trust-zones. Examples include human users, service endpoints, data stores, and corporate networks. Microsoft engineering teams are required to submit data-flow diagrams as part of their security compliance requirements.