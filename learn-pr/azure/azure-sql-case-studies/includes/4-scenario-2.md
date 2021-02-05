In the last unit, you analyzed a solution that had requirements involving global scale, isolating read and write workloads, and determining the most secure methods of authentication depending on client. These are common themes that occur in many scenarios.

Similar to the last unit, you'll review an additional business scenario focused on mission-critical applications. The company descriptions, project goals, and constraints have already been laid out for you, but you'll be responsible for coming up with a potential solution.

## Scenario details

You're hired to build a mission-critical cloud application that requires 99.995 percent availability because downtime might be life threatening. 911 dispatch, notifications about stolen credit cards, or corporate security reporting are examples of such applications. 

In this case, you'll focus on a 911 dispatch system. High performance is required, because any delay in response carries high risk and can be life-threatening. Given the sensitivity of the collected personal information, data sovereignty must be guaranteed. Your main mission is to ensure that the app is designed and deployed with the appropriate data redundancy and fault resilience to meet the availability and data sovereignty goals.

The 911 dispatch system coordinators are concerned about protecting sensitive data (like health history and personally identifiable information) while allowing database analysts (DBAs) to perform their jobs. In this scenario, DBAs must not be able to see sensitive data stored in specific columns, and all access to tables that contain sensitive data must be monitored. 

At the same time, DBAs need to be able to troubleshoot performance by using the Azure portal, SQL Server Management Studio, and Azure Data Studio. They also need the ability to create new contained database users who must be mapped to Azure AD principals.  

### Scenario guidance

- Start by selecting the Azure SQL deployment option, service tier, and configuration that create the highest availability for the 911 dispatch system.  
- Consider geo-redundancy.  
- Think about what role colocation plays in your solution.  
- Determine a security strategy for meeting the data sensitivity requirements.

### Tasks

1. After you review the scenario and the provided guidance, pull out as many requirements for the project as you can find.
1. List the possible technologies and processes that might potentially be used in a solution. Feel free to adapt the scenario to have more information where you want clarity. You can make assumptions in this case.
    
   > [!TIP]
   > For the security challenges, you might consider using the [playbook for Azure SQL security best practices](https://docs.microsoft.com/azure/sql-database/sql-database-security-best-practice?azure-portal=true).  
1. By using a decision matrix or some other decision process, select technologies and processes that will make up your preliminary solution.
1. Take some notes that present your project goals and constraints, as well as the recommended solution design.

After you have a preliminary solution in mind, the next step is often to present it to the larger team (or customer or leadership, depending on the scenario). You'll need to assemble and present your solution in a way that shares the project goals and constraints, as well as how your solution addresses those items.

When you're ready, answer the following questions to evaluate how your solution compares to a sample solution. There can be multiple right answers, so even if your solution isn't listed, it might be viable.
