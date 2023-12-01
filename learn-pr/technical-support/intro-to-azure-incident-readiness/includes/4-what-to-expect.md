When we talk about an "incident," we're specifically talking about an issue on our Microsoft/Azure side - a platform side issue that is impacting your services. During these rare but inevitable issues, our goal is to be as transparent as possible with you by providing regular updates direct from our engineers. We endeavor to inform the right people through the right channels and to share as much detail as possible. 

Although we generally don't share speculation or the inner workings of troubleshooting steps, we share everything that we know about the incident. There's no delay in messaging - even for detailed messaging - based on customer size or segment, partner status, or support plan - so Microsoft partner organizations and even Microsoft account teams are notified at the same time and with the same updates as the impacted customers they represent.

## During an incident

1. **Review [Azure Service Health](https://www.aka.ms/ash-portal) within the Azure portal for the latest updates from our engineers**.

    If you notice an issue and need to understand 'is it us or is it Azure' then checking Azure Service Health in the portal should be the first port of call. Although you should be aware of this 'go-to-' place, you **shouldn't need to hunt for information** reactively, if you have **configured the relevant service health alerts** beforehand. During a known issue, these service health alert(s) will trigger, and they will be notified using their chosen communications channel.

    > [!NOTE]
    >
    > As a reminder, setup [Service Health alert](/azure/service-health/alerts-activity-log-service-notifications-portal) for getting notified of portal communications via the channel of your choice (email, SMS, webhook)

2. **If there are issues accessing Service Health or the portal itself, check the public [Azure Status page](https://status.azure.com/)**.

    In the unlikely event that a service issue gets in the way of you being able to access Service Health in the Azure portal, then azure.status.microsoft is used to post issue updates. This page is only used for issues that disrupt the usual communications path, or for rare widespread issues. 

    It's important to remind you that azure.status.microsoft really serves as a backup to Azure Service Health. Most of our service issue communications are provided as targeted notifications sent directly to impacted subscriptions or tenants. These are delivered through Azure Service Health in the Azure portal and trigger any Azure Service Health alerts that have been configured. The public status page (azure.status.microsoft) is only used to communicate about service issues under three specific scenarios:

    - **Scenario 1** - Broad impact involving multiple regions, zones, or services - A service issue has broad/significant customer impact across multiple services for a full region or multiple regions. We notify you in this case because customer-configured resilience like high availability or disaster recovery may not be sufficient to avoid impact.

    - **Scenario 2** - Azure portal / Service Health not accessible - A service issue impedes you from accessing the Azure portal or Azure Service Health and thus impacted our standard outage communications path described earlier.

    - **Scenario 3** - Service Impact, but not sure who exactly is affected yet - The service issue has broad/significant customer impact but we aren't yet able to confirm which customers, regions, or services are affected. In this case, we aren't able to send targeted communications, so we provide public updates.

3. **If there are issues with the Status page, check for any updates via [@AzureSupport](http://www.twitter.com/AzureSupport) on Twitter**.

    Only a few times in the history of Azure, there have been technical issues preventing posting incident updates on azure.status.microsoft - in these extraordinary circumstances, we post incident updates via Twitter at @AzureSupport. But regardless of the issue, customers should feel free to reach out to @AzureSupport for any questions relating to potential issues they're seeing or with support questions. The @AzureSupport team generally responds in less than 5 minutes (we're very proud of that!) but it's important to know that during known issues (for example, if there's an outage listed in Service Health) then the incident is already being worked on by the right engineers so there's potentially not much that the @AzureSupport team will be able to do to help, beyond directing customers to the official engineering updates of what's happening.

4. **If your impact/issues don't match the incident (or if these persist after mitigation) [contact support](https://www.aka.ms/AzurePortalSupportRequest)**.

    This is the most important note for customers to understand about what to do (or not to do) during an incident. As mentioned above, during known issues (for example, if there's an outage listed in Service Health) then the incident is already being worked on by the right engineers - so customers don't need to contact support for updates. They will receive regular updates via Service Health (and their Service health alerts) and support engineers don't have access to any more detailed information than what is provided to impacted customers. If customers have read the updates from engineering but require support to respond to the incident (for example, to implement their failover plans) then they can and should raise a support ticket.
    
    Similarly, if the symptoms they're noticing doesn't seem to 'line up' with the symptoms being described in the issue updates (for example, if there's a known issue with Redis Cache in US East, but they're seeing issues with a Redis Cache in US East 2) then it may be unrelated and customers can and should raise a support ticket. Finally, if a service issue is resolved/mitigated but the customer is still seeing issues with their services, then support engineers can help them to see if there's something special going on with their resources, so customers can and should raise a support ticket.
