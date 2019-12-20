You've successfully deployed your application or service into Azure. Does the work stop there? What happens when there's a failure in production? How do you know it happened? How do you notify the right people?

In [Recommend and design system feedback mechanisms](/learn/modules/recommend-system-feedback-mechanisms/?azure-portal=true), you saw how the Tailspin team is getting ready for upcoming beta tests. They've put a plan in place for gathering customer feedback but there's more to think about.

Another important part of the feedback loop includes collecting monitoring data from your applications and infrastructure. Doing so enables you to identify failures and then route those failures to teams who can take appropriate action.

Effective monitoring happens not only in production, but at each stage along the way. This includes your test and other pre-production environments. By catching performance and functional issues early, you can correct them before changes reach your users.

## Learning objectives

In this module, you'll learn:

- How Azure Monitor and Application Insights enable continuous monitoring on your applications and on your infrastructure.
- How IT Service Management Connector can help you implement a ticketing system.
- How to build dashboards that enable you to visualize and act on monitoring data.

## Prerequisites

The modules in this learning path and previous learning paths form a progression.

You can take just this module, but if you want to follow the progression from the beginning, be sure to first complete these learning paths:

* [Evolve your DevOps practices](/learn/paths/evolve-your-devops-practices?azure-portal=true)
* [Build applications with Azure DevOps](/learn/paths/build-applications-with-azure-devops?azure-portal=true)
* [Deploy applications with Azure DevOps](/learn/paths/deploy-applications-with-azure-devops/?azure-portal=true)
* [Automate your deployments with Azure DevOps](/learn/paths/automate-deployments-azure-devops/?azure-portal=true)

## Meet the team

You met the _Space Game_ web team at Tailspin Toys in previous modules. As a refresher, here's who you'll work with in this module.

:::row:::

[!include[](../../shared/includes/meet-andy-short-col.md)]

[!include[](../../shared/includes/meet-amita-short-col.md)]

[!include[](../../shared/includes/meet-tim-short-col.md)]

[!include[](../../shared/includes/meet-mara-short-col.md)]

[!include[](../../shared/includes/meet-irwin-short-col.md)]

:::row-end:::

Mara has prior experience with DevOps. She's helping the team adopt a more streamlined process by using Azure DevOps.