
After building a Minimum Viable Product, the hypothesis it was based needs to be validated. In this unit you will learn how Azure tools can help in this crucial part of the innovation process.

## Measuring Effectiveness

To measure whether a hypothesis was right or wrong can be tricky, since there might be multiple factors influencing Key Performance Indicators that might indicate the expected success, since establishing causality can be very complex. For example, even if sales increase after introducing a certain feature, whether the new feature was the main responsible for the sales increase is hard to proof.

However, the way in which features are released can help by assessing the validity of a hypothesis:

- Controlled deployment with **feature flags**, feature rings and canary deployments allow to release the feature to a limited set of users, to prevent disrupting the experience of the whole customer base. Additionally, the performance of the customers with and without the feature can be directly compared to each other.
- **Portal options** for users to decide if they want to be exposed to new functionality or not puts the user in control of their own experience. The fact that many users opt for a new feature might already be a confirmation that the previous functionality had room for improvement. If on the contrary customers that had opted for the new feature go back to the previous one, that might be an indicator that the deployed Minimum Viable Product is missing the mark.
- **Customer surveys** are a powerful feedback mechanism, if implemented correctly. Customers will provide information about their satisfaction, as long as it is simple to give. One click traffic light satisfaction surveys or single questions about new functionality might provide rich insights to help evaluating whether the innovation hypothesis was correct or not. Refrain from longer surveys that only few users are going to take the time to fill in thoroughly and truthfully.

## Understanding Your Application

[Azure Application Insights](https://docs.microsoft.com/azure/azure-monitor/app/app-insights-overview) is an extensive Application Performance Management (APM) platform with a set of tools to gather application telemetry for multiple purposes, such as performance monitoring, problem troubleshooting, or understand how users navigate applications. Especially the latter functionality is extremely relevant for the innovation lifecycle, since it will be critical to validate innovation hypothesis and judge whether a certain innovation is improving the customer experience or not.

### Detecting Problems Before Users Do

A critical element impacting the user experience is the performance and availability of an application. If an application is not working correctly and running into errors, or even if it is not responsive enough, a certain amount of users will abandon it out of frustration. Your organization might be losing potential business, as well as those frustrated users could cause a loss of reputation if sharing their experience in social media.

Hence it is of capital importance detecting those problematic situations before they impact actual users. To that goal, you need to proactively monitor the application to start working on potential problems before they impact the business. For example, you can enable notifications to automatically open incidents so that they get investigated even before customers report on them.

[Smart Detection](https://docs.microsoft.com/azure/azure-monitor/app/proactive-failure-diagnostics) is an extremely useful functionality of Azure Application Insights, where alerts can be raised when the application behavior is unusual. Anomalies are detected using Machine Learning, and are richer than traditional notifications: Ordinary alerts typically report that there **might** be a problem, without context about the potential business impact. However, Smart Detection alerts will be enriched with information such as how many users are impacted, the pattern associated with the failures or the failure rate compared to normal behavior, so that you can focus in the most impending issue from a business perspective.

### Monitoring User Activity

[Usage Analysis](https://docs.microsoft.com/azure/azure-monitor/app/usage-overview) with Azure Application Insights can help you evaluate which application areas need to be improved. For example, to identify the most popular application features or specific points at which users leave the web portal. You can explore whether your application work better in certain geographic areas than others, giving you valuable information about where the application gaps might be.

After formulating a hypothesis with the data provided by Azure Application Insights, new telemetry data can be leveraged to measure whether the situation is now better or worse. Custom business events can be embedded in the application, so that telemetry data contains additional information that will help in the measure process.

[Funnels](https://docs.microsoft.com/azure/azure-monitor/app/usage-funnels) can be a very insightful tool, where you can predefine expected "flows" that users will follow when using the application. This allows to monitor which patterns do users flow along your app, helping to identify problems in the applications if users are not following the behavior you would like them to.

### User Retention

Application Insights [Retention Tool](https://docs.microsoft.com/azure/azure-monitor/app/usage-retention#the-retention-tool) offers specific functionality around user churn, and combined with business events offer very valuable learning data. For example understanding which actions exactly were executed by customers who left the application will allow you to formulate hypothesis with maximum business impact.

For example, if most users abandoning your web site did so from the payment method page, you could safely conclude that there is a business problem there: either the payment options are insufficient, they are not clearly displayed, or there is any other problem that prevent users from moving forward in their shopping process.

### Impact Analysis

[Impact Analysis](https://docs.microsoft.com/azure/azure-monitor/app/usage-impact) is a component of Azure Application Insights that allows to correlate technical aspect to the application to very tangible business metrics.

For example, how fast should the product page load so that most users continue with their shopping process? With Impact Analysis you can show the correlation between page load time and the rate of users that purchase the product shown. This information can help to validate or reject innovation hypothesis, as well as to convert business requirements into technical specifications.

## Summary

Tailwind Traders decided to introduce some new features in the application, such as the new payment platform. The application has been instrumented with Azure Application Insights to understand how many customers are leveraging the new payment method, as well as whether there is a significative increase of conversion rate in the payment process. The new payment method was marked as "Preview", so that users would be more understanding in case of problems.

This allowed them to identify that a high percentage of users decided to pick up the new payment method in spite of the "Preview" banner, and Application Insights confirmed that the new functionality worked as expected without major flaws. Additionally, the purchase conversion rate has increased significantly. Tailwind Traders can now focus on turning the Minimum Viable Product into a production-grade feature, and move on to the Learn phase of the innovation lifecycle to formulate further hypothesis.
