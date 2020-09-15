In the following two units, you'll review two business scenarios. The company descriptions, project goals, and constraints have already been laid out for you. You can work on this yourself, but it might be interesting to brainstorm with others if possible.

## Process for developing solutions

Your goal, in these scenarios and likely in the real world, is to understand:

- The problem that the company needs to solve.
- Any requirements and constraints that go along with a solution. 

This goal is often in the form of a *problem statement*. It's a formal set of paragraphs that clearly define the circumstances, present condition, and desired outcomes for a solution. At this point, you want to avoid exploring how to solve the problem and focus on what you want to solve.

After you (and likely your team and stakeholders) agree on a problem statement, you should pull out as many requirements (*goals*) for the project as you can find. Then lay in any constraints that the solution has. 

At this point, it's acceptable to have unrealistic constraints. Later, you can pull those back after showing a cost/benefit ratio on each requirement and constraint.  

In production, there are normally six phases to create a solution. Developing the problem statement is just the beginning.

1. **Discovery**: The original statement of the problem from the customer.
1. **Envisioning**: A "blue sky" description of what success in the project would look like. It's often phrased as *"I can..."* statements.
1. **Architecture design session**: An initial layout of the technology options and choices for a preliminary solution.
1. **Proof of concept** (POC): After the optimal technologies and processes are selected for the solution, a POC is set up with a small representative example of what a solution might look like. If a currently running solution in a parallel example is available, you can use that.
1. **Implementation**: Implementing a phased-in rollout of the completed solution based on findings from the previous phases.
1. **Handoff**: A postmortem on the project with a discussion of future enhancements.

Throughout this module, you can take advantage of [project templates](https://github.com/microsoft/sqlworkshops/tree/master/ProjectResources?azure-portal=true) and [the latest icons](https://www.microsoft.com/download/confirmation.aspx?id=41937&azure-portal=true). You can also use these assets in your production workloads.  

For the scenarios in this module, you'll spend some time determining the problem statement (*discovery*). But the big focus will be on the *architecture design session*. If you want to develop a solution further after the module, you can use the assets in the module to do so.

## Scenario details

Your customer is a provider for services and content delivery across the globe. It has requested your assistance in building a system that can handle thousands of writes per second to what is essentially an operational data mart. 

The customer also needs the ability to perform real-time analytics on the data, to determine trends and identify anomalies. It's currently doing that with common language runtime (CLR) applications. The customer isn't looking for a data warehouse and to utilize large portions of the SQL surface area, but it needs to be able to scale where users live.  

The customer is also trying to determine which authentication methods to use in its hybrid environment. Although the main solution and application will live in Azure, the customer also needs to accommodate the following:

- An application on a non-Azure machine that is domain-joined.
- An older application that won't allow the change of the driver or connection string on a non-Azure machine.
- Multiple users that run reports from SQL admin tools (SQL Server Management Studio, Azure Data Studio, PowerShell) on non-Azure machines that are not domain-joined.

Wherever possible, the customer wants to eliminate hard-coding passwords or secrets in the connection strings and app configuration files. And it wants to eliminate using passwords in SQL tools or find a way to enhance that authentication.

### Scenario guidance

- Start with the Azure SQL deployment option that's most compatible with the current solution and available now.
- How will the customer scale over multiple regions with multiple queries happening at the same time, while isolating read workloads from write workloads?
- How can the customer access data across the various deployments?
- Which authentication methods would you recommend for the interaction paths described in the scenario?  

### Tasks

1. After you review the scenario and the provided guidance, pull out as many requirements for the project as you can find.
1. List the possible technologies and processes that might potentially be used in a solution. Feel free to adapt the scenario to have more information where you want clarity. You can make assumptions in this case.
    
    > [!TIP]
    > For the security challenges, you might consider using the [playbook for Azure SQL security best practices](https://docs.microsoft.com/azure/sql-database/sql-database-security-best-practice?azure-portal=true).  
1. By using a decision matrix or some other decision process, select technologies and processes that will make up your preliminary solution.
1. Take some notes that present your project goals and constraints, as well as the recommended solution design.

After you have a preliminary solution in mind, the next step is often to present it to the larger team (or customer or leadership, depending on the scenario). You'll need to assemble and present your solution in a way that shares the project goals and constraints, as well as how your solution addresses those items.  

When you're ready, answer the following questions to evaluate how your solution compares to a sample solution. There can be multiple right answers, so even if your solution isn't listed, it might be viable.
