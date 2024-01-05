When you sign in to your Permissions Management dashboard, you see a high-level snapshot of insights that can help you determine which areas of your cloud environment need attention.  

:::image type="content" source="../media/dashboard.png" alt-text="Screenshot of the Permissions Management dashboard."lightbox="../media/dashboard.png":::

The information shown in the dashboard zeros in on an authorization system’s Permissions Creep Index (PCI). The Permissions Creep Index is a qualitative measure of risk that compares an identity’s permissions granted vs. permissions used and the identities’ access to high-risk resources.

The top portion of the dashboard is composed of the Permission Creep Index (PCI) Heat Map and the Highest PCI Change list view. These sections are designed to deliver a quick glance into the status of your cloud environment.

### Highest PCI change list view

The Highest PCI Change list view shows all authorization systems that are configured with Permissions Management for the selected cloud environment. The list displays the current PCI score for each authorization system, and the PCI score change over the past seven days. The higher the PCI score, the more at risk your cloud environment is.

This information helps you track progress surrounding permissions creep over time and gives you insight into whether the actions you implement to further secure your environment are helping to lower PCI scores. By viewing the list, you can quickly determine which authorization systems need further attention.

Data shown in the Highest PCI Change list view is exportable, making it useful for reporting purposes. Selecting the download icon associated with the list gives you the option to download a CSV file that contains the PCI history of your authorization systems.

### Permissions Creep Index heat map

The Permissions Creep Index (PCI) Heat Map delivers a visual snapshot of the health of the selected cloud environment. Each bubble on the PCI Heat Map represents a different authorization system in the environment. For example, if you select Azure as the cloud environment and have three subscriptions configured to Permissions Management, then the PCI Heat Map displays three bubbles. 

When viewing the heat map, you see three main areas of data that show helpful insight into your environment: 
- Bubble Position 
    - The x-axis of the bubble chart is the Permission Creep Index (PCI). The PCI score ranges from 0 to 100 and is calculated based on two main factors: the permissions gap of an identity (permissions gap = permissions granted – permissions used), and the types of permissions that an identity has (high-risk permissions, such as having the ability to modify or delete information, are more heavily weighted). A higher PCI score equals greater risk to the environment. Ideally, you want to see heat map bubbles more toward the left side of the map and away from the red zone. 
    - The y-axis of the map represents the number of identities contributing to the PCI score for the selected authorization system. The more identities that are under a single authorization system, the higher on the y-axis the bubble appears.
- Bubble Size
    - The size of the bubbles on the heat map are determined from the number of identities in the authorization system that are classified as being high risk. Ideally, you want to see smaller sized bubbles, as this indicates a lower number of high-risk identities in the environment.
- Number within each bubble
    - The number within each bubble is the number of identities that are actively contributing to that authorization system’s PCI score. 

:::image type="content" source="../media/bubble-data.png" alt-text="Screenshot showing a closer look at the Permissions Management PCI bubble information."lightbox="../media/bubble-data.png":::

Each bubble on the heat map is fully interactive. Hovering over a bubble displays a pop-up information that gives you a breakdown of the identities contributing to that authorization system’s PCI score. The information tells you how many total identities are actively contributing to the PCI score and autoclassifies each one as either high, medium, or low risk. 

An identity is classified as high risk if it has a PCI score between 67 and 100, medium risk if it has a PCI score between 34 and 66, and low risk if it has a PCI score of 0 to 33. 

**Microsoft Azure**
:::image type="content" source="../media/permissions-creep-index-score-azure.png" alt-text="Screenshot showing a closer look at the Permissions Management PCI score information in a Microsoft Azure environment."lightbox="../media/permissions-creep-index-score-azure.png":::

**Amazon Web Service (AWS)**
:::image type="content" source="../media/permissions-creep-index-score-aws.png" alt-text="Screenshot showing a closer look at the Permissions Management PCI score information in an Amazon Web Services (AWS) environment."lightbox="../media/permissions-creep-index-score-aws.png":::

**Google Cloud Platform (GCP)**
:::image type="content" source="../media/permissions-creep-index-score-gcp.png" alt-text="screenshot showing closer look at the Permissions Management PCI score information in a Google Cloud Platform environment."lightbox="../media/permissions-creep-index-score-gcp.png":::

Clicking on a bubble within the heat map provides a more detailed view of that specific authorization system. Here you can see the full breakdown of the high, medium, and low risk users, applications, and managed identities for each authorization system type. A PCI trend chart is also visible – showing you how the PCI for the selected authorization system has changed over time.

To take a deeper look at any of your users, applications, or managed identities – to see exactly which identities are classified as high, medium, and low risk – you can drill down into each section. By selecting the total count (ex: Total Users), you're taken to the Analytics tab.  Here, you see detailed information about each of your selected identity types.

We take a closer look at the Analytics tab later on, but before we do that, let’s briefly return to the dashboard.

### Findings

:::image type="content" source="../media/findings-snapshot.png" alt-text="Screenshot showing a snapshot of Permissions Management findings for identities."lightbox="../media/findings-snapshot.png":::

Permissions Management automatically analyzes your environment and calls out a set of key findings for you to consider. These findings are found at the bottom portion of the dashboard and include insights related to both your identities and your resources.

Every finding included in the dashboard is tied to the Permissions Analytics Report, which we explain later, and provides the ability to drill down and view more detailed information. For example, in the previous screenshot, we see that we have 199 inactive users in the environment. Selecting this finding takes us to the Inactive Users section of the Permissions Analytics Report, where we can view more detailed information about who the 199 inactive users are.

:::image type="content" source="../media/inactive-identities-snapshot.png" alt-text="Screenshot showing a snapshot of Permissions Management Inactive Identities."lightbox="../media/inactive-identities-snapshot.png":::

Using the information provided on the dashboard is a great way to quickly discover permissions risks and get started with using Permissions Management to streamline and secure your cloud environments. 