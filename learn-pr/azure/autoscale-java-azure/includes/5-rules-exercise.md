In this exercise, we look at exercises for setting up and triggering autoscaling of your sample application.

## Manually triggering autoscale

Next, we'll look at how to trigger autoscale manually.

## The sample microservice application

The PetClinic application is decomposed into four core microservices. All of them are independently deployable applications organized by business domains.

- Customers service: Contains general user input logic and validation including pets and owners information (Name, Address, City, Telephone).
- Visits service: Stores and shows visits information for each pets' comments.
- Vets service: Stores and shows Veterinarians' information, including names and specialties.
- API Gateway: A single entry point into the system, used to handle requests and route them to an appropriate service, and aggregate the results.

We've setup autoscale to trigger on the customer service microservice when the tomcat request count exceed 5 sessions per minute on average.

After the autoscale is triggered, it will then scale down if the request count is less than, or equal to 5.

## Navigate to the Autoscale page in the Azure portal

1. Sign in to the Azure portal
2. Go to the Azure Spring Cloud **Overview** page.
3. Select the resource group that contains your service.
4. Select the **Apps** tab under **Settings** in the menu on the left navigation pane.
5. Select the application for which you want to set up Autoscale. In this example, select the application named **demo**. You should then see the application's **Overview** page.
6. Go to the **Scale out** tab under **Settings** in the menu on the left navigation pane.
7. Select the deployment you want to set up Autoscale. You should see options for Autoscale shown in the following section.

![Autoscale menu](../media/autoscale-menu.png)

## Trigger the autoscaling via a script

To trigger the auto scale we will need to generate some load to get the average tomcat request count above 5. You'll use Azure Application Insights for this task. Create an Application Insights instance from the Azure portal and click on performance testing under the configure menu. Click on new and choose manual test under test type. Copy and paste the below public endpoint of the gateway app, and replace the service name with the name of your spring cloud instance and Click on "run test".

```bash
https://<your-spring-cloud-service>-api-gateway.azuremicroservices.io/api/customer/owners
```

After the load test is complete, let’s head back to Metrics under the Monitoring section of our Azure Spring Cloud instance. We see our average tomcat request count increase during the load test.

## Viewing autoscale events

In the autoscale setting screen, go to the Run history tab to see the most recent scale actions. The tab also shows the change in Observed Capacity over time. To find more details about all autoscale actions including operations such as update/delete autoscale settings, view the activity log and filter by autoscale operations.
