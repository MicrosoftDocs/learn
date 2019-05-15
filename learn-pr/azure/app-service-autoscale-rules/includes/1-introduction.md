Autoscaling enables a system to adjust the resources required to meet the varying demand from users, while controlling the costs associated with these resources. You can use autoscaling with many Azure services, including web applications. Autoscaling requires you to configure autoscale rules that specify the conditions under which resources should be added or removed.

Imagine that you work for a large chain of hotels. You have a web site that customers can visit to make bookings, and retrieve the details of bookings that they have previously made.

When special events occur, such as a concert or sports event, hotels near the venue can experience short-term spikes in booking requests. Similar events can occur with minimal notice, making it difficult to plan in advance for the potential increase in traffic. The unpredictability of these events means manual scaling isn't an option, and it could be prohibitively expensive to keep website resources available on standby for such an eventuality.

The hotel reservation system must provide a timely response back to users, even during periods of excessive demand. You also need to keep running costs down during more quiescent periods.

This module shows you how to use autoscaling with App Service to scale a web app to meet demand at peak times.

## Learning objectives

In this module, you will:

- Identify scenarios for which autoscaling is an appropriate solution
- Create autoscaling rules for a web app
- Monitor the effects of autoscaling

## Prerequisites

- Experience using the Azure portal to create and manage App Service web apps
- Basic familiarity with manually scaling an App Service
