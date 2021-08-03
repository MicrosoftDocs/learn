In this exercise, we look at exercises for setting up and triggering autoscaling of your sample application.

## The sample microservice application

The PetClinic application is decomposed into four core microservices. All of them are independently deployable applications organized by business domains.

- Customers service: Contains general user input logic and validation including pets and owners information (Name, Address, City, Telephone).
- Visits service: Stores and shows visits information for each pets' comments.
- Vets service: Stores and shows Veterinarians' information, including names and specialties.
- API Gateway: A single entry point into the system, used to handle requests and route them to an appropriate service, and aggregate the results.

We've setup autoscale to trigger on the customer service microservice when the tomcat request count exceeds five sessions per minute on average.

After the autoscale is triggered, it will then scale down if the request count is less than, or equal to 5.
In the next exercises, you'll trigger either manually or via Azure Application Insights, or a script for this task.

## Navigate to the Autoscale page in the Azure portal

1. Sign in to the Azure portal
2. Go to the Azure Spring Cloud **Overview** page.
3. Select the resource group that contains your service.
4. Select the **Apps** tab under **Settings** in the menu on the left navigation pane.
5. Select the application for which you want to set up Autoscale. In this example, select the application named **demo**. You should then see the application's **Overview** page.
6. Go to the **Scale out** tab under **Settings** in the menu on the left navigation pane.
7. Select the deployment you want to set up Autoscale. You should see options for Autoscale shown in the following section.

![Autoscale menu](../media/autoscale-menu.png)

## Viewing autoscale events

In the autoscale setting screen, go to the Run history tab to see the most recent scale actions. The tab also shows the change in Observed Capacity over time. To find more details about all autoscale actions including operations such as update/delete autoscale settings, view the activity log and filter by autoscale operations.

## Trigger the scale-out action manually

To trigger the scale-out condition in the autoscale setting created, the Web App must have more than five requests in less than 1 minute.

1. Open a browser window and navigate to the Web App created earlier in this tutorial. You can find the URL for your Web App in the Azure portal by navigating to your Web App resource and clicking on the Browse button in the 'Overview' tab.

1. In quick succession, reload the page more than 10 times.

1. From the left-hand navigation pane, select the Monitor option. Once the page loads select the Autoscale tab.

1. From the list, select the App Service Plan used throughout this tutorial.

1. On the autoscale setting, select the Run history tab.

1. You see a chart reflecting the instance count of the App Service Plan over time.

1. In a few minutes, the instance count should rise from 1, to 2.

1. Under the chart, you see the activity log entries for each scale action taken by this autoscale setting.

## Trigger a scale-in action manually

The scale-in condition in the autoscale setting triggers if there are fewer than five requests to the Web App over a period of 10 minutes.

1. Ensure no requests are being sent to your Web App.

1. Load the Azure portal.

1. From the left-hand navigation pane, select the Monitor option. Once the page loads select the Autoscale tab.

1. From the list, select the App Service Plan used throughout this tutorial.

1. On the autoscale setting, select the Run history tab.

1. You see a chart reflecting the instance count of the App Service Plan over time.

1. In a few minutes, the instance count should drop from 2, to 1. The process takes at least 100 minutes.

1. Under the chart, are the corresponding set of activity log entries for each scale action taken by this autoscale setting.

![Autoscale log](../media/scale-in-chart.png)

## Trigger out the scale-out action with Application insights

To trigger the auto scale, we will need to generate some load to get the average tomcat request count above five.
Create an Application Insights instance from the Azure portal and select performance testing under the configure menu.
Select "new" and choose "manual test" under test type.
Copy and paste the below public endpoint of the gateway app, and replace the service name with the name of your spring cloud instance and select "run test".

```bash
https://<your-spring-cloud-service>-api-gateway.azuremicroservices.io/api/customer/owners
```

After the load test is complete, let’s head back to Metrics under the Monitoring section of our Azure Spring Cloud instance. We see our average tomcat request count increase during the load test.

## Trigger the scale-out action with a script

```bash
sh loadTest.sh
```
