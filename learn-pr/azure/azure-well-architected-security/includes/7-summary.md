In this module, you've looked at the five key principles of the Security pillar of the Azure Well-Architected Framework.

A Well-Architected workload must be built with a zero-trust approach. A secure workload is resilient to attacks and incorporates the interrelated security principles of confidentiality, integrity, and availability (also known as the CIA triad) in addition to meeting business goals. Any security incident has the potential to become a major breach that damages the brand and reputation of the workload or organization. 

As you design your system, use the Microsoft Zero Trust model as the compass to mitigate security risks:

Verify explicitly so that only trusted identities perform intended and allowed actions that originate from expected locations. This safeguard makes it harder for attackers to impersonate legitimate users and accounts.

Use least-privilege access for the right identities, with the right set of permissions, for the right duration, and to the right assets. Limiting permissions helps keep attackers from abusing permissions that legitimate users don't even need.

Assume breach of security controls and design compensating controls that limit risk and damage if a primary layer of defense fails. Doing so helps you to defend your workload better by thinking like an attacker who's interested in success (regardless of how they get it).

## Learn more

To learn more about workload security, review the following documentation:

- [Security design principles](/azure/well-architected/security/principles)
- [Design review checklist for Security](/azure/well-architected/security/checklist)
- [Cost Optimization tradeoffs](/azure/well-architected/security/tradeoffs)
- [Cloud design patterns that support security](/azure/well-architected/security/design-patterns)