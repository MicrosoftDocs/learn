In Azure App Service, an application runs in an Azure App Service plan. An App Service plan defines a set of compute resources for a web application to run. The compute resources are analogous to a server farm in conventional web hosting. One or more applications can be configured to run on the same computing resources (or in the same App Service plan).

## Things to know about App Service plans

Let's take a closer look at how to implement and use an App Service plan with your virtual machines.

- When you create an App Service plan in a region, a set of compute resources is created for the plan in the specified region. Any applications that you place into the plan run on the compute resources defined by the plan.

- Each App Service plan defines these settings:
   - **Operating system**: Linux or Windows. 
   - **Region**: The region for the App Service plan, such as West US, Central India, North Europe, and so on.
   - **Pricing tier**: Determines what App Service features you get and how much you pay for the plan. The pricing tiers available to your App Service plan depend on the operating system selected at creation time.
   - **Number of VM instances**: Currently ranges from three to 30. 
   - **Size of VM instances**: Defined by CPU, memory, and remote storage. 

- You can continue to add new applications to an existing plan as long as the plan has enough resources to handle the increasing load.



## Things to consider when using App Service plans

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
