The pricing tier of an Azure App Service plan determines what App Service features you get and how much you pay for the plan.

### Things to know about App Service plan pricing tiers

There are six categories of pricing tiers for an Azure App Service plan. Examine the following plan details and think about which plans can support the hotel website requirements.

| Feature | Free | Shared | Basic | Standard | Premium | Isolated |
| --- | --- | --- | --- | --- | --- | --- |
| Usage | Development, Testing | Development, Testing | Dedicated development, Testing | Production workloads | Enhanced scale, performance | High performance, security, isolation |
| Web, mobile, or API applications | 10 | 100 | Unlimited | Unlimited | Unlimited | Unlimited |
| Disk space | 1 GB | 1 GB | 10 GB | 50 GB | 250 GB | 1 TB |
| Auto scale | n/a | n/a | n/a | Supported | Supported | Supported |
| Deployment slots | n/a | n/a | n/a | 5 | 20 | 20 |
| Max instances | n/a | n/a | Up to 3 | Up to 10 | Up to 30 | Up to 100 |

#### Free and Shared

The Free and Shared service plans are base tiers that run on the same Azure virtual machines as other applications. Some applications might belong to other customers. These tiers are intended to be used for development and testing purposes only. No SLA is provided for the Free and Shared service plans. Free and Shared plans are metered on a per application basis.

#### Basic

The Basic service plan is designed for applications that have lower traffic requirements, and don't need advanced auto scale and traffic management features. Pricing is based on the size and number of instances you run. Built-in network load-balancing support automatically distributes traffic across instances. The Basic service plan with Linux runtime environments supports Web App for Containers.

#### Standard

The Standard service plan is designed for running production workloads. Pricing is based on the size and number of instances you run. Built-in network load-balancing support automatically distributes traffic across instances. The Standard plan includes auto scale that can automatically adjust the number of virtual machine instances running to match your traffic needs. The Standard service plan with Linux runtime environments supports Web App for Containers.

#### Premium

The Premium service plan is designed to provide enhanced performance for production applications. The upgraded Premium plan, Premium v2, offers Dv2-series virtual machines with faster processors, SSD storage, and double memory-to-core ratio compared to the Standard tier. The new Premium plan also supports higher scale via increased instance count while still providing all the advanced capabilities of the Standard tier. The first generation of Premium plan is still available to support existing customer scaling needs.

#### Isolated

The Isolated service plan is designed to run mission critical workloads that are required to run in a virtual network. The Isolated plan allows customers to run their applications in a private, dedicated environment in an Azure datacenter. The plan offers Dv2-series virtual machines with faster processors, SSD storage, and a double memory-to-core ratio compared to the Standard tier. The private environment used with an Isolated plan is called the App Service Environment. The plan can scale to 100 instances with more available upon request.