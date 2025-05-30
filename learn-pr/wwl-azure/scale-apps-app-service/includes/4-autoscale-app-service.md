In this unit, you learn how to enable autoscaling, create autoscale rules, and monitor autoscaling activity

## Enable autoscale

Get started with autoscaling by navigating to your App Service plan in the Azure portal and select **Scale out (App Service plan)** in the **Settings** group in the left navigation pane. Select **Rules Based** in the **Scale out method** section of the page, and then select **Configure**.

> [!NOTE]
> Not all pricing tiers support autoscaling. The development pricing tiers are either limited to a single instance (the **F1** and **D1** tiers), or they only provide manual scaling (the **B1** tier). If you selected one of these tiers, you must first scale up to the **S1** or any of the **P** level production tiers.

By default, an App Service Plan only implements manual scaling. Selecting **Custom autoscale** reveals condition groups you can use to manage your scale settings.

:::image type="content" source="../media/enable-autoscale.png" alt-text="Screenshot showing the Custom autoscale selection.":::

## Add scale conditions

Once you enable autoscaling, you can edit the automatically created default scale condition, and you can add your own custom scale conditions. Remember that each scale condition can either scale based on a metric, or scale to a specific instance count.

The Default scale condition is executed when none of the other scale conditions are active. 

:::image type="content" source="../media/autoscale-conditions.png" alt-text="Screenshot of the condition page for an App Service Plan showing the default scale condition.":::

A metric-based scale condition can also specify the minimum and maximum number of instances to create. The maximum number can't exceed the limits defined by the pricing tier. Additionally, all scale conditions other than the default may include a schedule indicating when the condition should be applied.

## Create scale rules

A metric-based scale condition contains one or more scale rules. You use the **Add a rule** link to add your own custom rules. You define:
* The criteria that indicate when a rule should trigger an autoscale action.
* The autoscale action to be performed.

:::image type="content" source="../media/autoscale-rules.png" alt-text="Screenshot of the scale rule settings pane.":::

## Monitor autoscaling activity

The Azure portal enables you to track when autoscaling occurred through the **Run history** chart. This chart shows how the number of instances varies over time, and which autoscale conditions caused each change.

:::image type="content" source="../media/autoscale-run-history.png" alt-text="Screenshot of the Run history information for the app.":::

You can use the **Run history** chart with the metrics shown on the **Overview** page to correlate the autoscaling events with resource utilization.

:::image type="content" source="../media/service-plan-metrics.png" alt-text="Screenshot of the metrics shown on the App Service Plan overview page.":::
