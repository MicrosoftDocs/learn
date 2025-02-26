Recall from the example scenario that your customers use one of the company's websites to manage and check the status of their shipments. This website is deployed to virtual machines and hosted on-premises. 

You notice that users of the website have significant delays in response times when the overall CPU usage of the virtual machines exceeds 75 percent. You need the Virtual Machine Scale Set that hosts your web application to scale when the system hits this threshold. To save costs, you also want to scale back in when demand falls and the overall CPU usage across the scale set drops below 50 percent.

In this exercise, you configure autoscaling. Define scale rules that scale out and in again, according to the system's CPU usage.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, you can read through the instructions to understand how to use the REST API to retrieve metrics.
>
> If you want to complete this exercise, but you don't have an Azure subscription or prefer not to use your account, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## Create a scale-out rule

1. In the [Azure portal](https://portal.azure.com), go to the page for the Virtual Machine Scale Set.

1. On the Virtual Machine Scale Set page, under **Settings**, select **Scaling**.

1. Select **Custom autoscale**. In the **Default** scale rule, ensure that the **Scale mode** is set to **Scale based on a metric**. Then select **Add a rule**.

   :::image type="content" source="../media/5-add-rule.png" alt-text="Screenshot of the Virtual Machine Scale Set page with a callout featuring the Scale based on a metric option and the Add a rule link." lightbox="../media/5-add-rule.png":::

1. On the **Scale rule** page, specify the following settings, then select **Add**:

    | Property  | Value  |
    |---|---|
    | Metric source | Current resource (webServerScaleSet) |
    | Metric name | Percentage CPU |
    | Operator | Greater than |
    | Threshold | 75 |
    | Duration | 10 |
    | Time grain statistic | Average |
    | Time aggregation | Average  |
    | Operation | Increase count by |
    | Cool down (minutes) | 5 |
    | Instance count | 1 |

## Create a scale-in rule

1. In the **Default** scale rule, select **Add a rule**.

1. On the **Scale rule** page, specify the following settings, and then select **Add**:

    | Property  | Value  |
    |---|---|
    | Metric source | Current resource (webServerScaleSet) |
    | Metric name | Percentage CPU |
    | Operator | Less than |
    | Threshold | 50 |
    | Duration | 10 |
    | Time grain statistic | Average |
    | Time aggregation | Average  |
    | Operation | Decrease count by |
    | Cool down (minutes) | 5 |
    | Instance count | 1 |

1. Select **Save**.

    The **Default** scale condition now contains two scale rules. One rule scales the number of instances out. Another rule scales the number of instances back in.

    :::image type="content" source="../media/5-scale-rules.png" alt-text="Screenshot of the Virtual Machine Scale Set page with a callout featuring the rules section and the save button." lightbox="../media/5-scale-rules.png":::
