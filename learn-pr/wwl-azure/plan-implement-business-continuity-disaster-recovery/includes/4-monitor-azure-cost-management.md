Cost Management users often want answers to questions that many others ask. This unit walks you through getting results for common cost analysis tasks in Cost Management.

## View forecast costs

Forecast costs are shown in cost analysis areas for area and stacked column views. The forecast is based on your historical resource use. Changes to your resource use affect forecast costs.

In the Azure portal, navigate to cost analysis for your scope. For example: C**ost Management + Billing &gt; Cost Management &gt; Cost analysis.**

In the default view, the top chart has the Actual/Amortized cost and forecast cost sections. The solid color of the chart shows your Actual/Amortized cost. The shaded color shows the forecast cost. :::image type="content" source="../media/enrollment-forecast-50ac51d3-46086196-9ed48f0a-7a7cdd58.png" alt-text="Screenshot showing Forecast cost in cost analysis.":::


## View forecast costs grouped by service

The default view doesn't show forecast costs group by a service, so you have to add a group by selection.

The view shows your costs grouped for each service. The forecast cost isn't calculated for each service. It's projected for the Total of all your services.

:::image type="content" source="../media/forecast-group-by-service-f04602e6-407bd57b-88dd9d37-5272c41a.png" alt-text="Screenshot showing Grouped and forecast cost.png":::


## View forecast costs for a service

You can view forecast costs narrowed to a single service. For example, you might want to see forecast costs for virtual machines.

1.  In the Azure portal, navigate to cost analysis for your scope.
2.  Select **Add filter** and then select **Service** name.
3.  In the choose list, select a service. For example select, virtual machines.

Review the actual cost for selection and the forecast cost.

You can add more customizations to the view.

1.  Add a second filter for **Meter** and select a value to filter for an individual type of meter under your selected service name.
2.  Group by **Resource** to see the specific resources that are accruing cost. The forecast cost isn't calculated for each service. It's projected for the Total of all your resources.
    
    :::image type="content" source="../media/forecast-by-service-a82ff42f-85864f81-eaec67cc-579a25cf.png" alt-text="Screenshot showing Forecast and resource cost.":::
    

## View cost breakdown by Azure service

Viewing costs by an Azure service can help you to better understand the parts of your infrastructure that cost the most. For example, VM compute costs might be small. Yet you might accrue significant networking costs because of the amount of information emitting from the VMs. Understanding the primary cost drivers of your Azure services is essential so that you can adjust service usage, as needed.

1.  In the Azure portal, navigate to cost analysis for your scope.
2.  Select **Cost** by service and then group by **Service tier**.
3.  Change the view to **Table**.
    
    :::image type="content" source="../media/breakdown-by-service-e0b2cabb-628bbf7c-4b8e9bdc-5acc8ab4.png" alt-text="Screenshot showing cost breakdown by Azure service in a table.":::
    
