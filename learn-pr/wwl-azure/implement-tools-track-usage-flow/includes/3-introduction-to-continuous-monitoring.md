
:::image type="content" source="../media/route-system-feedback-b3040309.png" alt-text="Screenshot of the Routing System Feedback with migrate, secure, protect, monitor, configure and govern.":::


Continuous monitoring refers to the process and technology required to incorporate monitoring across each DevOps and IT operations lifecycles phase.

It helps to continuously ensure your application's health, performance, reliability, and infrastructure as it moves from development to production.

Continuous monitoring builds on the concepts of Continuous Integration and Continuous Deployment (CI/CD), which help you develop and deliver software faster and more reliably to provide continuous value to your users.

[Azure Monitor](/azure/azure-monitor/overview) is the unified monitoring solution in Azure that provides full-stack observability across applications and infrastructure in the cloud and on-premises.

It works seamlessly with [Visual Studio and Visual Studio Code](https://visualstudio.microsoft.com/) during development and testing and integrates with [Azure DevOps](/azure/devops/user-guide/index) for release management and work item management during deployment and operations.

It even integrates across your ITSM and SIEM tools to help track issues and incidents within your existing IT processes.

This article describes specific steps for using Azure Monitor to enable continuous monitoring throughout your workflows.

It includes links to other documentation that provides details on implementing different features.

## Enable monitoring for all your applications

To gain observability across your entire environment, you need to enable monitoring on all your web applications and services.

It will allow you to visualize end-to-end transactions and connections across all the components easily.

 -  [Azure DevOps Projects gives you a simplified experience with your existing code and Git repository or choose](/azure/devops-project/overview) from one of the sample applications to create a Continuous Integration (CI) and Continuous Delivery (CD) pipeline to Azure.
 -  [Continuous monitoring in your DevOps release pipeline](/azure/application-insights/app-insights-vsts-continuous-monitoring) allows you to gate or roll back your deployment based on monitoring data.
 -  [Status Monitor](/azure/application-insights/app-insights-monitor-performance-live-website-now) allows you to instrument a live .NET app on Windows with Azure Application Insights without modifying or redeploying your code.
 -  If you have access to the code for your application, then enable complete monitoring with [Application Insights](/azure/application-insights/app-insights-overview) by installing the Azure Monitor Application Insights SDK for [.NET](/azure/application-insights/quick-monitor-portal), [Java](/azure/application-insights/app-insights-java-quick-start), [Node.js](/azure/application-insights/app-insights-nodejs-quick-start), or [any other programming language](/azure/application-insights/app-insights-platforms). It lets you specify custom events, metrics, or page views relevant to your application and business.

## Enable monitoring for your entire infrastructure

Applications are only as reliable as their underlying infrastructure.

Monitoring enabled across your entire infrastructure will help you achieve full observability and make discovering a potential root cause easier when something fails.

Azure Monitor helps you track the health and performance of your entire hybrid infrastructure, including resources such as VMs, containers, storage, and network.

 -  You automatically get [platform metrics, activity logs, and diagnostics logs](/azure/azure-monitor/data-sources) from most of your Azure resources with no configuration.
 -  Enable deeper monitoring for VMs with [Azure Monitor](/azure/azure-monitor/insights/vminsights-overview).
 -  Enable deeper monitoring for AKS clusters with [Azure Monitor for containers](/azure/azure-monitor/insights/container-insights-overview).
 -  Add [monitoring solutions](/azure/azure-monitor/insights/solutions-inventory) for different applications and services in your environment.

[Infrastructure as code](/azure/devops/learn/what-is-infrastructure-as-code) manages infrastructure in a descriptive model, using the same versioning as DevOps teams use for source code.

It adds reliability and scalability to your environment and allows you to apply similar processes to manage your applications.

 -  Use [Resource Manager templates](/azure/azure-monitor/platform/template-workspace-configuration) to enable monitoring and configure alerts over a large set of resources.
 -  Use [Azure Policy](/azure/governance/policy/overview) to enforce different rules over your resources. It ensures those resources comply with your corporate standards and service level agreements.

## Combine resources in Azure Resource Groups

Today, a typical application on Azure includes multiple resources such as VMs and App Services or microservices hosted on Cloud Services, AKS clusters, or Service Fabric.

These applications frequently use dependencies like Event Hubs, Storage, SQL, and Service Bus.

 -  Combine resources in Azure Resource Groups to get complete visibility of all the resources that make up your different applications. [Azure Monitor for Resource Groups](/azure/azure-monitor/insights/resource-group-insights) provides a simple way to keep track of the health and performance of your entire full-stack application and enables drilling down into respective components for any investigations or debugging.

## Ensure quality through continuous deployment

Continuous Integration / Continuous Deployment allows you to automatically integrate and deploy code changes to your application based on automated testing results.

It streamlines the deployment process and ensures the quality of any changes before they move into production.

 -  Use [Azure Pipelines](/azure/devops/pipelines) to implement Continuous Deployment and automate your entire process from code commit to production based on your CI/CD tests.
 -  Use Quality Gates to integrate monitoring into your pre-deployment or post-deployment. It ensures that you meet the key health/performance metrics (KPIs) as your applications move from dev to production. Any differences in the infrastructure environment or scale aren't negatively impacting your KPIs.
 -  [Maintain separate monitoring instances](/azure/application-insights/app-insights-separate-resources) between your different deployment environments, such as Dev, Test, Canary, and Prod. It ensures that collected data is relevant across the associated applications and infrastructure. If you need to correlate data across environments, use [multi-resource charts in Metrics Explorer](/azure/azure-monitor/platform/metrics-charts) or create [cross-resource queries in Log Analytics](/azure/azure-monitor/log-query/cross-workspace-query).

## Create actionable alerts with actions

A critical monitoring aspect is proactively notifying administrators of current and predicted issues.

 -  Create [alerts in Azure Monitor](/azure/azure-monitor/platform/alerts-overview) based on logs and metrics to identify predictable failure states. It would be best if you had a goal of making all alerts actionable, meaning that they represent actual critical conditions and seek to reduce false positives. Use [dynamic thresholds](/azure/azure-monitor/platform/alerts-dynamic-thresholds) to automatically calculate baselines on metric data rather than defining your static thresholds.
 -  Define actions for alerts to use the most effective means of notifying your administrators. Available [actions for notification](/azure/azure-monitor/platform/action-groups#create-an-action-group-by-using-the-azure-portal) are SMS, e-mails, push notifications or voice calls.
 -  Use more advanced actions to [connect to your ITSM tool](/azure/azure-monitor/platform/itsmc-overview) or other alert management systems through [webhooks](/azure/azure-monitor/platform/activity-log-alerts-webhook).
 -  Remediate situations identified in alerts with [Azure Automation runbooks](/azure/automation/automation-webhooks) or [Logic Apps](/connectors/custom-connectors/create-webhook-trigger) that can be launched from an alert using webhooks.
 -  Use [autoscaling](/azure/azure-monitor/learn/tutorial-autoscale-performance-schedule) to dynamically increase and decrease your compute resources based on collected metrics.

## Prepare dashboards and workbooks

Ensuring that your development and operations have access to the same telemetry and tools allows them to view patterns across your entire environment and minimize your Mean Time To Detect (MTTD) and Mean Time To Restore (MTTR).

 -  Prepare [custom dashboards](/azure/application-insights/app-insights-tutorial-dashboards) based on standard metrics and logs for the different roles in your organization. Dashboards can combine data from all Azure resources.
 -  Prepare [Workbooks](/azure/application-insights/app-insights-usage-workbooks) to ensure knowledge sharing between development and operations. It could be prepared as dynamic reports with metric charts and log queries or as troubleshooting guides designed by developers to help customer support or operations handle fundamental problems.

## Continuously optimize

Monitoring is one of the fundamental aspects of the popular Build-Measure-Learn philosophy, which recommends continuously tracking your KPIs and user behavior metrics and optimizing them through planning iterations.

Azure Monitor helps you collect metrics and logs relevant to your business and add new data points in the following deployment.

 -  Use tools in Application Insights to [track end-user behavior and engagement](/azure/application-insights/app-insights-tutorial-users).
 -  Use [Impact Analysis](/azure/application-insights/app-insights-usage-impact) to help you prioritize which areas to focus on to drive to important KPIs.
