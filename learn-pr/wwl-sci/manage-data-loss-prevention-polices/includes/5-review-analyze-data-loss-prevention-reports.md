On the DLP Policy Matches report page and the DLP Incidents report page you will see a chart and a table displaying information about their respective occurrences. To analyze these DLP reports, you can break down the charts separated by either:

- Affected service

- Enforced action

- Applied policy

Familiarizing yourself with the available filters and options of the DLP reports will help you fine-tune your policies and reduce false positives and overrides.

## Review data loss prevention policy matches

When using the DLP policy matches report, you should use the filters to limit the report to specific policies. This will help you reduce the number of matches displayed and focus on the impact of selected policies in your organization.

:::image type="content" source="../media/policy-matches-report.png" alt-text="Report in Microsoft 365 showing DLP matches" lightbox="../media/policy-matches-report.png":::

Consider a scenario where you created a new policy to protect financial data a few days ago and currently have it set to test mode. You should set the start date in the filter close to the start date of the policy to avoid whitespace in your report from before the policy existed.

1. On the DLP Policy Matches page, in the right corner select **Filter**.

1. Select a Start date close to the creation date of the policy.

1. Under Services, make sure all services selected.

1. Under Policies, select the DLP policy you want to review in the dropdown menu.

1. Under Rules, select all rules and then select **Apply**.

1. To get a better understanding of how and where the policy will affect your users, you can use the dropdown menu at the top to change the breakdown of the chart:

1. Select **Chart breakdown by Services**.

1. In the dropdown menu, select **Chart breakdown by Action**.

1. Select one of the options from the legend to filter the results even more.

1. Use the table to view which rule matched and which sensitive information type is responsible for the match.

1. Switch between the breakdown options and modify the filters to identify peaks in specific services and times that could indicate a need to adjust your policy.

1. For example, a peak in the Exchange service for bank account numbers might indicate a leak, but it could also be the sign of a legitimate business process at odds with your new policy. Before adjusting the policy, you should investigate the situation.

## Review data loss prevention incidents

When using the DLP Incidents report to get a general overview of which items generate many matches you should not limit the report to specific policies. This will allow you to identify items that fall under the scope of multiple policies and see which action is applied in the end.

Using the DLP incidents report you should keep the timeframe broad and drill-down if you identify any peaks at certain times.

:::image type="content" source="../media/january-incidents.png" alt-text="Reports in Microsoft 365 screen example." lightbox="../media/january-incidents.png":::

For example, you created a new set of DLP policies and prioritized them according to your DLP strategy. If you want to see if the priority you chose aligns with the reality of sensitive data in your organization, you should open the DLP incidents report page and follow these steps:

1. In the right corner select **Filter**.

1. Select a Start date and End date.

1. Under Services, make sure all services selected.

1. Select **All policies** in the dropdown menu.

1. Select **apply**.

If you see any high peaks use the start date and end date filters to limit the scope of the information to that peak. Look at the table and identify the items with the highest policy and rule counts to identify items that may be problematic for your policies. By selecting the item in the table, you can gain additional information about which rules and policies match the item. Review those rules and policies to see which actions should have been enforced according to your DLP strategy and verify that the correct actions have been enforced.

The DLP incidents report can not only be used to see items at odds with your policy priority but as a tool to find items that already generate a high volume of matches in general. This information allows you to consider other protective measures for these items in and outside of DLP policies. For example, you identify documents with four times as many policy matches as the next highest match count. Even though the protective action prevents these files from being shared you might consider storing them at a more secure location.

## Review data loss prevention false positives and overrides

The false positives and overrides visible in this DLP report come from your users. You need to work with your users to make sure that they know how to report false positives to ensure the data in this report can be useful.

The report consolidates two different types of information, but they both help you identify the same issues with your policies. Specifically, they allow you to see instances where your users are affected by policies when they don't expect to.

For example, you created a new financial data policy in test mode, a week ago you activated policy tips and allowed overrides of the policy. If you use the reports to tune a new policy to match only when it is supposed to match you should select a start date close shortly before the time you activated policy tips and limit the scope to show you false positives.

1. In the right corner select **Filter**.

1. Select a start date.

1. Under Services, make sure all services selected.

1. Select the financial data policy you want to analyze and select Apply.

1. In the legend of the chart, uncheck **DLP policy override**.

From this view, you can observe all false positive reports of your financial data policy and use it to identify the sensitive information it falsely matched. Reviewing the matching content gives you more information about how to modify the matching policies.

Overrides can help you identify business processes that will be affected by your policy. If you get a high volume of Overrides on a policy, you should review the business process. You need to determine if you can adjust the policy without negatively affecting its protective functions. To do this follow these steps:

1. In the legend of the chart, select **DLP overrides** and uncheck **DLP false positives**.

1. Select an item on the table and review the Justification section of the pop-up.

1. Overrides are not negative. They help with auditing because it holds the user accountable for the override and allows you to review if legitimate reasons require the DLP policy override.

