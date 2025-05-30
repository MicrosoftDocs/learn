**Exercise environment needs** - this lab assumes you have a basic Microsoft Entra tenant with at least User Administrator rights to complete it.  You can get a free trial subscription for at [Try Azure for Free](https://azure.microsoft.com/free).

## Create a Microsoft 365 group in Microsoft Entra ID

1. Browse to the Microsoft Entra admin center - Identity page in the [Microsoft Entra admin center](https://entra.microsoft.com).
2. In the left navigation, under select **Groups**.
3. In the Groups blade, on the menu, select **New group**.
4. Create a group using the following information:
    
   | **Setting**     | **Value**                                                |
   | --------------- | -------------------------------------------------------- |
   | Group type      | Microsoft 365                                            |
   | Group name      | Northwest Sales                                          |
   | Membership type | Assigned                                                 |
   | Owners          | Assign your own administrator account as the group owner |
   | Members         | Assign a member of this group                            |
    
   :::image type="content" source="../media/create-office-365-group.png" alt-text="Screenshot of the New Group page with Group type, Group name, Owners, and Members highlighted.":::
    
5.  When complete, verify the group named **Northwest sales** is shown in the **All groups** list.
6.  You have to refresh the **All groups** a couple of times for the new group to show up.
