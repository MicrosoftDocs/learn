You have been hired as a Senior Data Engineer to help automate day to day operations of database administration.  This automation is to help ensure that the databases for AdventureWorks continue to operate at peak performance as well as provide methods for alerting based on certain criteria.  

## Create an alert when a CPU exceeds an average of 80 percent.

1. When the VM lab environment opens use the password on the **Resources** tab for the **Student** account to sign in to Windows.

1. Select the Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/).

1. The username and password information to sign into the Azure Portal are in the  **Resources** tab above these instructions. If you select the **Username** the environment will type the text for you.

1. Repeat this for the **Password** field.

1. In the search bar at the top of the Azure Portal, type **SQL**, and select **SQL databases**. Select the database name.

    :::image type="content" source="../media/dp-3300-module-66-lab-11.png" alt-text="Screenshot of selecting a SQL database.":::

1. On the main blade for the sample-db-with-tde database, navigate down to the monitoring section.

1. Select **Alerts**.

    :::image type="content" source="../media/dp-3300-module-66-lab-12.png" alt-text="Screenshot of selecting Alerts on the SQL database Overview page.":::

1. Select **New alert rule**.

    :::image type="content" source="../media/dp-3300-module-66-lab-13.png" alt-text="Screenshot of selecting New alert rule.":::

1. You will notice that the resource is already populated for you with the database you created. Under the **Condition** section, select the **Select condition** link.

    :::image type="content" source="../media/dp-3300-module-66-lab-14.png" alt-text="Screenshot of selecting the Select condition link.":::

1. In the Configure signal logic slide out, select **CPU percentage**.

    :::image type="content" source="../media/dp-3300-module-66-lab-15.png" alt-text="Screenshot of selecting CPU percentage.":::

1. In **Threshold value** enter a value of **80**. Select **Done**.

    :::image type="content" source="../media/dp-3300-module-66-lab-16.png" alt-text="Screenshot of entering 80 and selecting Done.":::

1. Under Action Groups (optional) section, select the **Select action group** link.

    :::image type="content" source="../media/dp-3300-module-66-lab-17.png" alt-text="Screenshot of selecting the Select action group link.":::

1. In the fly out for Action Group, select **Create action group**.

    :::image type="content" source="../media/dp-3300-module-66-lab-18.png" alt-text="Screenshot of selecting the Create action group.":::

    On the Action Group screen, type **emailgroup** in the **Action group name** field.

    :::image type="content" source="../media/dp-3300-module-66-lab-19.png" alt-text="Screenshot of entering emailgroup and selecting Next: Notifications.":::

1. Select **Next: Notifications**.

    :::image type="content" source="../media/dp-3300-module-66-lab-20.png" alt-text="Screenshot of the Create action group page with information added.":::

    Enter the following information:

    - Notifaction type: **Email/SMS message/Push/Voice**
    - Name: **DemoLab**
    - Email: You can enter a test email, or use the Azure Username

1. Select **OK** in the Email/SMS message/Push/Voice flyout.

1. Select **Review + create**, then select **Create**.

    :::image type="content" source="../media/dp-3300-module-66-lab-21.png" alt-text="Screenshot of the Create alert rule page selecting the Create alert rule.":::

1. On the Create alert rule screen, add an **Alert rule name** of **DemoAlert**, and then select **Create alert rule**.
