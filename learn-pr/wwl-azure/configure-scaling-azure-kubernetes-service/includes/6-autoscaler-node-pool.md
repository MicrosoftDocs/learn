Use this Try-This exercise to gain some hands-on experience with Azure Kubernetes Service.

You can scale the number of nodes in your cluster to increase the total number of cores and memory available for your container applications.

If the resource needs of your applications change, your cluster performance may be impacted due to low capacity on CPU, memory, PID space, or disk sizes. To address these changes, you can manually scale your AKS cluster to run a different number of nodes. When you scale down, nodes are carefully cordoned and drained to minimize disruption to running applications. When you scale up, AKS waits until nodes are marked **Ready** by the Kubernetes cluster before pods are scheduled on them.

> [!NOTE]
> To complete this exercise you'll need an [Azure Subscripton](https://azure.microsoft.com/free/).

1.  From **Overview**, select **Node pools**. :::image type="content" source="../media/node-pools-adjust-scale-541110db.png" alt-text="Displays a screenshot of the node pools.":::
    

2.  Select the node pool.
    
    :::image type="content" source="../media/select-node-pool-a501c4e5.png" alt-text="Displays a screenshot of the existing node pool.":::
    

3.  Select **Scale node pool**.
    
    :::image type="content" source="../media/scale-node-pool-ed62dd62.png" alt-text="Displays a screenshot of the procedure for scaling a node pool.":::
    

4.  Select **Autoscale - Recommended** and set the minimum and maximum node count.
    
    :::image type="content" source="../media/set-node-count-save-ac104d86.png" alt-text="Displays a screenshot of the Autoscale and node cound configuration.":::
    

5.  Select **Apply** to enable node scaling.
