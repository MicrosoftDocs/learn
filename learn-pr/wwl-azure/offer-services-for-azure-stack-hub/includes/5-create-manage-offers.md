Offers are groups of one or more plans that providers present to users, which those users can buy or subscribe to. This offer gives subscribers the ability to set up virtual machines (VMs).

## Create an offer

1.  Sign in to the Azure Stack Hub administrator portal `https://adminportal.local.azurestack.external` and select **+ Create a resource**, then **Offers + Plans**, and then **Offer**.
    
    :::image type="content" source="../media/create-an-offer-image-1-31b875f7.png" alt-text="Image showing how to select and Offer.":::
    

2.  A tabbed user interface appears that enables you to define the offer name. You can also add existing or create new base plans and add-on plans. Most importantly, you can review the details of the offer you create before you decide to create it.

In the **Basics** tab, enter a **Display Name** and a **Resource Name**, and then under **Resource Group**, select **Create new** or **Use existing**. The display name is the friendly name for the offer.

3.  Select the **Base plans** tab or click the **Next : Base plans &gt;** button. Select the plan(s) you want to include in the offer.
    
    :::image type="content" source="../media/create-an-offer-image-3-eb531380.png" alt-text="Image showing Base plans.":::
    

4.  At this point you can create an add-on plan to modify the base plan, but this is optional.
5.  Select the **Review + create** tab. Review the offer summary to ensure that all values are correct. The interface enables you to expand the quotas in the chosen plans one at a time to view the details of each quota in a plan.
6.  Select **Creat**e to create the offer.
    
    :::image type="content" source="../media/create-an-offer-image-4-45c85401.png" alt-text="Image showing how to create the offer.":::
    

### Change the state of an offer

After creating the offer, you can change its state. Offers must be made **Public** for users to get the full view when they subscribe. Offers can be:

 -  **Public**: Visible to users.
 -  **Private**: Only visible to cloud administrators. This setting is useful while drafting the plan or offer, or if the cloud administrator wants to create each subscription for users.
 -  **Decommissioned**: Closed to new subscribers. The cloud administrator can decommission offers to prevent future subscriptions, but leave current subscribers unaffected.

There are two ways to change the state of an offer:

1.  In **All resources**, select the name of the offer. On the **Overview** screen for the offer, select **Change state**. Choose the state you want to.
    
    :::image type="content" source="../media/create-an-offer-image-5-3c89af35.png" alt-text="Image showing changing the state.":::
    

2.  Select **Offer settings**. Choose the state you want to use, then select **Save**.
    
    :::image type="content" source="../media/create-an-offer-image-6-a9798569.png" alt-text="Image showing Offer settings.":::
    
