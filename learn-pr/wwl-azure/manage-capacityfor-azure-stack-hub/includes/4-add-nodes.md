You can increase the overall capacity of an existing scale unit by adding other physical computer. The physical computer is also referred to as a scale unit node. Each new scale unit node you add must be homogeneous in CPU type, memory, and disk number and size to the nodes that are already present in the scale unit. Azure Stack Hub doesn't support removing scale unit nodes for scaling down due to architectural limitations. It is only possible to expand capacity by the addition of nodes.

To add a scale unit node, sign into in Azure Stack Hub and run tooling from your hardware equipment manufacturer (OEM). The OEM tooling runs on the hardware lifecycle host (HLH) to make sure the new physical computer matches the same firmware level as existing nodes.

The following flow diagram shows the general process to add a scale unit node:

:::image type="content" source="../media/add-a-scale-unit-node-8c6f9166.png" alt-text="Image showing the process to add a scale unit node.":::


The operation to add a new node can take several hours or days to complete. There is no impact to any running workloads on the system while an additional scale unit node is added.

Don't attempt any of the following operations while an add scale unit node operation is already in progress:

 -  Update Azure Stack Hub.
 -  Rotate certificates.
 -  Stop Azure Stack Hub.
 -  Repair scale unit node.
 -  Add another node (the previous add-node action failure is also considered in progress).

## Add scale unit nodes

The following steps are a high-level overview of how to add a node. Don't follow these steps without first referring to your OEM-provided capacity expansion documentation.

1.  Place the new physical server in the rack and cable it appropriately.
2.  Enable physical switch ports and adjust access control lists (ACLs) if applicable.
3.  Configure the correct IP address in the baseboard management controller (BMC) and apply all BIOS settings per your OEM-provided documentation.
4.  Apply the current firmware baseline to all components by using the tools that are provided by the hardware manufacturer that run on the HLH.
5.  Run the add node operation in the Azure Stack Hub administrator portal.
6.  Validate that the add node operation succeeds. To do so, check the Status of the Scale Unit.

## Add the node

You can use the administrator portal or PowerShell to add new nodes. The add node operation first adds the new scale unit node as available compute capacity and then automatically extends the storage capacity. The capacity expands automatically because Azure Stack Hub is a hyperconverged system where *compute* and *storage* scale together.

1.  Sign in to the Azure Stack Hub administrator portal as an Azure Stack Hub operator.
2.  Navigate to **+ Create a resource &gt; Capacity &gt; Scale Unit Node**.
    
    :::image type="content" source="../media/add-scale-unit-node-60d5014e.png" alt-text="Image showing the scale unit node.":::
    

3.  On the **Add node** pane, select the *Region*, and then select the *Scale unit* that you want to add the node to. Also specify the *BMC IP ADDRESS* for the scale unit node you're adding. You can only add one node at a time.
    
    :::image type="content" source="../media/scale-node-baseboard-management-controller-ip-address-b01d5e5b.png" alt-text="Image showing adding one node at a time.":::
    

## Add a node:

PowerShell

```
## Add a single Node
  Add-AzsScaleUnitNode -BMCIPv4Address "<BMCIP_address_of_new_node>" -computername "<name_of_new_node>" -ScaleUnit "<name_of_scale_unit_cluster>"

```
