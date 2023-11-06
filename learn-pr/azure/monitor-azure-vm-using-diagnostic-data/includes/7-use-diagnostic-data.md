Your band is on tour next month, and you have identified issues that, in some cases, can be surfaced through metrics and alerts. Your main areas of concern are Distributed Denial of Service (DDoS) attacks, and increased CPU load that would require another server.

In this unit, you look at some scenarios where you might use the data you're collecting to diagnose and fix problems.

## DDoS attack

To create a chart or alert for a DDoS attack, in the Azure portal, go to **Monitor** > **Metrics**. You then specify your public IP address as the resource to monitor and add DDoS metrics, including **Under DDoS attack or not**. You then add an alert to be notified of an attack.

You don't have to install the Azure Monitor Agent to be alerted about DDoS attacks. The alert is on the public IP address resource, not the VM.

:::image type="content" source="../media/7-ddos.png" alt-text="Screenshot that shows the 'Under DDoS attack' metric.":::

## Increased CPU load

Monitor CPU activity and memory availability to see if you need to scale up your web server. To monitor the CPU load, you can use the platform metric **Percentage CPU**. If you want more granularity, use the guest-level metrics such as **cpu/usage_active**, **cpu/usage_user**, **cpu/usage_system**.

To respond to a high load, you can create an alert rule for the virtual machine with a condition for the CPU metric. For example, you might monitor to see if the average value over any 15 minutes is higher than 85 percent.

:::image type="content" source="../media/7-condition.png" alt-text="Screenshot that shows adding an alert rule.":::

Then, add an action and create an action group. The action group sends you an email and you can then scale up your virtual machine.

:::image type="content" source="../media/7-runbook.png" alt-text="Screenshot that shows adding an action group.":::