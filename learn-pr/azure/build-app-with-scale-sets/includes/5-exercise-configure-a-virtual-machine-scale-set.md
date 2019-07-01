In the shipping company scenario, you need to arrange for the virtual machine scale set hosting your web application to scale horizontally as demand increases. To save costs, you also need get the scale set to scale back in once demand drops.

In this exercise, you'll:

- Configure the scale set you created in the previous lab to scale out when the CPU threshold exceeds 75% utilization.
- Create another scale rule to reduce the number of instances when the demand drops and the average CPU utilization falls below 50%.

## Create a scale-out scale rule

[!include[](../../../includes/azure-sandbox-activate.md)]

1. Return to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). If necessary, sign in using your MSLearn account.

2. Go to the page for the virtual machine scale set.

3. On the virtual machine scale set page, under **Settings**, click **Scaling**.

4. Click **Enable autoscale**

    ![Screenshot of the virtual machine scale set page](../media/5-enable-autoscale.png)

5. In the **Default** scale rule, set the **Scale mode** to **Scale based on a metric**, and then click **+ Add a rule**.

   ![Screenshot of the virtual machine scale set page](../media/5-add-rule.png)

6. On the **Scale rule** page, specify the following settings, and then click **Add**:

    | Property  | Value  |
    |---|---|
    | Metric source | Current resource (webServerScaleSet) |
    | Time aggregation | Average  |
    | Metric name | Percentage CPU |
    | Time grain statistic | Average |
    | Operator | Greater than |
    | Threshold | 75 |
    | Duration | 10 |
    | Operation | Increase count by |
    | Instance count | 1 |
    | Cool down (minutes) | 5 |

## Create a scale-in scale rule

1. In the **Default** scale rule, click **+ Add a rule** again.

2. On the **Scale rule** page, specify the following settings, and then click **Add**:

    | Property  | Value  |
    |---|---|
    | Metric source | Current resource (webServerScaleSet) |
    | Time aggregation | Average  |
    | Metric name | Percentage CPU |
    | Time grain statistic | Average |
    | Operator | Less than |
    | Threshold | 50 |
    | Duration | 10 |
    | Operation | Decrease count |
    | Instance count | 1 |
    | Cool down (minutes) | 5 |

3. Click **Save**.

    The **Default** scale condition now contains two scale rules. One to scale the number of instances out, and another to scale the number of instances back in again.

    ![Screenshot of the virtual machine scale set page](../media/5-scale-rules.png)
