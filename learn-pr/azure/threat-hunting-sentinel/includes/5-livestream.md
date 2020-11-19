You can use the hunting livestream to test queries against live events, as they occur. Livestream provides interactive sessions that can notify you when matching events for your query are found.

A livestream is always based on a query. Typically, the query is used to narrow down streaming log events, so you see<!-- See is a non-accessibility sight word. Please replace. --> only the events that are related to your threat hunting efforts. You can use a livestream to:

- Test new queries against live events.
- Generate notifications for threats.
- Launch investigations.

## Create a livestream


To create a livestream from the **Hunting** page in Azure Sentinel, select the **Livestream** tab and then select **New livestream** from the toolbar.  

:::image type="content" source="../media/5-new-livestream.png" alt-text="The Livestream creation page in Azure Sentinel" :::

## View a livestream

On the new **Livestream** page, specify a name for the livestream session and the query that will provide results for the session.

## Manage a livestream

You can play the livestream to view<!-- "view" is a sight word. Other options might be observe, can observe, review, refer to, notice, note, access. Please search for this term and replace. --> results or save the livestream for later reference. Saved livestreams can be viewed from the **Livestream** tab on the **Hunting** page. You can also elevate a livestream session to an alert by selecting **Elevate to alert** from the command bar of any livestream.

:::image type="content" source="../media/4-livestream-session.png" alt-text="A livestream session in Azure Sentinel" :::<!-- This image is not present in the media folder. Are we referring to the "5-new-livestream.png" image?  -->

<!-- Jason: This unit also seems light. Do you think it adequately covers the topics from the design doc? (Which are: Add events to livestream, View livestream sessions, Manage livestream events and alerts). If so, consider adding: images, tables, lists, Contoso examples, analogies. If not, maybe cover one of the missing topics in greater depth. --> 
