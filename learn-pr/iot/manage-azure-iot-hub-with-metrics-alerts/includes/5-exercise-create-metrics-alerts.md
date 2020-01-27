
## Create and visualize some metrics



## Create an alert using the metrics and Email action

1. In the portal page for your IoT Hub, click **Alerts**. You should see the response **All is good! You have no alerts.**.

1. Select **+ New alert rule**. This will bring up the **Create rule** page.

1. The **RESOURCE** entry should already have your IoT Hub name as the selection.

1. Let's create the action group next. Click **Create**, in the **ACTION GROUPS** section.

1. For **Action group name**, enter a descriptive name, such as "Email alerts for vibration telemetry". For **Short name**, something like "EmailAlert".

1. Enter your **Subscription**, and **Resource group**.

1. For the **Action group name** enter something like "EmailActionGroup", and select the **Email/SMS/Push/Voice** for **Action Type**.

    ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-email-action-group.png)

1. Click **OK**.

1. For the **Email/SMS/Push/Voice** entry, click the **Email** checkbox, and enter the email address you want the alerts to go to.

    ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-email-alert.png)

1. Leave the other entries blank, and click **OK**.

1. Click **OK** again, to add the action group. You should now be back at the **Create rule** page. Now, click **Add** under **CONDITION**. In the **Configure signal logic** page, go to the last page of entries, and select **Connected devices (preview)**.

    ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-email-metric.png)

1. In the **Configure signal logic** page, locate the **Operator** entry, and change it to **Greater than or equal to**. Change the **Aggregation type** to **Minimum**, and the **Threshold value** to **1**. Change the **Aggregation granularity (Period)** entry to **1 minute**. Clearly what we are doing here is firing off an email when our single device first connects to our IoT Hub.

1. Click **Done**.

    ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-email-alert-logic.png)

1. Check the email account you are using. Do you have a message that you have been added to an Azure action group?

    ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-email-note.png)

1. Add an **Alert rule name**, and a brief **Description**, to complete the **Create rule** page. Leave the **Severity** as **Sev 3**, and leave **Enable rule upon creation** as **Yes**. Now, click **Create alert rule**, noting the message it can take up to 10 minutes for this rule to become active.

This completes the process of creating an email rule. The next rule we want to create calls an Azure Function. So, first, let's create the Azure Function.

## Create an Azure Function using the HHTP trigger template

1. Click on **Home**, in the **Microsoft Azure** portal, so that the **+ Create a resource** icon appears.

1. Click **+ Create a resource**, and you should see **Function App** appear. If not, use the search bar to locate it. Click **Function App**.

1. Enter your subscription, resource group, and type an appropriate name into **Function App name**.

1. For **Runtime stack**, choose **.NET Core**.

    > [!NOTE]
    > For future reference, take note of the other options: Node.js, Python, Java, and PowerShell Core.

1. Select your **Region**, then click **Next: Hosting**. 

    ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-function-1.png)

1. You will need to choose a storage account, or create one if no options are offered. For **Operating System**, choose **Windows**, and for **Plan type**, choose **Consumption**.

    ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-function-2.png)

1. Now, click **Review + create**, then **Create**.

1. Wait for the deployment succeeded message, which may take a minute or two, then click **Go to resource**.

1. Click the plus sign to the right of **Functions**.

    ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-function-plus.png)

1. Select **In-portal**, and click **Continue**.

    ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-function-in-portal.png)

1. Select **More templates..**, click **Finish and view templates**, then select **Http trigger**.

    ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-function-http.png)

1. Leave the **Name** of the new function as **HttpTrigger1**, and click **Create**. You should now see the function code.

    ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-function-http-body.png)

1. Click the **Get function URL**, and save off the URL to a text file.

1. Click **Save**. You have now created an Azure Function.

## Create an alert using the metrics and HTTP trigger action

Create a second alert for your IoT Hub.

1. In the portal page for your IoT Hub, click **Alerts**.

1. Select **+ New alert rule**. This will bring up the **Create rule** page.

1. The **RESOURCE** entry should already have your IoT Hub name as the selection.

1. Let's create the action group next. Click **Create**, in the **ACTION GROUPS** section.

1. For **Action group name**, enter a descriptive name, such as "Vibration function action group". For **Short name**, something like "Vibration".

1. Enter your **Subscription**, and **Resource group**.

1. For the **Action group name** enter something like "VibrationActions", and select the **Azure Function** for **Action Type**. You should be able to locate the Azure Function you created in the previous section, **HttpTrigger1**.

    ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-function-action-group.png)

1. Click **OK** to complete the action group.

1. Back in the **Create rule** page, select **CONDITION**. We will add a condition that will fire when the total number of telemetry messages exceeds 30.

1. In the **Configure signal logic** page, type "telemetry" into the search bar. Select **Telemetry messages sent** from the list under **Signal name**.

1. Now enter the **Alert logic**. As the defaults are mostly what we want, just add **30** as the **Threshold value**.

    ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-function-logic.png)

1. Click **Done**.

## Next step

Great work. You have now created two alerts, an Azure Function, and should have a good idea of the range of actions and metrics available. The next step is to test the alerts.
