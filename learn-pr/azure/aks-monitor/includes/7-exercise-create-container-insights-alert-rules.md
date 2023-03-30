In this exercise, you’ll enable an alert rule and action group to send you a text message when the CPU for a node is running high. You’ll then enable an alert rule to detect when a pod restarts and then test that rule by simulating an error condition.

## Create alert rule for Node CPU

1. From your AKS cluster, select **Insights**.
1. At the top of the screen, select **Recommended alerts**.  
1. Select **Enable** to enable metrics on your cluster, if the button appears.

    >[!Note]
    > It may take 60 minutes for the required permissions to propagate after you enable metrics.  

1. Locate the alert with the *Node CPU%* rule. Select the switch in the **Status** column to change the status to *Enabled*.
1. Select the *Node CPU%* title to view the details of the alert rule.  
  :::image type="content" source="../media/container-insights-recommended-alerts.png" lightbox="../media/container-insights-recommended-alerts.png" alt-text="A screenshot showing the insights page on an AKS cluster.":::
1. Notice the **Condition** section. It contains a description of the details condition *Whenever the average cpuusagepercentage is greater than 80%*. This means that the alert fires when the CPU of the node exceeds 80%. The alert is resolved when the CPU drops below this value.
You can select the condition to modify the threshold, but for this exercise, we’ll leave it at the default.  


## Create action group

1. From the **Recommended alerts (Preview)**, on the row for **Node CPU %**, select the message **No action group assigned** to create an action group and assign it to the rule that you just enabled.

1. Select **Create action group** to create a new one.
1. Enter an **Action group name** and **Display name** for the new action group and select the **Notifications** tab.  

    :::image type="content" source="../media/create-action-group-basics.png" lightbox="../media/create-action-group-basics.png" alt-text="A screen shot showing the create action group basics tab.":::
1. Select a **Notification type** of *Email/SMS message/Push/Voice*.
1. Select **SMS** and then type in your phone number to receive the text message.
   :::image type="content" source="../media/action-group-notifications.png" lightbox="../media/action-group-notifications.png" alt-text="A screen shot showing the notifications tab of the create action group page.":::
1. Provide a **Name** for the entry and then select **Review + create** to save the action group.
1. A text message is sent to your phone confirming that it is included in the action group.
1. In the **Action Groups** list, select your new action group and select **Apply to rule**.  
    :::image type="content" source="../media/actions-groups-apply.png" lightbox="../media/actions-groups-apply.png" alt-text="A screen shot showing the action group to apply to the alert rule.":::

## Create alert rule for restarting container

The Node CPU alert will be difficult to simulate for a test application, so enable another alert rule that fires when a container is restarted which might be due to an unhandled fault in the application for example. You can use the same action group that you already created to apply to this alert rule.

1. Locate the alert with the **Rule Name** *Restarting container count*. Select the slider in the **Status** column to change its status to *Enabled*.

   :::image type="content" source="../media/restarting container-alert.png" lightbox="../media/restarting container-alert.png" alt-text="Screenshot enable restarting container count alert rule.":::

1. Select the message **No action group assigned** to create an action group and assign it to the rule that you just enabled.
1. Select the action group that you created and select **Apply to rule**.

### Test alert

To test the alert rule, trigger a container restart by stopping the primary process in the deployment. Use `kubectl` to run a shell command in the container to stop the process.

1. In the Azure portal, select the button to launch Cloud Shell.
1. Run the following command to get a command line:

   ```bash
   kubectl exec -it deploy/contoso-website -- /bin/sh
   ```

1. From the command line, run the following command:

   ```bash
   # kill 1
   ```

1. The output is similar to the following:

   ```
   # command terminated with exit code 137
   ```
   :::image type="content" source="../media/test-alert.png" lightbox="../media/test-alert.png" alt-text="Screenshot showing a Cloud Shell with output from a kubectl command.":::

3. Within a minute or so, you should receive a text to the number you specified with a message similar to the following:

   ```
   aks-test:Fired:Sev3 Azure Monitor Alert Restarting container count for aks-contoso-video CI-7 on aks-contoso-video
   ```

4. Go to **Alerts** for your cluster to view the fired alert that should now be displayed.
5. Select the alert to view its details.

   :::image type="content" source="../media/fired-alert-details.png" lightbox="../media/fired-alert-details.png" alt-text="A screenshot showing the alert details page.":::

6. Within a few minutes, you should receive a second text similar to the following. This message was sent because the container restarted to repair the missing process. Azure Monitor then marked the alert as resolved.  

   ```
   aks-test:Resolved:Sev3 Azure Monitor Alert Restarting container count for aks-contoso-video CI-7 on aks-contoso-video
   ```

7. Go back to the **Alerts** page and select **Refresh**. Note that the alert is no longer listed.
