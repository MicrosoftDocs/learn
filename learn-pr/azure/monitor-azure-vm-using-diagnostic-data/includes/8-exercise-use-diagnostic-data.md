Azure allows you to take action on the metrics you're capturing. You can create alerts that email you, or start automations with runbooks. 

Now you'll create an alert based on your web servers CPU usage. If the CPU usage goes above the set threshold of 90 percent for five minutes, you get an email.

In this unit, you'll add an alert for your VM. Then you'll cause the VM CPU usage to spike, and receive the alert email.

## Create an alert based on CPU usage

If CPU usage goes above 90 percent for one minute, you'd like to get a notification. 

1. Go to the [Azure portal](https://portal.azure.com/) and sign in with the account you used to enable the sandbox.
1. Select **All resources**.
1. Select the **monitored-linux-vm** virtual machine you created.
1. On the left, scroll down and select **Metrics**.
1. At the top, select **New alert rule**.

### Select the resource

1. Under **RESOURCE**, select the **Select** button.
1. In the **Filter by resource type** field, select **Virtual machines**.
1. In the **Resource** list below, select the **monitored-linux-vm** VM.
1. Select **Done**.

### Create the condition

1. Under **CONDITION**, select **Add**.
1. Under **SIGNAL NAME**, select **Percentage CPU**.
1. Under **Alert logic**, for **Operator** select **Greater than or equal to**.
1. In the Threshold value field, enter **90**.
1. Select **Done**.

### Add an action

1. Under **ACTIONS**, select **Create action group**.


1. Enter the following values:

    |Field  |Value  |
    |---|---|
    |Action group name | **Email Alerts**          |
    |Short name        | **Emails**                |
    |ACTION NAME       | **High CPU Usage**        |
    |ACTION TYPE       | **Email/SMS/Push/Voice**  |

1. In the **Email/SMS/Push/Voice** pane, select **Email**, and in the field enter the email address to receive the notification.
  
   ![Screenshot that shows Email/SMS/Push/Voice pane ](../media/8-create-an-action.png)

1. Select **OK**.
1. On the **Add action group** pane, select **OK**.
1. Under **ACTIONS**, select **Select action group**.
1. Under **ACTION GROUP NAME**, select **Email Alerts**, then select the **Select** button.
1. Scroll down, and in the **Alert rule name**, enter **Web server CPU running hot**.
1. In **Description**, enter **An email alert that will notify when the CPU is over 90%**.
1. Select **Create alert rule**.

## Activate the alert

1. Scroll to the top and select the **Overview** pane.
1. Select **Connect**.
1. Copy the **Login using VM local account** field.
1. Connect to the VM by running the command you copied in the previous step. The n values are replaced by the IP address of your VM.

    ```bash
    ssh azureuser@nnn.nnn.nnn.nnn
    ```
1. When prompted type **yes**.
1. On your VM, install the stress utility app.

    ```bash
    sudo apt-get install stress
    ```
1. Run the following command to stress the VM's CPU.

    ```bash
    sudo stress --cpu 16 -v
    ```
1. Return to the portal and at the top, select **Dashboard**, then select the **KPI Dashboard**.
1. On the **Max CPU percentage guest OS for monitored-linux-vm** graph, select the ellipses (**...**) at the top right and  **Refresh**.
1. After a few minutes, the CPU should approach 100% and you'll receive an alert email.

    ![Screenshot of the alert email](../media/8-alert-email.png)