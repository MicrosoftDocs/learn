There are two methods for scaling your Azure App Service plan and applications: _scale up_ and _scale out_. You can scale your applications manually or automatically, which is referred to as _autoscale_.

Watch the following video about how to implement automatic scaling for your Azure App Service plan and applications. 


> [!VIDEO https://www.youtube.com/embed/LS8ZPbQzRpc]

### Things to know about Azure App Service scaling

Let's examine the details of scaling for your Azure App Service plan and App Service applications.

- The scale up method increases the amount of CPU, memory, and disk space. Scaling up gives you extra features like dedicated virtual machines, custom domains and certificates, staging slots, autoscaling, and more. You scale up by changing the pricing tier of the Azure App Service plan where your application is placed.

- The scale-out method increases the number of virtual machine instances that run your application. You can scale out to as many as 30 instances, depending on your App Service plan pricing tier. Take advantage of App Service Environments in the Isolated tier to further increase your scale-out count to 100 instances. The scale instance count can be configured manually or automatically (autoscale).

- With autoscale, you can automatically increase the scale instance count for the scale-out method. Autoscale is based on predefined rules and schedules.

- Your App Service plan can be scaled up and down at any time by changing the pricing tier of the plan. 

### Things to consider when using Azure App Service scaling

Review the following benefits of implementing scaling for your App Service plan and applications. Think about the scaling advantages for your hotel website.

- **Consider manually adjusting plan tiers**. Start your plan at a lower pricing tier and scale up as needed to acquire more App Service features. Scale down when features are no longer needed, and control your overall costs.

   Consider a scenario where you start testing your web app by using the Azure App Service Free tier, where you pay nothing to use the service. After a while, you decide to add a custom DNS name to your web app, so you scale your plan up to the Shared tier. Next, you discover you need to create an SSL binding, so you scale your plan up to the Basic tier. Later, you determine a need for staging environments, so you scale up to the Standard tier. When you need more cores, memory, or storage, you can scale up to a bigger virtual machine size in the same tier.

   The same scaling process works in reverse. If you decide you no longer need capabilities or features of a higher tier, scale your plan down to a lower tier and save money.

- **Consider autoscale to support users and reduce costs**. Keep serving your users when your application is experiencing high throughput. Implement autoscale to control how many features and support are offered at a given time based on your preference settings and rule conditions. Autoscale helps you save money when the load on your application decreases by automatically reducing your subscribed features.

- **Consider no redeployment**. When you change your scale settings, you don't need to change your code or redeploy your applications. Changing your plan scale settings takes only seconds to apply. Your changes affect all applications in your App Service plan.

- **Consider scaling for other Azure services**. If your App Service application depends on other Azure services, such as Azure SQL Database or Azure Storage, you can scale these resources separately. These resources aren't managed by your App Service plan.