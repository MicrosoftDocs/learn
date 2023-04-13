In Azure App Service, an application runs in an Azure App Service plan. An App Service plan defines a set of compute resources for a web application to run. The compute resources are analogous to a server farm in conventional web hosting. One or more applications can be configured to run on the same computing resources (or in the same App Service plan).

### Things to know about App Service plans

Let's take a closer look at how to implement and use an App Service plan with your virtual machines.

- When you create an App Service plan in a region, a set of compute resources is created for the plan in the specified region. Any applications that you place into the plan run on the compute resources defined by the plan.

- Each App Service plan defines three settings:
   - **Region**: The region for the App Service plan, such as West US, Central India, North Europe, and so on.
   - **Number of VM instances**: The number of virtual machine instances to allocate for the plan.
   - **Size of VM instances**: The size of the virtual machine instances in the plan, including Small, Medium, or Large.

- You can continue to add new applications to an existing plan as long as the plan has enough resources to handle the increasing load.

#### How applications run and scale in App Service plans

The Azure App Service plan is the scale unit of App Service applications. Depending on the pricing tier for your Azure App Service plan, your applications run and scale in a different manner. If your plan is configured to run five virtual machine instances, then all applications in the plan run on all five instances. If your plan is configured for autoscaling, then all applications in the plan are scaled out together based on the autoscale settings.

Here's a summary of how applications run and scale in Azure App Service plan pricing tiers:

- **Free or Shared tier**:
   - Applications run by receiving CPU minutes on a shared virtual machine instance.
   - Applications can't scale out.

- **Basic, Standard, Premium, or Isolated tier**:
   - Applications run on all virtual machine instances configured in the App Service plan.   
   - Multiple applications in the same plan share the same virtual machine instances.
   - If you have multiple deployment slots for an application, all deployment slots run on the same virtual machine instances.
   - If you enable diagnostic logs, perform backups, or run WebJobs, these tasks use CPU cycles and memory on the same virtual machine instances.

### Things to consider when using App Service plans

Review the following considerations about using Azure App Service plans to run and scale your applications. Think about what conditions might apply to running and scaling the hotel website.

- **Consider cost savings**. Because you pay for the computing resources that your App Service plan allocates, you can potentially save money by placing multiple applications into the same App Service plan.

- **Consider multiple applications in one plan**. Create a single plan to support multiple applications, to make it easier to configure and maintain shared virtual machine instances. Because the applications share the same virtual machine instances, you need to carefully manage your plan resources and capacity.

- **Consider plan capacity**. Before you add a new application to an existing plan, determine the resource requirements for the new application and identify the remaining capacity of your plan.

   > [!Important]
   > Overloading an App Service plan can potentially cause downtime for new and existing applications.

- **Consider application isolation**. Isolate your application into a new App Service plan when:
   - The application is resource-intensive.
   - You want to scale the application independently from the other applications in the existing plan.
   - The application needs resource in a different geographical region.