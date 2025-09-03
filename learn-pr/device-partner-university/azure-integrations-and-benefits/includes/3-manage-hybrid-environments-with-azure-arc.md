If your organization runs Windows Server in its own data center or across other cloud platforms, [Azure Arc](azure/azure-arc/overview) provides a unified way to manage those servers through the Azure portal. This centralized approach allows IT teams to view, configure, and secure all their servers—regardless of location—from a single interface, streamlining operations and improving consistency.

Azure Arc provides a unified management layer for Windows Server, whether your servers are on-premises, in other clouds, or at the edge. By connecting Windows Server to Azure Arc, IT teams can centralize management, enforce policies, and enable advanced Azure services—all from the Azure portal.

:::image type="content" source="../media/azure-company.png" alt-text="A photograph of a developer and CEO in office hallway, walking meeting, positive exchange.":::

## Using Azure features on hybrid servers

Azure Arc enables Windows Server to use Azure services even if the servers aren't running in Azure. This includes services like machine learning, databases, and monitoring.

If your organization wants to leverage Azure Machine Learning for on-premises data, connecting Windows Server to Azure Arc allows you to run these Azure services without migrating the workloads to the cloud.

 
### Try it yourself: Connect a Windows Server to Azure Arc

To onboard a Windows Server to Azure Arc:

1. Open the Azure portal.
2. Navigate to Azure Arc > Servers.
3. Click “Add” and select “Generate script.”
4. Run the script on your Windows Server.
5. Verify that the server appears in the Azure portal.

This process enables centralized management and policy enforcement. 

## Flexibility and scalability

Connecting Windows Server to Azure Arc gives organizations the ability to adapt to changing business needs. IT teams can:

- Quickly scale up resources
- Automate repetitive tasks
- Manage servers without being tied to a single environment

## Consistent development across environments

Applications built for Azure can also run on Windows Server connected via Azure Arc. This ensures consistency in deployment and simplifies development. Developers can create an application in Azure. By connecting Windows Servers through Azure Arc, the same application can run on-premises without changes, streamlining hybrid deployments.

Beyond management and security, Azure Arc also supports development workflows by enabling consistent deployment across platforms. Now, let’s look at how Azure Arc enhances visibility and control at scale.