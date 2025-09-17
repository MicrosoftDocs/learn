[Azure Local](/azure/azure-local/overview) is a platform that brings together compute, storage, and networking in one system. It’s designed for organizations that need to keep workloads on-premises but still want to use Azure services for management, monitoring, and security.

:::image type="content" border="true" source="../media/it-professional.png" alt-text="A photograph of an IT professional in a blue shirt seated indoors, smiling.":::

**Key features:**

- Run workloads on-premises, connect to Azure when you want  
- Use Azure Arc for hybrid management  
- Get regular updates and security improvements  
- Access extended security updates for Windows Server  

> [!TIP]
> If you need to keep data local for compliance, Azure Local supports [disconnected operations](/azure/azure-local/manage/disconnected-operations-overview) (preview).

## Use case snapshot

A hospital uses Azure Local to run patient record systems locally for compliance. But it connects to Azure for backup, monitoring, and patch management—keeping data secure and operations smooth. The hybrid approach ensures high availability while meeting strict regulatory requirements, giving IT teams confidence in both performance and compliance.


## Deployment options

Azure Local is flexible. You can set it up in a way that fits your organization’s needs and budget.

### Validated nodes

- Based on reference architecture  
- Flexible hardware selection  
- Ensures reliability and best practices  

**When to choose:** Validated nodes are a strong fit for IT teams with in-house expertise who want more control over hardware selection and configuration, while still following Microsoft’s reference architecture for consistency.

### Integrated systems

- Pre-installed software and firmware  
- Fastest time-to-value  
- Ideal for turnkey deployments  

**When to choose:** Integrated systems are the right choice if your team needs to deploy quickly or doesn’t have the bandwidth for custom configuration. The built-in drivers and firmware speed up rollout and reduce errors.

### Existing hardware (select cases)

- Reuse compatible hardware  
- Cost-effective and sustainable  
- Requires OEM validation  

**When to choose:** This option is ideal for organizations with tight budgets or sustainability goals. Reusing hardware reduces capital costs and aligns with eco-friendly IT practices.


Check the Azure Local Catalog for hardware that’s ready to go with the latest updates. Once Azure Local is deployed, the next step is visibility—monitoring and managing clusters across your environment.

**Decision guide**

- Want speed? Go with integrated systems.  
- Need flexibility? Validated nodes are a good fit.  
- Tight budget? Check if your existing hardware qualifies.  

With deployment complete, the focus shifts to visibility and ongoing health—monitoring clusters across environments.

## Monitoring multiple clusters

Once Azure Local is deployed, you’ll want to keep an eye on performance, health, and usage. Azure Monitor Insights makes this easy.

### Capabilities

- View resources in a single portal  
- Monitor over 400 clusters across subscriptions  
- Use built-in dashboards from the Workbook Gallery  
- No third-party tools required  

### Customization

- Edit visualizations without engineering support  
- Choose personal or shared workbooks  
- Tailor monitoring to your environment  

> [!TIP]
> Customize your dashboards to show what matters most to you and your team.

A logistics company monitors clusters across multiple warehouses. Azure Monitor helps them detect issues early and keep operations running smoothly. Monitoring keeps infrastructure healthy, but workloads need attention too. This is where Azure Arc extends VM management into the Azure Portal, providing a consistent hybrid experience.

Now that you understand what Azure Local is and how it fits into hybrid infrastructure, let’s look at how you can manage it using tools you already know. Azure Local was built with IT pros in mind—so instead of learning a whole new system, you can use familiar tools like Windows Admin Center, PowerShell, and the Azure Portal to deploy, monitor, and operate your environment with confidence. 

Now that you understand what Azure Local is and how it fits into hybrid infrastructure, let’s look at how you can manage it using tools you already know.