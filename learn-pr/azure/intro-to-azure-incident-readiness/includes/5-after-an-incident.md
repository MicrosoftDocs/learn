The Azure engineering team conducts internal retrospectives for service incidents that affect customers, to learn from what happened. This approach is to make incidents less likely, or at least less impactful. Insights from these internal investigations are provided to affected customers and partners as **Post Incident Reviews (PIRs)**.

For our largest most impactful service incidents, especially incidents with multi-service and multi-region impact, we also invite affected customers to an **Azure Incident Retrospective** livestream. They can hear our engineering leaders summarize what happened and what we learned. Customers and partners can get any questions about the incident answered by our subject matter experts.

If as a result of one or more service incidents we don't achieve or maintain our **Service Level Agreements (SLAs)**, affected customers might be eligible to claim a credit towards a portion of their monthly service fees.

## Post Incident Reviews (PIRs)

For every Azure service incident that affects customers, we provide a **Mitigation Statement** that summarizes what happened, with which services in which regions, and when the impact started and was ultimately mitigated.

- For smaller, less impactful service issues where the trigger and contributing factors are already well understood, this mitigation statement is the final summary. For example, when issues affect only a subset of a single service within a single region with a relatively short impact duration.

- For service issues that were mitigated but still require investigation to understand fully, the mitigation statement is followed by a **Post Incident Review (PIR)** after our internal investigations complete, generally within 14 days of mitigation. PIRs include any learnings or improvements that Microsoft is making as a result of the incident, and any relevant resilience recommendations for how customers and partners can make similar incidents less impactful.

- For our largest, most impactful service issues the mitigation statement is followed by a **Preliminary Post Incident Review (PIR)** generally within 72 hours of mitigation, to summarize what we learned so far from the still-in-progress investigation. For example, when issues affect multiple services, or multiple regions, or with an extended impact duration. After our internal retrospective completes, generally within 14 days of mitigation, a **Final Post Incident Review (PIR)** is published to provide more details or learnings.

[Azure Service Health](https://www.aka.ms/ash-portal) sends all Post Incident Reviews (PIRs) to affected subscriptions, landing in the Health history page. These reports also trigger any customer-configured [Service Health alerts](https://www.aka.ms/ash-alerts) where the alert criteria include the *Service issue* event type, and are denoted with the `Stage` attribute set to `RCA`. For incidents that met our public disclosure criteria, *Scenario 1* incidents, as outlined in our [public documentation](/azure/service-health/azure-status-overview#when-does-azure-publish-communications-to-the-status-page), the most recent Post Incident Review is also available on the [Azure Status History page](https://azure.status.microsoft/status/history/).

> [!NOTE]
>
> We're in the process of transitioning from *Root Cause Analyses (RCAs)* to *Post Incident Reviews (PIRs)*. You might temporarily see both terms used interchangeably in the Azure portal and in Service Health alerts.

## Azure Incident Retrospective (Customer livestream events)

For our largest most impactful service incidents, especially incidents that met our public disclosure criteria, Scenario 1 incidents as outlined in our [public documentation](/azure/service-health/azure-status-overview#when-does-azure-publish-communications-to-the-status-page), we invite affected customers to participate in an **Azure Incident Retrospective** livestream event.

These webcast-style forums enable the customers and partners who were affected by the incident to watch a discussion with the engineering leaders of our relevant service teams. The discussion summarizes what happened, how we responded, what we learned, and what we're going to do or are already doing to make *incidents like this* less likely, or at least less impactful.

Beyond just watching this discussion with engineering leaders, Azure Incident Retrospective livestreams also give customers and partners the opportunity to get any questions about the incident answered by our subject matter experts. We offer a moderated Question & Answer (Q&A) side-panel, staffed by representatives from our relevant engineering teams.

To ensure that you're invited to an Azure Incident Retrospective if a qualifying Scenario 1 incident affects your services, make sure that you configure [Azure Service Health](https://www.aka.ms/ash-alerts) alerts. Invites to the Azure Incident Retrospective livestreams are distributed to Service Health and by using Service Health alerts, just like Post Incident Reviews (PIRs).

After each livestream, we publish a recording of the session to [this YouTube playlist](https://www.aka.ms/air/videos) and, where relevant, update the PIR on the [Status History page](https://azure.status.microsoft/status/history/) with a link to it.

## Service Level Agreements (SLAs) and Service Credit process

The Service Level Agreements (SLA) describe Microsoft's commitments for uptime and connectivity for Microsoft Online Services. The current and archived editions of the SLA are [available for download](https://aka.ms/csla) and they cover Azure, as well as Dynamics 365, Office 365, and Intune. If we don't achieve and maintain the Service Levels for each Service as described in this SLA for any reason, including as a result of one or more service incidents, customers might be eligible for a credit towards a portion of their monthly service fees.

In order for Microsoft to consider an SLA credit request claim, you must submit a claim to customer support within two months of the end of the billing month in which the incident that is the subject of the claim occurred. To submit a claim, sign in to the Azure portal, [create a new support request](https://go.microsoft.com/fwlink/p/?linkid=2202692), select an Issue type of **Billing**, select a Problem type of **Refund Request**. Provide as much detail as possible, including the incident Tracking ID from Azure Service Health, and information around which services and resources you believe were impacted as a result.

Our billing support teams validate which resources, services, and subscriptions were impacted. They calculate and apply any relevant SLA credits. We use commercially reasonable efforts to process claims during the subsequent month and within 45 days of receipt. If we determine that a service credit is owed to you, we apply the service credit to your applicable monthly service fees.

Service credits are your sole and exclusive remedy for any performance or availability issues for any service under the agreement the SLA. Previews and online services or service tiers provided free of charge aren't included or eligible for SLA claims or credits. The service credits awarded in any billing month for a particular service or service resource don't under any circumstance exceed your monthly service fees for that service or service resource, as applicable, in the billing month.
