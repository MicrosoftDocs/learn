In the following two units, you will review two business scenarios. The company descriptions, project goals, and constraints have already been laid out for you. You can work on this in a self-study fashion, but it may be interesting to brainstorm with others if possible.

## Process for developing solutions

Your goal, in these scenarios and likely in the real world, is to understand the problem the company needs to solve, and any requirements and constraints they have on those goals. This is often in the form of a *Problem Statement*, which is a formal set of paragraphs clearly defining the circumstances, present condition, and desired outcomes for a solution. At this point you want to avoid exploring how to solve the problem and focus on what you want to solve.

After you (and likely your team and stakeholders) agree on a problem statement, you should pull out as many requirements (*goals*) for the project as you can find, and then lay in any constraints the solution has. At this point, it's acceptable to have unrealistic constraints - later you can pull those back after showing a cost/benefit ratio on each requirement and constraint.  

In production, there are normally 6 phases to create  a solution, and developing the problem statement is just the beginning:

1. **Discovery**: The original statement of the problem from the customer
1. **Envisioning**: A "blue-sky" description of what success in the project would look like. Often phrased as *"I can..."* statements
1. **Architecture Design Session**: An initial layout of the technology options and choices for a preliminary solution
1. **Proof-Of-Concept** (POC): After the optimal solution technologies and processes are selected, a POC is set up with a small representative example of hat a solution might look like, as much as possible. If available, a currently-running solution in a parallel example can be used
1. **Implementation**: Implementing a phased-in rollout of the completed solution based on findings from the previous phases
1. **Handoff**: A post-mortem on the project with a discussion of future enhancements

Throughout this module, if you want to leverage various project templates you can find them [here](https://github.com/microsoft/sqlworkshops/tree/master/ProjectResources?azure-portal=true), and the latest icons can be found [here](https://www.microsoft.com/download/confirmation.aspx?id=41937&azure-portal=true). These assets can also be used in your production workloads.  

For these scenarios module, you'll spend some time determining the problem statement (**Discovery**), but the big focus will be on the **Architecture Design Session**. If you wish to develop a solution further after the module, you can use the assets in the module to do so.

## Scenario details

Your customer is a provider for services and content delivery across the globe. They've requested your assistance in architecting a system that can handle thousands of writes per second to what is essentially an operational data mart. They also need to be able to perform real-time analytics on the data, to determine trends and identify anomalies, which they are currently doing with CLR applications. They are not looking for a data warehouse and utilize large portions of the SQL surface area, but they need to be able to scale where their users live.  

Additionally, they are trying to determine which authentication methods they should use in their hybrid environment. While the main solution and application will live in Azure, they also need to accommodate the following:

- An application on a non-Azure machine
- A legacy application that will not allow the change the driver or connection string on a non-Azure machine.
- Multiple users that run reports from SQL admin tools (SSMS, ADS, PowerShell) on non-Azure machines.

Wherever possible, they want to eliminate hard coding passwords/secrets in the connection strings and app config files, and they want to eliminate using passwords in SQL tools or find a way to enhance that authentication.

### Scenario guidance

- Start with the Azure SQL deployment option that is most compatible with their current solution and available today.
- How will they scale over multiple regions with multiple queries happening at the same time, while isolating read workloads from write workloads?
- How can they access data across the various deployments?
- Which authentication methods would you recommend for the interaction paths described in the scenario?  

### Tasks

1. After reviewing the scenario and the guidance provided, pull out as many requirements for the project as you can find.
1. List out the possible technologies and processes that could potentially be used in a solution. Feel free to adapt the scenario to have more information where you want clarity, you can make assumptions in this case.
    Hint: For the security challenges, you might consider leveraging the [Azure SQL Security Best Practices Playbook](https://docs.microsoft.com/azure/sql-database/sql-database-security-best-practice?azure-portal=true).  
1. Using a decision matrix or some other decision process, select technologies and processes that will make up your preliminary solution.
1. Take some notes that present your project goals and constraints, as well as the recommended solution design.

After you have a preliminary solution in mind, the next step is often to present it to the larger team (or customer, leadership, etc. depending on the scenario). You'll need to assemble and present your solution in a way that shares the project goals and constraints, as well as how your solution addresses those items.  

When you're ready, answer the questions below to evaluate how your solution compares to a sample solution. There can be multiple right answers, so even if your solution isn't listed, it could be viable.
