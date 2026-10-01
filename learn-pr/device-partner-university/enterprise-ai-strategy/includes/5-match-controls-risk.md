Organizations should take a risk-based approach to agent governance. Rather than applying the same controls to every agent, they should evaluate each agent's:

- Capabilities
- Permissions
- Potential impact

Agents that access sensitive data, interact with critical systems, or perform consequential actions may require stronger governance controls than agents with more limited responsibilities.

## Exercise

Review the following agents and apply a risk-based governance approach by ranking them from highest risk to lowest risk, determining which would require the strongest governance controls.

**Agent A: Marketing Research Agent**

- Reviews approved websites
- Summarizes information
- Drafts blog posts and marketing content
- Can't make changes to business systems

**Agent B: Finance Reconciliation Agent**

- Accesses Enterprise Resource Planning (ERP) systems and purchasing data
- Compares invoices to purchasing records
- Identifies discrepancies for review
- Works with business-critical financial information

**Agent C: Security Operations Agent**

- Investigates security alerts
- Accesses device and security data
- Can initiate actions that affect devices, configurations, or security operations

**Think about:**

- What can the agent access?
- What actions can the agent take?
- What could happen if the agent behaves unexpectedly?
- Which governance area would require the most attention for each agent: identity, containment, or management? Why?

**Suggested answer**

**Highest risk**: Security Operations Agent (Agent C)
**Medium risk**: Finance Reconciliation Agent (Agent B)
**Lowest risk**: Marketing Research Agent (Agent A)

**Why?**

The **Security Operations Agent** ranks as the highest risk because it can both access sensitive security information and take actions that affect devices, configurations, or security operations. If the agent behaves unexpectedly, its actions could have a broad impact on the entire ecosystem by disrupting systems, affecting users, or creating new security risks. This agent would likely require the strongest **containment** controls because its actions can directly affect critical systems. It would also require strong **identity** and **management** controls to govern access and maintain oversight.

The **Finance Reconciliation Agent** also works with sensitive and business-critical information, but its role is primarily focused on analyzing and reconciling data rather than making changes to operational systems. This agent would likely require the strongest **identity** controls to ensure appropriate access to financial systems and data, along with **management** controls to support monitoring and auditing.

The **Marketing Research Agent** would generally be considered the lowest risk because it mainly gathers information and drafts content, with limited access to critical systems and a smaller potential impact if something goes wrong. No single governance area stands out as requiring significantly stronger controls. **Baseline identity, containment, and management** controls would typically be sufficient given the agent's limited access and impact.

> [!NOTE]
>
> When evaluating an agent, ask yourself:
>
>- What data does it need?
>- Which systems can it access?
>- What actions can it perform?
>- How independently can it perform those actions?
>- What could happen if it behaves unexpectedly?
>- What level of containment is appropriate?
>- What activity needs to be monitored or audited?
>
> These questions can help you assess risk and determine the appropriate governance controls for an agent.

Once an organization has determined which controls an agent requires, those controls must be applied and enforced wherever the agent operates. In the next unit, we’ll review where governance is enforced.
