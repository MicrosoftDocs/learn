The Azure Well-Architected Framework is a guide that helps ensure that your workload is: 

- Resilient, available, and recoverable.
- **As secure as you need it to be.**
- Worth the investment.
- Developed and operated responsibly.
- Meeting its goals on time.

A Well-Architected workload must be built with a Zero Trust approach. A secure workload can withstand attacks and follows the security principles of confidentiality, integrity, and availability, also known as the *CIA Triad*, while meeting business goals. Any small problem can cause major damage to the brand and reputation of the workload or organization.

To measure how secure your overall strategy is, start with these questions:

- Do your defenses make it hard and costly for attackers to compromise your system?

- Are your security measures effective in limiting the impact of an incident?
- Do you understand how valuable your system is to an attacker and the impact if it's compromised?
- Can the workload and operations quickly detect, respond to, and recover from disruptions?

Use the Microsoft Zero Trust model to guide your system design and reduce security risks:

- **Verify explicitly** so that only trusted users can do what they're supposed to, from places you expect. This practice helps stop attackers from pretending to be real users.

- **Use least-privilege access** by giving people just the permissions they need, only for as long as they need them, and only to the things they need access to. This practice keeps attackers from misusing extra permissions that aren't necessary.

- **Assume breach** by planning as if your defenses might fail. Add backup protections to reduce the impact if something goes wrong. This practice helps you stay ahead by thinking like an attacker.

The concepts described in this module aren't all-inclusive of reliability in a workload, but they represent the core principles and some of their key approaches. For a complete overview of the Well-Architected Framework pillars, check out the [Azure Well-Architected Framework](/azure/well-architected) as you start planning and designing your architecture.

Each unit in this module dives into one [design principle](/azure/well-architected/security/principles) and three approaches for that principle. You can find examples of the approaches in each unit to see how they can be applied to real-world scenarios. The examples are all based on a fictional company.

