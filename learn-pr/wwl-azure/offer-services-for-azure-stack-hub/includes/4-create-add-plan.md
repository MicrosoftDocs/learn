You create add-on plans to modify a base plan when you want to offer additional services or extend *computer*, *storage*, or *network* quotas beyond the base plan initial offer. Add-on plans modify the base plan and are optional extensions that users can choose to enable in their subscription.

There are times when combining everything in a single plan is optimal. Other times you might want to have a base plan and then offer the other services by using add-on plans. For instance, you could decide to offer IaaS services as part of a base plan with all PaaS services treated as add-on plans.

Another reason to use add-on plans is to help monitor resource usage. To do so, you could start with a base plan that includes relatively small quotas (depending on the services required). Then, as users reach capacity, they would be alerted that they've consumed the allocation of resources based on their assigned plan. From there, the users can select an add-on plan that provides the other resources.

Add-on plans are created the same way as a base plan. The difference between the two is determined when the plan is added to an offer. It's designated as either a base plan or add-on plan. When you add an add-on plan to an existing offer, the other resources can take up to an hour to appear in the subscription.

## Create an add-on plan

1.  Sign in to the Azure Stack Hub administrator portal as a cloud administrator.
2.  Follow the same steps used in the previous unit to create a new plan offering services that weren't previously offered.
3.  In the administrator portal, select **Offers** and then select the offer to be updated with an add-on plan.
    
    :::image type="content" source="../media/create-add-on-plans-1-1f064d06.png" alt-text="Image showing offer being updated with an add-on plan." lightbox="../media/create-add-on-plans-1-1f064d06.png":::
    

4.  At the bottom of the offer properties, select **Add-on plans**. Select **Add**.
    
    :::image type="content" source="../media/create-add-on-plans-2-cb5e6951.png" alt-text="Image showing selecting Add-on plans." lightbox="../media/create-add-on-plans-2-cb5e6951.png":::
    

5.  Select the plan to add. In this example, the plan is called **plan9**. After selecting the plan, click **Select** to add the plan to the offer. You should receive a notification that the plan was added to the offer successfully.
    
    :::image type="content" source="../media/create-add-on-plans-3-334ca3ee.png" alt-text="Image showing plan was added to the offer.":::
    

6.  Review the list of add-on plans included with the offer to verify that the new add-on plan is listed.
    
    :::image type="content" source="../media/create-add-on-plans-4-13988e51.png" alt-text="Image showing the new add-on plan." lightbox="../media/create-add-on-plans-4-13988e51.png":::
    
