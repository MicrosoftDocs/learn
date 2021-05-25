After building a Minimum Viable Product, the innovation hypothesis needs to be validated. In this unit, you will learn how Azure tools can help in this crucial part of the innovation process.

## Measuring Effectiveness

Measuring whether a hypothesis was right or wrong can be tricky, since there might be multiple factors influencing Key Performance Indicators that might give hints about the expected success, since establishing causality can be complex. For example, even if sales increase after introducing a certain feature, whether the new feature was the main responsible for the sales increase is hard to proof.

However, the way in which features are released to application users can help to assess the validity of a hypothesis:

- Controlled deployment with **feature flags**, feature rings, and canary deployments allow you to release the feature to a limited set of users, to prevent disrupting the experience of the whole customer base. Additionally, the performance of the customers with and without the feature can be directly compared to each other.
- **Portal options** for users to decide if they want to be exposed to new functionality puts the user in control of their own experience. The fact that many users opt for a new feature might already be a confirmation that the previous functionality had room for improvement. If customers that had opted for the new feature go back to the previous experience, that might be an indicator that the deployed Minimum Viable Product is missing the mark.
- **Customer surveys** are a powerful feedback mechanism, if implemented correctly. Customers will provide information about their satisfaction, as long as it is simple to give. One click traffic light satisfaction surveys or single questions about new functionality might provide rich insights to help evaluating whether the innovation hypothesis was correct or not. In general, longer surveys are only going to be answered by a few users, who will take the time to fill them in thoroughly and truthfully.

## Understanding Your Application

[Azure Application Insights](https://docs.microsoft.com/azure/azure-monitor/app/app-insights-overview?azure-portal=true) is an extensive Application Performance Management (APM) platform with a rich set of tools to gather application telemetry for multiple purposes, such as performance monitoring, problem troubleshooting, or understanding how users navigate applications. Especially the latter functionality is critical for the innovation lifecycle, since it can be used to validate innovation hypothesis, and to judge whether a certain innovation is improving the customer experience or not.

### Detecting Problems Before Users Do

A crucial element impacting the user experience is the performance and availability of an application. If an application is not working correctly and running into errors, or even if it is not responsive enough, some users will abandon it out of frustration. Your organization might be losing potential business, and those frustrated users could cause a loss of reputation if sharing their experience in social media.

Hence it is of capital importance detecting those problematic situations before they impact actual users. To that goal, you need to proactively monitor the application to start working on potential problems before they impact the business. For example, you can enable notifications to automatically open incidents so that they get investigated even before customers report on them.

[Smart Detection](https://docs.microsoft.com/azure/azure-monitor/app/proactive-failure-diagnostics?azure-portal=true) is a very useful functionality of Azure Application Insights, where alerts can be raised when the application behavior is unusual. Anomalies are detected using Machine Learning, and they are richer than traditional error notifications:  These anomalies typically report that there might be a problem, without context about the potential business impact. However, Smart Detection alerts will be enriched with information such as how many users are impacted, the pattern associated with the failures, or the failure rate compared to normal behavior, so that you can focus in the most impending issue from a business perspective.

### Monitoring User Activity

[Usage Analysis](https://docs.microsoft.com/azure/azure-monitor/app/usage-overview?azure-portal=true) with Azure Application Insights can help you to evaluate which application areas need to be improved. For example, to identify the most popular application features, or specific points at which users leave the web portal. You can explore, for example,  whether your application works better in certain geographic areas than others, giving you valuable information about where the application gaps might be.

After formulating a hypothesis with the data provided by Azure Application Insights, telemetry can be analyzed to measure whether the situation is now better or worse. Custom business events can be embedded in the application, so that this telemetry data contains additional information that will help in the measure process.

[Funnels](https://docs.microsoft.com/azure/azure-monitor/app/usage-funnels?azure-portal=true) can be an insightful tool, where you can predefine expected "flows" that users will follow when using the application. This allows you to monitor which patterns users follow. This helps to identify problems in the applications if users are behaving in unexpected ways.

### User Retention

Application Insights [Retention Tool](https://docs.microsoft.com/azure/azure-monitor/app/usage-retention#the-retention-tool?azure-portal=true) offers specific functionality around user churn. Combined with business events, it contains valuable learning data. For example, understanding which actions were executed by customers who left the application unexpectedly will allow you to formulate hypothesis with maximum business impact.

For example, if most users abandoning your web site did so from the payment method page, you could safely conclude that there is a business problem there: either the payment options are insufficient, they are not clearly displayed, or there is any other problem that prevents users from moving forward in their shopping process.

### Impact Analysis

[Impact Analysis](https://docs.microsoft.com/azure/azure-monitor/app/usage-impact?azure-portal=true) is a component of Azure Application Insights that correlates technical aspect of the application to tangible business metrics.

For example, how fast should the product page load so that most users continue with their shopping process? With Impact Analysis, you can show the relationship between page load time and the rate of users that purchase the product shown. This information can help you to validate or reject innovation hypothesis, and to convert business requirements into technical specifications.

## Summary

Tailwind Traders decided to introduce some new features in the e-commerce application, such as a new payment platform. The application has been instrumented with Azure Application Insights to understand how many customers are using the new payment method, and whether there is a significative increase of conversion rate in the payment process. The new payment method was marked as "Preview", so that users would be more understanding if there is problems.

This allows Tailwind Traders to identify that a high percentage of users decided to pick up the new payment method in spite of the "Preview" banner, and Application Insights confirmed that the new functionality worked as expected without major flaws. Additionally, the purchase conversion rate has increased significantly. Tailwind Traders can now focus on turning the Minimum Viable Product for the new payment method into a production-grade feature, and move on to the Learn phase of the innovation lifecycle to formulate further hypothesis.
