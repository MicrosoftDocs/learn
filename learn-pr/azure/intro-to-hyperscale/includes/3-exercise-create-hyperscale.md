In this exercise, we're going to create a Hyperscale instance using the Azure Portal.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]

1. Sign in to the Azure portal using your Azure account.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com/)

2. Next, select **Create a resource**, **Databases**, and **Azure Database for PostgreSQL**. You can also use the **Search** functionality to find this category.

*image goes here*

3. Select **Create** in the **Hyperscale (Citus) server group** box.

*image goes here*

> The portal will display a PostgreSQL server configuration screen.

4. On the **Basics** tab, enter the following information:  

    |Parameter  |Value  |
    |---------|---------|
    |**Subscription**     |  Select **Free Trial** or **your existing subscription**       |
    |**Resource group**     | Select **Create new** and name your resource group **Hyperscale**       |
    |         **Server name** |  Enter **payment-server-demo**  |
    |**Location**| Use a region that's close to you, or leave as default |
    |**Compute + storage**     |  Leave as default, we'll configure this in the next step      |
    | **Admin username**| Citus will be selected by default |
    | **Password/Confirm Password**|  Choose a password |

    1. Note the password down for later use.
    1. Select **Configure server group** in the **Compute + storage** options.

*Image goes here*

5. Scroll to the bottom of the page and select the blue **Save** box.

6. Scroll to the bottom of the page and Select the blue **Review + create** button.

*image goes here*

7. Select the blue **Create** button at the bottom of the page.

Congratulations! Your Hyperscale server group is being deployed to Azure.
