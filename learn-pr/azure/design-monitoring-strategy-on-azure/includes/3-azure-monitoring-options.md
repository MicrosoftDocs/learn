As a financial organization, the reputation of your company depends on the reliability and security of its systems. It's critical to monitor your systems closely to ensure that any problems or attacks are identified before they can affect users. For example, if a malicious user attacks your payment system, you need to know quickly to neutralize the threat, or your customers' personal data may be at risk.

You'll explain the solutions in Azure that will enable you to continuously monitor your organization's services.

## What is Azure Security Center?

Azure Security Center is a service that manages the security of your infrastructure from a centralized location. Use Security Center to monitor the security of your workloads, whether they're on-premises or in the cloud.

Attacks are becoming more intelligent, and the number of people with the right security skills is low. Security Center helps you deal with these challenges because it provides you with tools that:

- **Improve your protection against security threats**. Use Security Center to monitor the health of your resources and implement recommendations from one central location, as shown below.

  ![Health of resources and security recommendations](../media/3-recommendations.png)

- **Ease the configuration of your security**. Security Center is natively integrated with other Azure services, such as PaaS services like SQL Database. For IaaS services, enable automatic provisioning in Security Center.

  ![Automatic provisioning](../media/3-automatic-provisioning.png)

Security Center will create an agent on each supported virtual machine as it's created. It then automatically starts collecting data from the machine. You use Security Center to reduce the complexity of configuring security in this way.

## What is Azure Application Insights?

You use Azure Application Insights to monitor and manage the performance of your applications. Application Insights automatically gathers information relating to performance and errors, and exceptions from your live applications. You also use Application Insights to diagnose what has caused the problems affecting your application. In the example below, you'll see a detailed breakdown of an exception and what caused it.

![Exceptions](../media/3-exceptions-app-insights.png)

Through usage analysis, you'll understand how your application is being used by your users.

![Usage reports](../media/3-usage-reports.png)

Use Application Insights to monitor the release pipelines for your application. You'll take appropriate action to resolve issues that affect your application before it's deployed to production. Use Application Insights to improve your development lifecycle in this way.

![Release pipeline](../media/3-release-pipeline.png)

## What is Azure Monitor?

Azure Monitor is the service you use to collect, combine, and analyze data from different sources.

All the application log data collected by Application Insights is stored in a workspace accessible to Azure Monitor. You'll then have a central location to monitor and analyze the health and performance of all your applications.

Other services like Security Center also rely on Azure Monitor. Security Center, for example, collects security-related data from your virtual machines and other resources. Security Center stores this data in a workspace accessible to you from Azure Monitor.  

![Azure Monitor dashboard](../media/3-azure-monitor.png)

Use Azure Monitor for a detailed view of your application's health, along with the health of your infrastructure, from one single location.  

![Query](../media/3-azure-monitor-save-query.png)

Through Azure Monitor's Log Analytics, you analyze data by querying log data from your workspaces.

## What is Azure Sentinel?

You use Azure Sentinel to collect data on the devices, the users, the infrastructure, and the applications across your enterprise. Use its built-in threat intelligence for detection and investigation to reduce false positives. Also, use Sentinel to proactively hunt for threats and anomalies, and respond using orchestration and automation.

You connect your data sources to Sentinel. These sources include Microsoft services such as Office 365, and Azure Advanced Threat Protection. These sources can also include external solutions, such as AWS CloudTrail or on-premises sources. The dashboard will show detailed information collected from your sources.

![Sentinel dashboard](../media/3-sentinel-dashboard.png)

Incidents help you group and combine alerts that are related. You use incidents to reduce the noise generated because of the scale of the data. Incidents also help you to further investigate any anomalous activities or threats that have raised alerts.

![Investigate incidents](../media/3-investigate-incidents.png)

Use playbooks to automate your response to alerts in Sentinel. You configure playbooks using Azure Logic Apps. Your playbook details the steps to take when an alert is triggered in Sentinel, as shown below.

![Playbooks](../media/3-playbooks-sentinel.png)

Use hunting queries to look for threats across your enterprise before alerts are raised. You use built-in hunting queries maintained by Microsoft security researchers as a base for when you build your own queries.

![Hunting queries](../media/3-hunting-queries.png)

Use notebooks to automate your investigations. Notebooks are playbooks that can consist of investigation or hunting step-by-steps that you reuse or share with others. Use Azure Notebooks for Azure Sentinel to develop and run your notebooks. For example, you could use the **Guided hunting - Office365-Exploring** notebook to hunt for anomalous activities in Office 365 across your enterprise.

![Notebooks](../media/3-sentinel-notebooks.png)
