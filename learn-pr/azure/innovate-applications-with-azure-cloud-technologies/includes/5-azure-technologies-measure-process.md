After an organization builds an MVP, it needs to validate the innovation hypothesis. In this unit, you'll learn how Azure tools can help in this crucial part of the innovation process.

## Measuring effectiveness

Measuring whether a hypothesis was right or wrong can be tricky, because multiple factors might be influencing key performance indicators. These factors might give hints about the expected success, because establishing causality can be complex. For example, even if sales increase after the introduction of a certain feature, whether the new feature was the main factor responsible for the sales increase is hard to prove.

However, the way in which features are released to application users can help to assess the validity of a hypothesis:

- Controlled deployments with *feature flags*, *feature rings*, and *canary deployments* allow you to release a feature to a limited set of users to prevent disrupting the experience of the whole customer base. Additionally, you can directly compare the performance of the customers with and without the feature to each other.
- *Portal options* for users to decide if they want to be exposed to new functionality puts the users in control of their own experience. The fact that many users opt for a new feature might already be a confirmation that the previous functionality had room for improvement. If customers that had opted for the new feature go back to the previous experience, that might be an indicator that the deployed MVP is missing the mark.
- *Customer surveys* are a powerful feedback mechanism, if they're implemented correctly. Customers will provide information about their satisfaction if it's simple to give. One-click "traffic light" satisfaction surveys or single questions about new functionality might provide insights to help in evaluating whether the innovation hypothesis was correct. In general, only a few users will answer longer surveys and will take the time to fill them in thoroughly and truthfully.

## Understanding your application

[Azure Application Insights](/azure/azure-monitor/app/app-insights-overview?azure-portal=true) is an application performance management (APM) platform with a rich set of tools to gather application telemetry for multiple purposes, such as performance monitoring, problem troubleshooting, or understanding how users move through applications. The last item is critical for the innovation lifecycle, because it can be used to validate an innovation hypothesis and to judge whether a certain innovation is improving the customer experience.

### Detect problems before users do

A crucial element that affects the user experience is the performance and availability of an application. If an application is not working correctly and running into errors, or if it's not responsive enough, some users will abandon it out of frustration. Your organization might lose business. Those frustrated users might also damage your organization's reputation if they share their experience on social media.

Detecting those problematic situations before they affect users is of the highest importance. To meet that goal, you need to proactively monitor the application and start working on potential problems before they affect the business. For example, you can enable notifications to automatically open incidents so that they're investigated before customers report them.

[Smart Detection](/azure/azure-monitor/app/proactive-failure-diagnostics?azure-portal=true) is a useful feature of Azure Application Insights. It can raise alerts when the application behavior is unusual. It detects anomalies by using machine learning, and the alerts are richer than traditional error notifications.  

Notifications typically report that there might be a problem, without context about the potential business impact. Smart Detection alerts include information like the number of affected users, the pattern associated with the failures, or the failure rate compared to normal behavior. You can then focus on the most critical issue from a business perspective.

### Monitor user activity

[Usage analysis](/azure/azure-monitor/app/usage-overview?azure-portal=true) in Azure Application Insights can help you evaluate which application areas need to be improved. For example, usage analysis can identify the most popular application features or specific points at which users leave the web portal. You can explore, for example, whether your application works better in certain geographic areas than others, to get valuable information about where the application gaps might be.

After you formulate a hypothesis with the data provided by Azure Application Insights, you can analyze telemetry to measure whether the situation is now better or worse. Custom business events can be embedded in the application so that telemetry data contains additional information that will help in the measure process.

[Funnels](/azure/azure-monitor/app/usage-funnels?azure-portal=true) can be an insightful tool. With funnels, you can predefine expected *flows* that users will follow when they use the application. This allows you to monitor which patterns users follow. You can then identify problems in the applications if users are behaving in unexpected ways.

### Retain users

The Application Insights [retention tool](/azure/azure-monitor/app/usage-retention#the-retention-tool?azure-portal=true) offers specific functionality around user churn. Combined with business events, it contains valuable learning data. For example, understanding which actions were taken by customers who left the application unexpectedly will allow you to formulate hypotheses with maximum business impact.

For example, if most users who abandoned your website did so from the payment method page, you would suspect a business problem there. Maybe the payment options are insufficient or not clearly displayed. Or another problem is preventing users from moving forward in their shopping process.

### Impact analysis

[Impact analysis](/azure/azure-monitor/app/usage-impact?azure-portal=true) is a feature in Azure Application Insights that correlates technical aspects of the application to tangible business metrics.

For example, how fast should the product page load so that most users continue with their shopping process? With impact analysis, you can show the relationship between page load time and the rate of users who purchase the product shown. This information can help you to validate or reject an innovation hypothesis, and to convert business requirements into technical specifications.

## Summary

Tailwind Traders decided to introduce some new features in its e-commerce application, such as a new payment platform. The application has been instrumented with Azure Application Insights to understand how many customers are using the new payment method, and whether there's an increase of conversion rate in the payment process. The new payment method was marked as a preview, so that users would be more understanding if there were problems.

Application Insights helped Tailwind Traders to identify that a high percentage of users decided to pick up the new payment method in spite of the "preview" banner. Application Insights confirmed that the new functionality worked as expected without major flaws. Additionally, the purchase conversion rate increased significantly.

Tailwind Traders can now focus on turning the MVP for the new payment method into a production-grade feature. The company can move to the learn phase of the innovation lifecycle, to formulate more hypotheses.