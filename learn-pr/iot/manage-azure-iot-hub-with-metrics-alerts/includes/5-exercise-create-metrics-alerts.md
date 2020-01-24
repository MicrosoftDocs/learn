

## Create and visualize some metrics



## Create an alert using the metrics and Email action

  ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-email-action-group.png)

  ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-email-alert.png)


  ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-email-metric.png)


  ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-email-alert-logic.png)

  ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-email-note.png)

## Create an Azure Function using the HHTP trigger template

  ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-function-1.png)

  ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-function-2.png)

1. Wait for the deployment succeeded message, then click **Go to resource**.

1. Click the plus sign to the right of **Functions**.

  ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-function-plus.png)

1. Select **In-portal**, and click **Continue**.

  ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-function-in-portal.png)

1. Select **More templates..**, click **Finish and view templates**, then select **Http trigger**.

  ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-function-http.png)

1. Leave the **Name** of the new function as **HttpTrigger1**, and click **Create**. You should now see the function code.

  ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-function-http-body.png)

1. Click the **</> Get function URL**, and save off the URL to a text file.

1. Click **Save**. You have now created an Azure Function.

## Create an alert using the metics and HTTP trigger action

  ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-function-action-group.png)

  ![Screenshot showing how to name, and then create, a new device template](../media/metrics-alerts-function-logic.png)