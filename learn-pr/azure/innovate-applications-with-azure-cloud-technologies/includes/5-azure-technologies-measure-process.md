
After building a Minimum Viable Product, the hypothesis it was based needs to be validated. In this unit you will learn how Azure tools can help in this crucial part of the innovation process.

## Measuring Effectiveness

To measure whether a hypothesis was right or wrong can be tricky, since there might be multiple factors influencing Key Performance Indicators that might indicate the expected success, since establishing causality can be very complex. For example, even if sales increase after introducing a certain feature, whether the new feature was the main responsible for the sales increase is hard to proof.

However, the way in which features are released can help by assessing the validity of a hypothesis:

- Controlled deployment with feature flags, feature rings and canary deployments allow to release the feature to a limited set of users, to prevent disrupting the experience of the whole customer base. Additionally, the performance of the customers with and without the feature can be directly compared to each other.
- Portal options for users to decide if they want to be exposed to new functionality or not puts the user in control of their own experience. The fact that many users opt for a new feature might already be a confirmation that the previous functionality had room for improvement. If on the contrary customers that had opted for the new feature go back to the previous one, that might be an indicator that the deployed Minimum Viable Product is missing the mark.
- Customer surveys: surveys are a powerful feedback mechanism, especially if implemented right. Customers will provide information about their satisfaction, as long as it is simple to give. One click traffic light satisfaction surveys or single questions about new functionality might provide rich insights to help evaluating whether the innovation hypothesis was correct or not.

## Azure Application Insights

[Azure Application Insights](https://docs.microsoft.com/azure/azure-monitor/app/app-insights-overview) is an extensive Application Performance Management (APM) platform with a set of tools to gather application telemetry for multiple purposes, such as performance monitoring, problem troubleshooting, or understand how users navigate applications. Especially the latter functionality is extremely relevant for the innovation lifecycle, since it will be critical to validate innovation hypothesis and judge whether a certain innovation is improving the customer experience or not.

[Usage Analysis](https://docs.microsoft.com/azure/azure-monitor/app/usage-overview) with Azure Application Insights can help you evaluate which application areas need to be improved. For example, to identify specific points at which users leave the web portal, or offering data for both new users and returning users. You can explore whether your application work better in certain geographic areas than others, giving you valuable information about where the application gaps might be.

After formulating a hypothesis with the data provided by Azure Application Insights, new telemetry data can be leveraged to measure whether the situation is now better or worse. Custom business events can be embedded in the application, so that telemetry data contains additional information that will help in the measure process.

Application Insights [Retention Tool](https://docs.microsoft.com/azure/azure-monitor/app/usage-retention#the-retention-tool) offers specific functionality around user churn, and combined with business events offer very valuable learning data. For example understanding which actions exactly were executed by customers who left the application will allow you to formulate hypothesis with maximum business impact.

## Summary

Tailwind Traders decided to introduce some new features in the application, such as the new payment platform. The application has been instrumented with Azure Application Insights to understand how many customers are leveraging the new payment method, as well as whether there is a significative customer churn during the payment process. The new payment method was marked as "Preview", so that users would be more understanding in case of problems.

This allowed them to identify that a high percentage of users decided to pick up the new payment method in spite of the "Preview" banner, and Application Insights confirmed that the new functionality worked as expected without major flaws. Tailwind Traders can now focus on turn the Minimum Viable Product used to validate the hypothesis into a production-grade feature, and continue the innovation lifecycle.
