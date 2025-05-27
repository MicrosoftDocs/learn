When we talk about an *incident*, we're specifically talking about an issue on our Microsoft Azure side. An incident is a platform-side issue that affects your services. During these rare but inevitable issues, our goal is to be as transparent as possible with you by providing regular updates direct from our engineers. We endeavor to inform the right people through the right channels and to share as much detail as possible. 

Although we generally don't share speculation or the inner workings of troubleshooting steps, we share everything that we know about the incident. There's no delay in messaging, even for detailed messaging, based on customer size or segment, partner status, or support plan. Microsoft partner organizations and even Microsoft account teams are notified at the same time and with the same updates as the affected customers that they represent.

## During an incident

1. **Review [Azure Service Health](https://www.aka.ms/ash-portal) within the Azure portal for the latest updates from our engineers**.

    If you notice an issue and need to understand *is it us or is it Azure*, checking Azure Service Health in the portal should be the first step. Although you should be aware of this 'go-to-' place, if you *configured the relevant service health alerts* beforehand, you *shouldn't need to hunt for information* reactively. During a known issue, these service health alerts trigger. They're notified using their chosen communications channel.

    > [!NOTE]
    >
    > Set up [Service Health alert](/azure/service-health/alerts-activity-log-service-notifications-portal) for getting notified of portal communications with the channel of your choice, such as email, SMS, or webhook.

2. **If there are issues accessing Service Health or the portal itself, check the public [Azure Status page](https://status.azure.com/)**.

    In the unlikely event that a service issue gets in the way of you being able to access Service Health in the Azure portal, `azure.status.microsoft` is used to post issue updates. This page is only used for issues that disrupt the usual communications path, or for rare widespread issues.

    The public status page `azure.status.microsoft` serves as a backup to Azure Service Health. We provide most of our service issue communications as targeted notifications sent directly to affected subscriptions or tenants. These notifications are delivered through Azure Service Health in the Azure portal and trigger any Azure Service Health alerts that have been configured. The public status page (`azure.status.microsoft`) is only used to communicate about service issues under three specific scenarios:

    - **Scenario 1**: Broad impact involving multiple regions, zones, or services. A service issue has broad/significant customer impact across multiple services for a full region or multiple regions. We notify you in this case because customer-configured resilience like high availability or disaster recovery might not be sufficient to avoid impact.

    - **Scenario 2**: Azure portal / Service Health not accessible. A service issue impedes you from accessing the Azure portal or Azure Service Health and thus affected our standard outage communications path described earlier.

    - **Scenario 3**: Service impact, but not sure who exactly is affected yet. The service issue has broad/significant customer impact but we aren't yet able to confirm which customers, regions, or services are affected. In this case, we aren't able to send targeted communications, so we provide public updates.

3. **If there are issues with the Status page, check for any updates over [@AzureSupport](https://x.com/AzureSupport) on X**.

    Only a few times in the history of Azure have there been technical issues that prevented posting incident updates on `azure.status.microsoft`. In these extraordinary circumstances, we post incident updates by using X at @AzureSupport.

    Regardless of the issue, customers should feel free to reach out to @AzureSupport for any questions relating to potential issues they're seeing or with support questions. The @AzureSupport team generally responds in less than 5 minutes. We're very proud of that record! During known issues, for example, if there's an outage listed in Service Health, the incident is already being worked on by the right engineers. There's potentially not much that the @AzureSupport team can do to help, beyond directing customers to the official engineering updates of what's happening.

4. **If your impact/issues don't match the incident (or if these persist after mitigation) [contact support](https://www.aka.ms/AzurePortalSupportRequest)**.

    This message is the most important note for customers to understand about what to do or not to do during an incident. As mentioned previously, during known issues, such as an outage listed in Service Health, the incident is already being worked on by the right engineers.

    Customers don't need to contact support for updates. They receive regular updates by using Service Health and their Service health alerts. Support engineers don't have access to any more detailed information than what is provided to affected customers. If customers read the updates from engineering but require support to respond to the incident, such as to implement their failover plans, they can and should raise a support ticket.

    Similarly, if the symptoms they're noticing doesn't seem to 'line up' with the symptoms being described in the issue updates, it might be unrelated. For example, suppose there's a known issue with Redis Cache in US East, but a customer sees issues with a Redis Cache in US East 2. In such a case, the customer can and should raise a support ticket.

    Finally, if a service issue is resolved or mitigated but the customer still sees issues with their services, support engineers can help them to understand if there's something special going on with their resources. In such a case, customers can and should raise a support ticket.
