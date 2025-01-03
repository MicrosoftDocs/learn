Autoscaling enables a system to adjust the resources required to meet the varying demand from users, while controlling the costs associated with these resources. You can use autoscaling with many Azure services, including web applications. Autoscaling requires you to configure autoscale rules that specify the conditions under which resources should be added or removed.

Imagine that you work for a large hotel chain. You have a website where customers can book rooms and retrieve the details of previous bookings they made.

When special events occur, such as a concert or sports event, hotels near the event venue can experience short-term spikes in booking requests. Similar events can occur with minimal notice, making it difficult to plan for potential website traffic increases. The unpredictability of these events means manual scaling isn't an option, and it could be prohibitively expensive to keep website resources available on standby for potential traffic spikes.

The hotel's website reservation system must timely respond to users, even during periods of excessive demand. You also need to keep running costs down during more quiescent periods.

This module shows you how to use autoscaling with Azure App Service to scale a web app to meet demand at peak times.

## Learning objectives

In this module, you will:

- Identify scenarios for which autoscaling is an appropriate solution.
- Create autoscaling rules for a web app.
- Monitor the effects of autoscaling.

## Prerequisites

- Experience using the Azure portal to create and manage App Service web apps
- Basic familiarity with manually scaling an App Service web app
