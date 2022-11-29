

Deploying this solution requires the cooperation and efforts of multiple roles at Contoso. After all, you need to integrate a security solution between two distinctly different environments, with an agent running in between. With cross-functional team collaboration, you can plan, deploy, configure, operate, change, and maintain this solution. Your team might include the following roles, with the following responsibilities.

- **Azure System Administrator**. Deploy the agent virtual machine in Azure and Azure networking to ensure that the agent is accessible from both SAP and Microsoft Sentinel. Configure any unique user roles in Azure as necessary.
- **Microsoft Sentinel Administrator**. Set up and modify the Microsoft Sentinel solution for SAP within Microsoft Sentinel. Ensure that the data connector is present in Microsoft Sentinel, and make analytics and workbooks available and operational.
- **Microsoft Sentinel Security Analyst**. Use and possibly create workbooks, notebooks, and queries to hunt for specific threats in your SAP systems and other combined signals. The Microsoft Sentinel Security Analyst can be the same person as the Microsoft Sentinel Administrator, but at Contoso (like other large organizations), the roles are filled by two different people.
- **SAP BASIS Administrator**. Apply SAP change requests that are necessary to run the solution. Create the role that allows the agent to connect to SAP and extract log data.
- **SAP Application Security and Compliance Analyst**. Ensure that Microsoft Sentinel is looking for the right types of events and alerting you to events of interest to your organization. Provide input into who should be alerted in case a security breach is detected.
- **Other IT technicians**. Depending on where the agent is run, you might decide to involve other roles. If SAP is running in Azure, we recommend that you run the agent in a virtual machine. If the agent is run on-premises, or in another cloud or hosted environment, include the people who are in charge of those environments.

Each of these roles plays a vital part in the success of the solution. After you establish a working team and have jointly planned the deployment, your team is well-positioned to implement the solution which includes architecture, testing, and production deployment.
