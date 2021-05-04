You have been hired as a Senior Data Engineer to help automate day to day operations of database administration.  This automation is to help ensure that the databases for AdventureWorks continue to operate at peak performance as well as provide methods for alerting based on certain criteria.  

## Connect to the lab environment

1. When the VM lab environment opens, use the password on the **Resources** tab above for the **Student** account to sign in to Windows.

1. Select the Microsoft Edge browser from the toolbar and navigate to [https://portal.azure.com](https://portal.azure.com/). This should be the home page of the browser.

1. The username and password information to sign into the Azure portal are in the  **Resources** tab above these instructions. If you select the **Username** it will be filled in for you.

1. Select **Next**.

1. Select the **Password** text in the **Resources** tab to have that filled in for you, then select **Sign in**.

1. Select **Yes**.

1. On the **Welcome to Azure** popup, select **Maybe later**.

## Create an alert when a CPU exceeds an average of 80 percent.

1. In the search bar at the top of the Azure portal, type **SQL**, and select **SQL databases**. Select the **sample-db-with-tde**  database name.

    :::image type="content" source="../media/dp-3300-module-66-lab-11.png" alt-text="Screenshot of selecting a SQL database.":::

1. On the main blade for the sample-db-with-tde database, navigate down to the monitoring section.

1. Select **Alerts**.

    :::image type="content" source="../media/dp-3300-module-66-lab-12.png" alt-text="Screenshot of selecting Alerts on the SQL database Overview page.":::

1. Select **New alert rule**.

    :::image type="content" source="../media/dp-3300-module-66-lab-13.png" alt-text="Screenshot of selecting New alert rule.":::

1. Under the **Condition** section, select the **Select condition** link.

    :::image type="content" source="../media/dp-3300-module-66-lab-14.png" alt-text="Screenshot of selecting the Select condition link.":::

1. In the Configure signal logic slide out, select **CPU percentage**.

    :::image type="content" source="../media/dp-3300-module-66-lab-15.png" alt-text="Screenshot of selecting CPU percentage.":::

1. Check that the Operator is **Greater than**, the Aggregation type is **Average**. Then in **Threshold value** enter a value of **80**. Select **Done**.

    :::image type="content" source="../media/dp-3300-module-66-lab-16.png" alt-text="Screenshot of entering 80 and selecting Done.":::

1. Under **Actions** section, select the **Select action group** link.

    :::image type="content" source="../media/dp-3300-module-66-lab-17.png" alt-text="Screenshot of selecting the Select action group link.":::

1. In the fly out for Action Group, select **Create action group**.

    :::image type="content" source="../media/dp-3300-module-66-lab-18.png" alt-text="Screenshot of selecting the Create action group.":::

    On the Action Group screen, type **emailgroup** in the **Action group name** field.

    :::image type="content" source="../media/dp-3300-module-66-lab-19.png" alt-text="Screenshot of entering emailgroup and selecting Next: Notifications.":::

1. Select **Next: Notifications**.

    :::image type="content" source="../media/dp-3300-module-66-lab-20.png" alt-text="Screenshot of the Create action group page with information added.":::

    Enter the following information:

    - Notification type: **Email/SMS message/Push/Voice**
    - Name: **DemoLab**
    - Email: You can use the Azure Username you signed in with

1. Select **OK** in the Email/SMS message/Push/Voice flyout.

1. Select **Review + create**, then select **Create**.

    :::image type="content" source="../media/dp-3300-module-66-lab-21.png" alt-text="Screenshot of the Create alert rule page selecting the Create alert rule.":::

1. On the Create alert rule screen, add an **Alert rule name** of **DemoAlert**, and then select **Create alert rule**.

An email like this is sent to the email address that you entered, once the rule is created.

:::image type="content" source="../media/email-confirmation.png" alt-text="Screenshot of the confirmation email.":::

With the alert in place, if the CPU usage on average exceeds 80%, an email like this is sent.

:::image type="content" source="../media/email-alert-received.png" alt-text="Screenshot of the warning email.":::

To finish this exercise select **Done** below.
