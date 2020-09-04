In the last unit, you analyzed a solution, which had requirements involving global scale, isolating read and write workloads, and determining the most secure methods of authentication depending on client. These are common themes that occur in many scenarios.

Similar to the last unit, you will review an additional business scenario focused on mission critical applications. The company descriptions, project goals, and constraints have already been laid out for you, but you will be responsible for coming up with a potential solution.

## Scenario details

You are hired to architect a mission critical cloud application that requires 99.995% availability because downtime might be life threatening. 911 dispatch, stolen credit card notifications, or corporate security reporting are examples of such applications, but in this case, you will focus on a 911 dispatch system. High performance is required as any delay in response carries high risk, sometimes life-threatening. Given the sensitivity of the collected personal information, data sovereignty must be guaranteed. Your main mission is to ensure that the app is designed and deployed with the appropriate data redundancy and fault resilience to meet the availability and data sovereignty goals.

Additionally, the 911 dispatch system coordinators are concerned about protecting sensitive data (like health history and personally identifiable information) while allowing DBAs to perform their jobs. In this scenario, DBAs must not be able to see sensitive data stored in specific columns and all access to tables containing sensitive data must be monitored. At the same time, DBAs need to be able to troubleshoot performance using the Azure portal and SSMS/ADS and to create new contained database users who must be mapped to Azure AD principals.  

### Scenario guidance

- Start by selecting the Azure SQL deployment option, service tier, and configuration that creates the highest availability for the 911 dispatch system.  
- Consider geo-redundancy.  
- What role does colocation play in your solution?  
- Determine a security strategy for meeting the data sensitivity requirements.

### Tasks

1. After reviewing the scenario and the guidance provided, pull out as many requirements for the project as you can find.
1. List out the possible technologies and processes that could potentially be used in a solution. Feel free to adapt the scenario to have more information where you want clarity, you can make assumptions in this case.
    Hint: For the security challenges, you might consider leveraging the Azure SQL Security Best Practices Playbook that's available in the [documentation](https://docs.microsoft.com/azure/sql-database/sql-database-security-best-practice?azure-portal=true).  
1. Using a decision matrix or some other decision process, select technologies and processes that will make up your preliminary solution.
1. Take some notes that present your project goals and constraints, as well as the recommended solution design.

After you have a preliminary solution in mind, the next step is often to present it to the larger team (or customer, leadership, etc. depending on the scenario). You'll need to assemble and present your solution in a way that shares the project goals and constraints, as well as how your solution addresses those items.  

When you're ready, answer the questions below to evaluate how your solution compares to a sample solution. There can be multiple right answers, so even if your solution isn't listed, it could be viable.
