5. **Exercise - Troubleshoot networking using Network Watcher metrics and logs**
 
In this module, you will do an exercise which involves troubleshooting using network watcher metrics and logs. You will carry on with exercise from module 3. There was NSG which blocked connectivity from **BackendSubnet** VM to everywhere over specific  port **80, 8080 and 3389**.

**Exercise - Troubleshoot networking using Network Watcher metrics and logs**

In this exercise, you will re-configure NSG  for the VMs you created in the previous exercise.

1. Introduce a configuration problem that prevents correct communication between the VMs. This problem should be something that can be diagnosed from a flow log.

1. Register the Microsoft.Insights provider - NSG flow logging requires the Microsoft.Insights provider. To register the provider, complete the following steps:
    - In the top, left corner of portal, select All services. In the Filter box, type Subscriptions. When Subscriptions appear in the search results, select it.
    - From the list of subscriptions, select the subscription you want to enable the provider for.
    - Select Resource providers, under *Settings*.
    - In search bar type in *microsoft.insights*. Confirm that the *Status* for the *microsoft.insights* the provider is *Registered*. If the status is *Unregistered*, then select *Register*, to the right of the provider.

1. Enable the NSG flow log - NSG flow log data is written to an Azure Storage account. In the portal, go to Network security groups, chose the NSG. Under the monitoring tab for the NSG, click on NSG flow logs and turn on the flow logs.  NSG flow logs have 2 versions.
   - Version 1 - Logs ingress and egress IP traffic flows for both allowed and denied traffic.
   - Version 2  - Provides additional throughput information (bytes and packets) per flow.

   Enable logs for version 2. If you don’t have Azure Storage account, you can create a storage account from the NSG flow log blade.  The storage account may take around a minute to create. Don't continue with remaining steps until the storage account is created. If you use an existing storage account instead of creating one, you can move to the next step.

1. Generate network traffic between VMs that will be caught in the flow log.

1. Download and view the flow log. Diagnose the problem.

1.	Fix the problem - Change the NSG configuration so both subnets can communicate with each other over HTTP and HTTPS.
