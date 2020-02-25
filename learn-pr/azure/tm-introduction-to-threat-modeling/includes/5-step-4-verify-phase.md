## Check Fixes and Assumptions

As you reach the final stages of designing your system, verify that:

- Risk has been properly reduced or eliminated
- Security assumptions have been validated for your services providers, open-source components, and any other functionality outside of your direct control

The verification can be done manually, automatically or both. At Microsoft, services are subject to a verification process before deployment, and may consist of automated scanners, code reviews, and penetration tests. The process can be enforced before each deployment or across time intervals, such as every 6-12 months. The process cadence depends on:

- **System** - Will my system be used externally? Does it handle confidential data? Do I have to comply with regulations?
- **Organization** - Does my organization require additional security factors, such as privacy implications, operational risk, or development requirements?