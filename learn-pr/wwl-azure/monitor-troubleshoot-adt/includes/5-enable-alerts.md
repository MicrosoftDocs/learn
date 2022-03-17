Azure Digital Twins collects metrics for your service instance that give information about the state of your resources. You can use these metrics to assess the overall health of Azure Digital Twins service and the resources connected to it.

Alerts proactively notify you when important conditions are found in your metrics data. They allow you to identify and address issues before the users of your system notice them. You can read more about alerts in [Overview of alerts in Microsoft Azure](/azure/azure-monitor/alerts/alerts-overview).

:::image type="content" source="../media/m11-l04-adt-alerts-portal-ae673195.png" alt-text="Screenshot that shows how to create Azure Digital Twins Alerts in the Azure portal.":::


Selecting **+ New alert rule** opens the **Create alert rule** page. You can follow the prompts to define conditions, actions to be triggered, and alert details.

:::image type="content" source="../media/m11-l04-adt-create-alert-rule-portal-5b023528.png" alt-text="Screenshot that shows how to create Alert rules for Azure Digital Twins in the Azure portal.":::


Referring to the Create alert rule image above:

 -  Scope details should fill automatically with the details for your instance.
 -  You will define Condition and Action group details to customize alert triggers and responses.
 -  In the Alert rule details section, enter a name and optional description for your rule. You can select the Enable alert rule upon creation checkbox if you want the alert to become active as soon as it is created.
    
     -  This is also where you select a resource group and Severity level.

For a guided walkthrough of filling out these fields, see [Overview of alerts in Microsoft Azure](/azure/azure-monitor/alerts/alerts-overview).
