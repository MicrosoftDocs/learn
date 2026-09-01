Reports are the final stage of the lifecycle: what personal data is actually in the environment, how policy detections are trending, and whether the actions you're taking are reducing exposure over time. The [Microsoft Priva portal](https://purview.microsoft.com/priva?azure-portal=true) surfaces reporting in two places. The **Overview** page carries a couple of at-a-glance cards for daily review, and the **Reports** page goes deeper into detection trends, key insights, and classification. For the healthcare team from the scenario, these reports are where they confirm whether overexposed medical histories are decreasing over time and whether cross-region transfers of employee records are trending down after activation.

## Overview page

The **Overview** page has two report cards:

- **Instances of sensitive info types**: The count of unique sensitive information types (SITs) detected across your organization, shown as a circle chart and bar graph. Counts are per unique SIT: a document with three credit card numbers and one Social Security number counts as two unique SITs and four total instances. Use this card to spot which SITs are present in volume before they show up in alerts. Select **Explore Reports** for the detailed view.

   :::image type="content" source="../media/privacy-risk-management-overview-reports.png" alt-text="Screenshot showing the instances of sensitive info types card on the overview page of the Privacy Risk Management page." lightbox="../media/privacy-risk-management-overview-reports.png":::

- **Top locations with sensitivity labels**: The data locations with the most sensitivity-labeled items. Hover over a location for the labeled-item count. Use this card to see where labeled content is concentrated so you can prioritize policy scope. Select **Explore more sensitivity labels** to open Content Explorer for further analysis.

## Reports page

The **Reports** page covers Microsoft 365 and multicloud data (Azure and Amazon S3 are both in preview). Its cards break out under three headings:

### Key insights

- **Content items with the most personal data**: Ranks specific files and messages by how much personal data they contain, along with the owners and data subjects involved. Use this card to figure out which items to remediate first when you're triaging a large backlog. Select **Explore** to open the item list.

   :::image type="content" source="../media/privacy-risk-management-reports-key-insights.png" alt-text="Screenshot showing the content items with the most personal data card on the reports page of the Privacy Risk Management page." lightbox="../media/privacy-risk-management-reports-key-insights.png":::

- **Active alerts over time**: The trend in policy-triggered alerts. Watch this card for volume spikes, which often signal a policy that's too broad, an organizational change, or a real risk pattern worth investigating.

- **Privacy regulations**: Pulls your privacy score from Microsoft Purview Compliance Manager and lists the regulation-specific improvement actions that are still open. Links take you to the guidance for each action.

   :::image type="content" source="../media/privacy-risk-management-reports-privacy-regulations.png" alt-text="Screenshot showing the privacy regulations card on the reports page of the Privacy Risk Management page." lightbox="../media/privacy-risk-management-reports-privacy-regulations.png":::

- **Personal data type instances by region**: In multi-geo environments, a map showing where personal data lives by region. Hover over a region for counts. Use this card to check whether data residency matches what your policies assume.

   :::image type="content" source="../media/privacy-risk-management-reports-regional-data.png" alt-text="Screenshot showing the personal data type instances by region card on the reports page of the Privacy Risk Management page." lightbox="../media/privacy-risk-management-reports-regional-data.png":::

### Policy trends

- **Personal data found in the organization**: Trends in the total personal data detected, filterable by location, data type, and timeframe. Use this card to see whether the volume of personal data in scope is growing or shrinking.

- **Overexposed personal data**: Trends in overexposure across Microsoft 365 and multicloud sources. This card is where you check whether your overexposure policies are moving the baseline down over time.

- **Data transfers detected in the organization**: Trends in transfers between departments or regions, filterable by location, data type, and timeframe. Use this card to spot new transfer patterns your existing policies don't cover.

- **Unused personal data**: Trends in personal data retained but not accessed within Microsoft 365. Use this card to find content that could be deleted or archived to reduce standing risk.

### Classification

- **Top 5 sensitivity labels**: The five most-used sensitivity labels, broken down by location. Use this card to see whether labeling coverage matches your sensitivity taxonomy. Select **Explore more sensitivity labels** for the full view in Content Explorer.

- **Top 5 sensitive information types**: The most common SITs in your environment, broken down by location. Use this card to figure out which SITs to build policies around first. Select **Explore more sensitive info types** for the full view in Content Explorer.

- **Top locations with sensitivity labels**: The sites and mailboxes holding the most labeled content. Use this card to identify where to scope stricter policies.

## From reports back to policies

These reports feed back into the policy configuration. If overexposure counts stay flat while remediation activity is high, the policy conditions are probably too narrow to catch what's actually happening. You're closing individual issues without moving the baseline. In the reverse case, sustained alert spikes without a business reason point to policies pulling in noise. Either way, the loop goes back to the policy in **Test** or **Active** mode to tune.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
