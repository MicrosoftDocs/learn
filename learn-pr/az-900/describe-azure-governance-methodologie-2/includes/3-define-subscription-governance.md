## Subscription governance

One of the highest, overarching areas you can apply governance controls to, in your Azure environment, is at the subscription level. There are three main aspects to consider in relation to creating and managing subscriptions: **Billing**, **Access Control**, and **Subscription limits**. 

You should take these into account when designing your subscription architecture:

+ **Billing**: Billing reports can be generated per subscription. If you have multiple internal departments and need to do a "chargeback" of cloud costs, a possible scenario is to create subscriptions by department or by project. Resource tags can also help here, and we will explore tags later in this module. When defining how many subscriptions you need and what they will be called, take into account your internal billing requirements.

+ **Access Control**: A subscription is a deployment boundary for Azure resources.  Every subscription is associated with an Azure Active Directory tenant which provides administrators the ability to set up granular access via defined roles, using role-based access control (RBAC). When designing your subscription architecture, consider the deployment boundary factor.  Do you need separate subscriptions for development and for production environments, for example, so you can control access levels to each one separately and isolate their resources from each other.  

+ **Subscription Limits**: Subscriptions also have some resource limitations. For example, the maximum number of network "Express Route circuits" per subscription is 10. Those limits should be considered during your design phase.  If you will need to exceed those limits for particular scenarios, then you may need to add additional subscriptions. If you hit a hard limit maximum, there is no flexibility to increase it. Learn more about [subscription limits](https://docs.microsoft.com/azure/azure-subscription-service-limits?azure-portal=true).

<div style="background: yellow;">
TODO: 
Are management groups still included in this module re the exam OD?
</div>

Also available to assist with managing subscriptions are management groups, which manage access, policies, and compliance across multiple Azure subscriptions. We will discuss management groups in more detail later.

<div style="background: yellow;">
TODO: 
Add what TWT has decided to do with their subscription architecture - diagram this.
</div>

