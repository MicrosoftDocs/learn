When provisioning resources, you'd ideally make them as efficient as possible from the start. Workloads, demand, and technical requirements can change over time, but starting from an initially optimized workload will set you up for success down the line. Let's look at some ways to provision your resources with cost optimization in mind.

## Select appropriate service tiers and sizes

When provisioning resources on the cloud, selecting the right SKU or tier will have a direct impact on the capabilities, capacity, and performance of the service, tied directly to cost. Carefully evaluate the workload requirements for your application, and select the SKU or tier that matches the resource requirements.

There is a wide variety of virtual machine types to choose from when provisioning for VM based workloads. Assess the resource requirements for your workload, and select the proper VM SKU that most closely matches. Each VM SKU comes with an assigned amount of CPU, memory, and storage. Choose the size that most closely matches your requirements. Provisioning VM sizes can often be challenging, since you may be deploying for your maximum workload, even though your application may only need that capacity for a portion of it's running time. Choosing a VM size is not a permanent decision. You can modify your VM size at any time, but in most cases it will require a restart of your VM.

## Pay only for consumption

Many cloud services provide a consumption billing model. With consumption models you only pay for the amount of transactions, CPU time, or run time of your application. This can bring cost savings and efficiency to your application since you aren't paying for your the resources to run your application when it's not being used. Let's look at a few examples of Azure services that have a consumption cost model.

**Azure Functions** is an event-driven serverless compute platform that provides a consumption plan. When you're using the consumption plan, instances of the Azure Functions host are dynamically added and removed based on the number of incoming events. This serverless plan scales automatically, and you're charged for compute resources only when your functions are running. On a Consumption plan, a function execution times out after a configurable period of time.

Billing is based on number of executions, execution time, and memory used. With functions on a consumption plan, you pay only when your functions are running and can scale out automatically, even during periods of high load.

**Azure Logic Apps** is a service that helps you create automated integration workflows in the cloud. Logic Apps provides a consumption tier where you only pay per execution of a connector.

**Azure SQL Database** is service that enables you to store relational in the cloud. Azure SQL has a serverless tier where your costs can be reduced by pausing the database when it's not in use. Serverless is price-performance optimized for single databases with intermittent, unpredictable usage patterns that can afford some delay in compute warm-up after idle usage periods.

**Azure API Management** is a service that provides centralized API administration, proxy, and deployment. API Management has a consumption tier that bills per execution, and will scale out automatically as requests change over time. API Management consumption tier allows API Management to be used in a serverless fashion, with instant provisioning, automated scaling, built-in high availability and pay-per-action pricing

## Use spot instances for low priority workloads

Using Spot VMs allows you to take advantage of unused capacity on Azure at a significant cost savings. At any point in time when Azure needs the capacity back, the Azure infrastructure will evict Spot VMs. Spot VMs are great for workloads that can handle interruptions like batch processing jobs, dev/test environments, large compute workloads, and more.

## Take advantage of reserved instances

Azure Reservations help you save money by committing to one-year or three-year plans for multiple products. Committing allows you to get a discount on the resources you use. Reservations can significantly reduce your resource costs up to 72% on pay-as-you-go prices. Reservations provide a billing discount and don't affect the runtime state of your resources. After you purchase a reservation, the discount automatically applies to matching resources.

Reservations are available for services such as:

- Windows and Linux virtual machines
- Azure SQL Database
- Cosmos DB
- Azure Synapse Analytics
- Azure Storage

If you have consistent resource usage that supports reservations, buying a reservation gives you the option to reduce your costs. For example, when you continuously run instances of a service without a reservation, you're charged at pay-as-you-go rates. When you buy a reservation, you immediately get the reservation discount. The resources are no longer charged at the pay-as-you-go rates.

## Use managed services when possible

Whenever possible, take advantage of combining lower resource costs and lower operational costs by utilizing managed services. These services come with lower operational costs since you don't need to patch and manage the underlying infrastructure and services. Deploying applications on VMs comes with the administration and maintenance of the operating system, as well as any layered software.

Azure SQL Database is a great example of a managed service. You can deploy a single or pooled database, or a managed instance. All of these are fully managed, you don't need to patch the underlying database software, and operational items like backup are built-in and provided for you.

Azure App Service is another example of a managed service that is designed to host web applications. Rather than deploying and managing VMs to host your web applications, you can deploy your applications directly to App Service and dramatically reduce the amount effort required to maintain infrastructure.
