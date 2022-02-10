Azure Stack Hub plans are groupings of one or more services and their quotas. As a provider, you can create plans to offer to your users. In turn your users subscribe to your offers to use the plans, services, and quotas they include. This unit shows you how to create a plan that includes the compute, network, and storage resource providers. This plan gives subscribers the ability to provision virtual machines.

## Create a plan

1.  Sign in to the Azure Stack Hub administrator portal `https://adminportal.local.azurestack.external`.
2.  To create a plan and offer that users can subscribe to, select **+ Create a resource, then Offers + Plans**, then **Plan**.
    
    :::image type="content" source="../media/create-plan-image-1-5e4e1868.png" alt-text="Screenshot that shows how to select a plan in Azure Stack Hub administrator portal.":::
    

4.  A tabbed user interface appears that enables you to specify the plan name, add services, and define quotas for each of the selected service.
5.  Create a new **Resource Group**, or select an existing one, as a container for the plan.
    
    :::image type="content" source="../media/create-plan-image-3-d68bfe81.png" alt-text="Screenshot that shows how to specify the resource group for new plan in Azure Stack Hub.":::
    

5.  Select the **Services** tab, or click the **Next : Services &gt;** button, and then select the checkbox for **Microsoft.Compute**, **Microsoft.Network**, and **Microsoft.Storage**.
    
    :::image type="content" source="../media/create-plan-image-4-2974492d.png" alt-text="Screenshot that shows how to select services for new plan in Azure Stack Hub.":::
    

6.  Select the **Quotas** tab, or click the **Next : Quotas &gt;** button. Next to **Microsoft.Storage**, choose either the default quota from the dropdown box, or select **Create New** to create a customized quota.
    
    :::image type="content" source="../media/create-plan-image-5-97ce9951.png" alt-text="Screenshot that shows how to specify quotas for new plan in Azure Stack Hub.":::
    

7.  If you're creating a new quota, enter a **Name** for the quota, and then specify the quota values. Select **OK** to create the quota.
    
    :::image type="content" source="../media/create-plan-image-6-c9c7f2e9.png" alt-text="Screenshot that shows how to create new quota for new plan in Azure Stack Hub.":::
    

8.  Repeat steps 6 and 7 to create and assign quotas for **Microsoft.Network** and **Microsoft.Compute**. When all three services have quotas assigned, they'll look like the next example.
    
    :::image type="content" source="../media/create-plan-image-7-3906bc8e.png" alt-text="Screenshot that shows how to complete quota assignments for new plan in Azure Stack Hub.":::
    

9.  Select **Review + create** to review the plan. Review all values and quotas to ensure they're correct. The interface enables you to expand the quotas in the chosen plans one at a time to view the details of each quota in a plan. You can also go back to make any necessary edits.
    
    :::image type="content" source="../media/create-plan-image-8-78ee39eb.png" alt-text="Screenshot that shows how to create the plan in Azure Stack Hub.":::
    

10. When you're ready, select **Create** to create the plan.
11. To see the new plan, on the left-hand side click **All services**, select **Plans**, and then search for the plan and select its name.
