## Multiple Choice
An IT staff member at a large corporation is tasked with managing the configuration of hundreds of computers across multiple departments. The challenge is to enforce consistent settings and configurations, while also allowing for specific requirements of different departments. How can Group Policy in Windows Server assist in this task?
( ) Group Policy allows for individual configuration of each computer, ensuring unique settings for every department. {{Incorrect. Group Policy is designed for centralized management, not individual configuration.}}
( ) Group Policy can only affect an entire site or domain within the organization, without any focus on a single organizational unit. {{Incorrect. Group Policy can be refined to target a single organizational unit.}}
(x) Group Policy allows administrators to define and deploy settings centrally, affecting an entire site or domain, or focusing on a single organizational unit. {{Correct. Group Policy provides centralized management of settings, which can be deployed across the organization or targeted to specific units.}}

## Multiple Choice
A system administrator needs to temporarily disable a GPO link due to recent changes causing production issues. What action should the administrator take to resolve this?
( ) Enable Block Inheritance on the domain or OU {{Incorrect. Block Inheritance prevents all Group Policy settings from GPOs that link to parents in the Group Policy hierarchy, not just one specific GPO.}}
( ) Increase the precedence value of the GPO {{Incorrect. Increasing the precedence value of a GPO does not disable it, but rather lowers its priority compared to other GPOs.}}
(x) Disable the GPO link on the OU's Linked Group Policy Objects tab {{Correct. Disabling the GPO link will block the application of that specific GPO for the given domain or OU.}}

## Multiple Choice
A system administrator needs to ensure that a specific GPO takes the highest level of precedence and its policy settings prevail over any conflicting policy settings in other GPOs. What should the administrator do?
( ) Link the GPO to a higher level in the console tree {{Incorrect. Simply linking the GPO to a higher level doesn't necessarily enforce its settings over others.}}
( ) Set the GPO link to Block Inheritance {{Incorrect. Block Inheritance prevents a GPO from inheriting settings from parent containers, it doesn't enforce its settings over others.}}
(x) Set the GPO link to Enforced {{Correct. When a GPO link is set to Enforced, the GPO takes the highest level of precedence and its settings prevail over any conflicting ones.}}

## Multiple Choice
A system administrator needs to enforce password, account lockout, and Kerberos version 5 authentication protocol policies across all users and computers in the domain. Which Group Policy Object (GPO) should they utilize?
( ) Default Domain Controllers Policy {{Incorrect. The Default Domain Controllers Policy GPO affects only domain controllers or other computer objects that are in the Domain Controllers OU.}}
( ) Local GPO {{Incorrect. Local GPOs are primarily used when computers aren't connected to domain environments.}}
(x) Default Domain Policy {{Correct. The Default Domain Policy GPO is linked to the domain, and it applies to Authenticated Users. It contains policy settings that specify password, account lockout, and Kerberos version 5 authentication protocol policies.}}

