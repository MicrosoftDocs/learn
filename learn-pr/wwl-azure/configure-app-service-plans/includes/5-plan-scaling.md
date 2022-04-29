Autoscale allows you to have the right amount of resources running to handle the load on your application. It allows you to add resources to handle increases in load and also save money by removing resources that are sitting idle. You specify a minimum and maximum number of instances to run and add or remove VMs automatically based on a set of rules. When rule conditions are met, one or more autoscale actions are triggered.

## Autoscale settings

An autoscale setting is read by the autoscale engine to determine whether to scale out or in. Autoscale settings are grouped into profiles.

:::image type="content" source="../media/web-app-autoscale-94c4da54.png" alt-text="Screenshot of the Create a Scale Condition page. The scale mode selection is Scale Based on Metric. The Scale to specific instance count selection is also shown.":::


Rules include a trigger and a scale action (in or out). The trigger can be metric-based or time-based.

 -  **Metric-based**. Metric-based rules measure application load and add or remove VMs based on that load. For example, do this action when CPU usage is above 50%. Examples of metrics are CPU time, Average response time, and Requests.
 -  **Time-based**. Time-based (schedule-based) rules allow you to scale when you see time patterns in your load and want to scale before a possible load increase or decrease occurs. For example, trigger a webhook every 8am on Saturday in a given time zone.

## Considerations

 -  Having a minimum instance count makes sure your application is always running even under no load.
 -  Having a maximum instance count limits your total possible hourly cost.
 -  You can automatically scale between the minimum and maximum using rules you create.
 -  Ensure the maximum and minimum values are different and have an adequate margin between them.
 -  Always use a scale-out and scale-in rule combination that performs an increase and decrease.
 -  Choose the appropriate statistic for your diagnostics metric (Average, Minimum, Maximum and Total).
 -  Always select a safe default instance count. The default instance count is important because autoscale scales your service to that count when metrics are not available.
 -  Always configure autoscale notifications.

## Notification settings

A notification setting defines what notifications should occur when an autoscale event occurs based on satisfying the criteria of one of the autoscale setting’s profiles. Autoscale can notify one or more email addresses or make calls to one or more webhooks.
