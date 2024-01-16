So how does it work? Let’s look at the high-level steps that Contoso will take when using Azure Orbital Ground Station.

## Azure Orbital Ground Station architecture

With Azure Orbital Ground Station, earth observation data is transferred to the cloud, where it can be processed then analyzed. Contoso’s customers then gain insights from space data with Azure’s advanced artificial intelligence (AI) and machine learning (ML) capabilities.

The following steps show how Contoso can use Azure Orbital Ground Station to command, control, and downlink. Here are the steps:

1. Contoso operates a satellite via Azure Orbital Ground Station.
1. Contoso downlinks data to a ground station provided by Microsoft or our partners.
1. Contoso transfers data to the Azure cloud via Azure networking.
1. Contoso processes data to make it into an analysis-ready dataset. Then, Contoso can provide insights to their end customer through AI and ML capabilities.

:::image type="content" source="../media/orbital-eos-diagram.png" alt-text="Diagram of how Azure Orbital Ground Station works.":::

The Azure Orbital portal is extremely user friendly, and in the following units, we’ll show you how to use Azure Orbital to execute these actions.

However, rather than using the Azure Orbital portal, Contoso wants to manage the preceding steps from their own mission-planning application to minimize the number of new platforms that their team needs to learn. Contoso can use Azure REST APIs to write their own scripts to command, control, and downlink using Azure Orbital Ground Station from their own app.

In the next units, we’ll use the example of NASA’s publicly available satellite AQUA to register a spacecraft, create a contact profile, schedule a contact, and downlink data within the Azure Orbital portal.
