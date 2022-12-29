

Because you need to carefully manage a cross-functional team to prepare for deployment, you intend to follow best practices before you move to production.

1. Define your architecture. From a purely architectural perspective, this will be an uncomplicated solution.

    - Determine where to run the data connector agent container. If your SAP systems are running in Azure, it might be convenient to create a virtual machine and install the Docker engine and required tools, or use AKS. If your SAP systems are on-premises or running in another cloud or hosted environment, you need to determine where to run the data connector agent.
    - Determine access for SAP team members. Your SAP people might need role-based access to a Microsoft Sentinel workspace, for example.

2. Define governance policies. Determine user access controls and data retention policies. Depending on their user role, users will need different levels of access. The access needs will affect the rules you set up. Data retention policies might already be part of your compliance efforts, but be aware that the solution can ingest a large amount of data. This can affect pricing and how long it takes certain queries to run.

3. Set up a proof-of-concept, or test, system on a non-production SAP system. This helps you understand how your team works together and how to best establish procedures around the entire solution. When ready, you move the solution to production.

4. Establish the starting point for watchlists and rules. The Microsoft Sentinel solution for SAP enables a granular level of customization. The resulting complexity requires you to involve your SOC compliance and SAP counterparts to understand the level of customization you’ll need. To start, you decide to run your penetration tests by using the built-in watchlists and a single predefined rule. This helps you avoid results that give false positives and confusing data. You’ll tune the rule to reduce false positives and align with your governance and compliance strategies. You plan to add and test one rule at a time. These are the easiest rules to implement:

    - Change in Sensitive Privileged User
    - Client configuration change
    - Sensitive privileged user login
    - Sensitive privileged user makes a change in other
    - Sensitive privilege user password change and login
    - Brute force (RFC)
    - Function module tested
    - The SAP audit log monitoring analytics rules

5. After testing is complete and you’ve validated your implementation, you plan to move it to production. You’ll change the SAP system information and anything else that has been configured in the proof-of-concept solution that exposes sensitive data. Because your SAP sandbox will include fictitious names and simulated user access and sensitivity settings, you need to document how you’re going to change those items in your overall plan.
