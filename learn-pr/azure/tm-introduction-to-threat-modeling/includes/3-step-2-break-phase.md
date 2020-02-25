## Enumerate Threats and Brainstorm Solutions

Threat modeling helps you focus on the right areas and provides you with a framework that generates potential threats and suggests strategies that help reduce or eliminate risk.

First, choose between:

- **System** - find all potential threats in your system, including different ways to help reduce or eliminate risk
- **Attacker** - identify who would want to attack your system, what their motivations and means would be, and so forth

> [!NOTE]
> Microsoft product engineers mostly focus on the system. Penetration testing teams focus on both.

Next, select a framework to help generate all the different ways to break your system. Microsoft traditionally uses STRIDE, an acronym for the six main threat categories that provide an extensive, but not exhaustive, list of threats as part of threat modeling:

| Category | What It Means |
| ---------- | ------------------------------------------------------------ |
| Spoofing | Pretends to be someone or something else |
| Tampering | Changes data without authorization |
| Repudiation | Claims to not have done something |
| Information Disclosure | Sees data they are not supposed to see |
| Denial of Service | Brings your system down |
|Elevation of Privilege| Has unauthorized access to data |