You're a Security Operations Analyst working at a company that deployed both Microsoft Defender XDR and Microsoft Sentinel. You need to prepare for the Unified Security Operations Platform connecting Microsoft Sentinel to Defender XDR.

In this exercise, you perform the following tasks:

- Install the Microsoft Defender XDR Content Hub solution.
- Deploy the Microsoft Sentinel connector to connect Microsoft Sentinel to Microsoft Defender XDR.
- Connect Microsoft Sentinel to Microsoft Defender XDR.
- Explore the Microsoft Sentinel capabilities in the Microsoft Defender XDR portal.

> [!NOTE]
>The environment for this exercise is a simulation generated from the product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script may not be supported. A pop-up message displays stating, "This feature isn't available within the simulation." When this occurs, select OK and continue the exercise steps.
>
>
>:::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Screenshot of pop-up screen indicating that this feature isn't available within the simulation.":::

### Task 1: Connect Defender XDR

In this task, you deploy the Microsoft Defender XDR connector.

1. In the Microsoft Edge browser, open the simulated environment by selecting this link: **[Azure portal]( https://app.highlights.guide/start/1c894b46-4b0a-40cb-b0f0-1e1c86c615f3?token=16d48b6c-eace-4a1f-8050-098d29d23a89)**.

1. In the Search bar of the Azure portal, type *Sentinel*, then select **Microsoft Sentinel**.

1. On the *Microsoft Sentinel* page, select the **Woodgrove-LogAnalyiticWorkspace** Workspace.

1. In the Microsoft Sentinel navigation menu, scroll down to and expand the **Content management** section. Then select **Content Hub**.

1. In the *Content hub*, search for the **Microsoft Defender XDR** solution and select it from the list.

1. On the *Microsoft Defender XDR* solution details page, select **Install**.

1. When the installation completes,  search for the **Microsoft Defender XDR** solution and select it.

1. On the *Microsoft Defender XDR* solution details page, select **Manage**

1. Select the *Microsoft Defender XDR* Data connector check-box, and select **Open connector page**.

1. In the *Configuration* section, under the *Instructions* tab, select the **Connect incidents & alerts** button.

1. You should see a message that the connection was successful.

### Task 2: Connect Microsoft Sentinel and Microsoft Defender XDR

In this task, you continue with the simulation and connect a Microsoft Sentinel workspace to Microsoft Defender XDR.

1. Navigate back to the Microsoft Sentinel *Content Hub* (using the "breadcrumb" menu link at the top of the page), and select **Overview (Preview)** from the navigation menu General section.

1. Select the **Learn more** button on the *Get your SIEM and XDR in one place* message.

    :::image type="content" source="../media/siem-xdr-learn-more.png" alt-text="Screen capture of SIEM and XDR Learn more button message." lightbox="../media/siem-xdr-learn-more.png":::

1. Selecting the **Learn more** button opens a new tab in the browser for the *Microsoft Defender XDR* portal.

1. On the **Defender Defender** portal **Home** screen, you should see a banner at the top with the message, *Get your SIEM and XDR in one place*. Select the **Connect a workspaces** button.

    :::image type="content" source="../media/siem-xdr-connect-workspace.png" alt-text="Screen capture of Defender XDR Connect a workspace button." lightbox="../media/siem-xdr-connect-workspace.png":::

1. On the *Choose a workspace* page, select the **woodgrove-loganalyiticsworkspace** Microsoft Sentinel workspace.

1. Select the **Next** button.

1. On the **Set a primary workspace** page, you should see the **woodgrove-loganalyiticsworkspace** Microsoft Sentinel workspace in the drop-down menu. Select the **Next** button.

1. On the *Review and finish* page, verify that the *Workspace* selection is correct and review the bulleted items under the *What to expect when the workspace is connected* section. Select the **Connect** button.

1. You should see a *You're about to connect a workspace* message. Select the **Connect** button.

1. You should now be on the *Workspace successfully connected* page.

1. Select the **Close** button.

    :::image type="content" source="../media/successfully-connected-close-button.png" alt-text="Screen capture of the Defender XDR workspace successfully connected page." lightbox="../media/successfully-connected-close-button.png":::

1. On the **Defender XDR** portal **Home** screen, you should see a banner at the top with the message, *Your unified SIEM and XDR is ready*. Select the **Start Hunting** button.

1. In *Advanced hunting*, you should see a message to "Explore your content from Microsoft Sentinel". In the *Advanced hunting* navigation menu, you can find the *Microsoft Sentinel* tables, functions, and queries under the corresponding tabs.

1. Scroll down under the **Schema** tab to the **Microsoft Sentinel** heading, and then double-click the **ThreatIntelligenceIndicator** table.

1. In the *Query* pane, you should see a (KQL) query that returns threat intelligence indicators. Select the **Run query** button.

    :::image type="content" source="../media/advanced-hunting-sentinel-query.png" alt-text="Screen capture of Defender XDR Sentinel Advanced hunting tables." lightbox="../media/advanced-hunting-sentinel-query.png":::

1. Expand the left main menu pane if collapsed and  expand the new **Microsoft Sentinel** menu items. You should see *Search*, *Threat management*, *Content management*, and *Configuration* selections.

    > [!NOTE]
    > There are capability differences between the Azure Microsoft Sentinel portal and Sentinel in the Microsoft Defender XDR portal **[Portal capability differences](/azure/sentinel/microsoft-sentinel-defender-portal#capability-differences-between-portals)**.

1. From the Microsoft Defender XDR **Microsoft Sentinel** menu items, then select **Configuration** and then **Data connectors**.

1. In the *Data connectors* page, you should see the **Azure Activity** and other data connectors listed with a status of **Connected**.

> [!NOTE]
> Feel free to explore and compare the other Microsoft Sentinel capabilities, but as this is a simulation, your ability to explore Microsoft Sentinel in the Microsoft Defender portal is limited. In a real environment, you would be able to explore the full Microsoft Sentinel capabilities in the Microsoft Defender portal.
