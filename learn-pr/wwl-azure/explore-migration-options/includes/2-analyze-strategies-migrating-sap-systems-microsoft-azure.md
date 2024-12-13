The majority of customers considering deploying SAP workloads to Azure have an existing on-premises SAP implementation. The number of greenfield deployments is relatively small.

Typically, enterprises have SAP systems for business functions like enterprise resource planning (ERP), global trade, business intelligence (BI), and others. Within those systems are environments like sandbox, development, test, and production.

:::image border="false" type="content" source="../media/sap-example-environments-c15eeefd.png" alt-text="Diagram showing example environments.":::

Each horizontal row in the figure above is an environment. Each column is an SAP system for a business function (for example, ERP and BI).

The rows or layers at the bottom are lower-risk environments and are less critical. Those toward the top are higher risk and more critical. As you move up the stack, there’s more risk in the migration process. So, production is the most critical environment, and the environment for user acceptance testing (Test)—which is also used for business continuity—is the second-most critical.

The systems at the bottom are smaller, in that they have fewer computing resources, lower availability and size requirements, and less throughput. However, they have the same amount of storage as the production database.

## Horizontal strategy

With a horizontal strategy, you start from the bottom of the stack because it’s a safe way to experiment and gain experience with Azure. It’s also a good strategy to use while you redefine your operational, deployment, and approval processes. These processes will change as you move to Azure. Here’s how the strategy works:

- To limit risk, start with low-impact sandbox or training systems. If something goes wrong, there’s very little danger of affecting many users or mission-critical business functions.
- Then, as you gain experience with running, hosting, and administering SAP systems in Azure, apply what you’ve learned to the next layer of systems up the stack.
- For each layer, estimate costs, potential money saved, performance, and optimization potential—and adjust if needed.

## Vertical strategy

To gain experience with production systems on Azure, you can use a vertical strategy with low-risk systems in parallel to the horizontal strategy. This also offers a chance to adjust internal processes for Azure and train team members. It’s a great way to spot any issues in production early on. Here’s how the strategy works:

- **Look at the impact on cost, customers, service level agreements (SLAs), and legal requirements**. First, move systems—from sandbox up to production—that have the lowest risk: the governance, risk, and compliance system and then the object event repository (OER) system. Then move the higher-risk ones, like BI and ERP.
- **When you have a new SAP system, start in Azure by default rather than putting it on-premises and moving it later**. In the diagram, OER is an example of this. OER is a new, low-risk system. After moving some of our other systems into Azure with the horizontal strategy, you can deploy the entire OER vertical stack to Azure, end-to-end—from sandbox all the way up to production.
- **Don’t move your most critical system first**. The last system you move is the highest risk, most mission-critical system—the ERP production system. You need the most performance-intensive virtual machine SKUs and the largest storage.
- **Move standalone systems first**. Some systems are closely joined with other systems—for example, our ERP and GTS systems. There’s a lot of synchronous, real-time traffic between the two. If you move ERP to Azure but keep GTS on-premises, it will affect performance because of network latency—so move them together.
- **If you have several SAP systems, look for upstream and downstream dependencies** from one SAP system to the other, or from SAP to apps outside the SAP ecosystem. Examine traffic patterns and areas with high sensitivity to latency.
- **If you have tightly connected systems, do a performance analysis** to see what effect moving them will have. If there isn't much impact, moved them separately to Azure (for example Business Warehouse independent of ERP). Otherwise, create migration groups and moved them together.
- **In some cases, consider waiting**. Sometimes you don't want to move certain systems to Azure right away. This could be related to sizing requirements when the processing requirements were so high that the virtual machines weren’t yet big enough. Run tests to ensure that moving these systems isn't going to affect SLAs with customers.
