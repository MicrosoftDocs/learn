The Azure Toolkit for IntelliJ has several tools that you can use to configure Azure, but you need to understand the resources that you're creating to set up a web app correctly.

Suppose you're evaluating Azure as a host for your manufacturing company's customer-facing website. You want your developers to be able to work with the necessary resources in Azure from within their preferred IDE, IntelliJ IDEA. You've installed the Azure Toolkit for IntelliJ, and now you want to find out how you can use it to deploy web apps, both to the Azure App Service and as containers.

In this unit, you'll explore the app-publishing tools that the toolkit includes, and learn about the supporting platforms and objects that it creates in Azure. In the next exercise, you'll use this information to deploy your web app to Azure.

## Set up the Azure App service

The Azure App Service is a Platform-as-a-Service (PaaS) implementation of a web server in Azure. You can use it to host any HTTP-based service, including websites, REST APIs, and mobile back-ends. You have many language and framework choices when you write apps—one of them being Java Server Pages (JSP)—and you can choose whether the underlying infrastructure runs on Windows or Linux.

When you create an App Service to host your application, you also create these supporting objects:

- **Resource Group**

    A resource group is a logical grouping of Azure resources. Every resource must be in a resource group, but it's your choice how you organize resources. One common approach is to group resources together when they belong to the same application. For example, you could place an App Service instance that runs a website in the same resource group as the database that supports that website. Resource groups make it easier to manage related resources, so it's a good idea to group resources with a similar life cycle. For example, if you create a resource group that contains all the resources that support a staging environment, you can delete all the resources in one operation by deleting the resource group when staging is complete.

- **App Service Plan**

    An app service plan defines the set of compute resources that the app will run on. You can think of the service plan as the equivalent of a server farm in an on-premises system. For low-traffic or noncritical systems, you can use a small server farm, but for large, mission-critical applications, a fault-tolerant and scalable farm is required. The same approach applies to service plans. Each service plan is contained in a single Azure region, and it defines the number and size of the virtual machines that run the app and the pricing tier.

When you create the App Service, you also choose whether to use Linux or Windows virtual machines.

For applications written in Java, you specify a web container as well. You can choose from versions of Tomcat, Wildfly, and others.

When you have the Azure Toolkit for IntelliJ installed, you can configure all of the preceding objects and information within IntelliJ IDEA in the **Deploy to Azure** wizard.

:::image type="content" source="../media/4-create-webapp-wizard.png" alt-text="Screenshot of setting up a new Azure web app in IntelliJ IDEA." loc-scope="azure-app-service":::

In the following exercise, you'll use this wizard to deploy the web app that you created in the preceding exercise.
