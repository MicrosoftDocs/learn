The verify phase is the last step of the threat modeling process and usually happens before the system is deployed. It involves ensuring requirements are met, assumptions are validated, and security controls are in place.

## Goals

- Confirm all previous and new security requirements are satisfied for the system
- Configure Cloud Provider, Operating System, and Components to meet security requirements
- Ensure all issues are addressed with the right security controls
- Take system through manual and automated verification before deployment

> [!IMPORTANT]
> If you don't complete this phase, you won't be able to verify the security work was successfully completed.

## How Do I Start?

Start by verifying all requirements created in the first phase are met. Includes network security plans, secrets management solution implementation, logging and monitoring systems, identity and access controls, and other areas.

Then, make sure the default configuration settings from Cloud Providers, Operating Systems and Components are changed to meet all security requirements. Examples include:

- Enable Azure SQL DB transparent data encryption to protect data on disk
- Use Role Based Access Control (RBAC) to assign permissions to users, groups, and applications 
- Enable Windows Firewall across all profiles

All issues logged in the bug management solution should be resolved and all fixes verified.

## Requirements Are Met, Assumptions Are Verified, Issues Are Fixed. Now What?

The last part involves running both manual and automated verification. At Microsoft, systems are subject to a verification process before deployment, and may consist of automated scanners, code reviews, and penetration tests. 

The process can be enforced before each deployment or across time intervals, like every 6-12 months. You may want to have shorter verification cadences if you answer yes to any of the following questions:

- Will my system be used externally?
- Does it handle confidential data?
- Do I have to comply with regulations?
- Does my organization require additional security processes, such as privacy implications, operational risk, or development requirements?