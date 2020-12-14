---
metadata:
  title: The Scenario
  description: This unit presents the scenario covered in this module
  ms.date: 11/30/2020
  author: raniabayoumy
  ms.author: rabayoum
  ms.topic: interactive-tutorial
  ms.prod: learning-azure
title: The Scenario
durationInMinutes: 3
---

Suppose you work at a chocolate manufacturing factory as technical specialist to support the chocolate factory line operators. To support the staff, you're tasked with launching a new, near real-time dashboard to monitor running operations for the **Roasting**, **Grinding** and **Molding** processes, which will enable the staff to answer questions such as:

- Find all the time windows during which the roasting temperature is greater than 150°F in the previous 24 hours, and trace back events in ADT correlating to these time windows
- Visualize vibration readings in the past ~2 minutes and check if there are unusual spikes or dips to ensure the process meets manufacturing quality standards **(this is the scenario we will focus on for the exercises in this module)**
- Find all incidents with unusually higher than normal molding temperature in the previous 5 days

Also, you may need to gather historical data that can be used for postmortem root-cause analysis when an operation fails, to correct a problem, or to set up a better notification system for such incidents.

:::image type="content" source="../media/adt-chocolate-manufacturing-process.png" alt-text="The main Chocolate Manufacturing Processes in scope: Roasting, Grinding and Molding":::

## Solution Architecture

To visualize and query data, you'll attach Time Series Insights to Azure Digital Twins using the pattern illustrated in the following diagram:

:::image type="content" source="../media/adt-solution-architecture.png" alt-text="A high-level Solution Architecture Diagram":::
