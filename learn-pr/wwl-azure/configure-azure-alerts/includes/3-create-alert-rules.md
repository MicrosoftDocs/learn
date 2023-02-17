To create an alert in the Azure portal, you define an alert rule for the alert. The alert rules consist of resources, action groups, and monitor conditions that represent the target and criteria for your alert operation. 

:::image type="content" source="../media/create-alert-337a7110.png" alt-text="Screenshot of the Create rule page in the Azure portal that shows settings for resources, conditions, and action groups." border="false":::

### Things to know about creating alert rules

Let's take a closer look at how to create and work with alert rules.

- An alert rule consists of several key attributes:

   - Your **target resource** defines the scope and signals that are available for your alert operation. A target can be any Azure resource such as a virtual machine, an Azure storage account, or a Virtual Machine Scale Sets instance. A target can also be a Log Analytics workspace or an Azure Application Insights resource. For certain resources like Azure Virtual Machines, you can specify multiple resources as the target for your alert rule.
   
   - The target resource emits a **signal** based on your selected resource type. The emitted signal can be Metric, Activity log, Application Insights, or Log.
   
   - The **criteria** for an alert rule combines your signal with processing logic and applies the result to your target resource. An example of a criteria combination is `\* Percentage CPU &gt; 70%; Server Response Time &gt; 4 ms; and Result count of a log query &gt; 100`.
   
   - The **severity** of your alert corresponds to the conditions defined in your alert rule. When an issue matches your rule conditions, this attribute value indicates the severity of the issue. You can specify a severity in the range from 0 to 4.
   
   - When an issue matches your rule conditions, the system invokes the responsive steps for the alert rule as specified in the **action** attribute.
   
   - Each of your alert rules has a specific **name** and **description**.

- By default, the system sets a new alert rule to _enabled_. If you don't want an alert to trigger, set the alert rule to _disabled_.

- An alert can only trigger when the alert rule is in the _enabled_ state.