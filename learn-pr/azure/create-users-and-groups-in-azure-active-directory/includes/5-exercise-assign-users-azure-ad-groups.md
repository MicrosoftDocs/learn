
In this exercise, you'll create a Azure Active Directory (Azure AD) group to manage the developer team's access. You'll also add a rule on the group to manage the membership automatically.

## Add a new group

1. Sign in to the [Azure portal](<https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true>)
1. Select **Azure Active Directory  > Groups  >  New Groups**.  
1. Enter the following information:
    
   - **Group type**: _Security_
   - **Group name**: _Developer group_
   - **Group description**: Developer team
1. Select **Create**. 
1. The new group now appears in the list of Groups.

You've created a new group.

## Use direct assignment to add a user to this group

You'll now assign members to the Developers group.

1. Select the **Developers group**.
1. Select **Members > Add members**.

   ![Screenshot that shows Add member button](../media/5-add-group-member.png)
1. Search for and select Chris Green.
1. Click **Select**.
1. You'll see this user in the member list for our Developers group.

You have added a new member to a group.

## Modify the group to use dynamic assignment

You can change the group to use dynamic assignment. Membership will then depend on whether a user meets the rules you set on the group.

1. In the Developers group, select **Properties**. 
1. Change **Membership type** to **Dynamic User**.
1. Select **Yes** at the prompt to provide this new type of membership to existing members.  
1. Select **Add dynamic query**. 
1. In the **Add users where** dropdown, you'll see all of the rules you can apply. In this case, to keep things simple set the rule to **country**, and then to **Match** the  **United States**.  This action means that membership of this group depends on whether the user is in the United States.

   ![Screenshot that shows how to assign a dynamic membership rule](../media/5-dynamic-member.png)
1. Select **Add query** and then **Save**.

You've now modified a group to use dynamic assignment.
