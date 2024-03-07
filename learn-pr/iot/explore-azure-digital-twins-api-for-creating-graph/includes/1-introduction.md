Use the Azure Digital Twins APIs to create models, twins, and relationships, gather information about the elements you've created, query the graph, and add endpoints and event routes.

Imagine you're tasked with designing a digital solution to help monitor a city's energy grid, including different types of plants, consumers, power lines, receivers, and substations. As the first step of this solution, you've chosen to set up Azure Digital Twins as an organized hub to receive and contextualize data from IoT devices across the city. You need to create the digital twin mappings for your city's energy environment and prepare the graph for IoT data to propagate through it.

In this module, you work with the Azure Digital Twins APIs in the Postman API platform. You craft API requests to import models, twins, and relationships into your ADT instance so that it represents the real-world energy grid. You explore how to update and query these entities to reflect a changing environment. You also use the APIs to create an endpoint and an event route, in preparation for setting up a live data flow (the finished live data flow involves multiple Azure services and is outside the scope of this module).

By the end of this module, you'll be able to set up Postman to manage Azure Digital Twins API requests, identify key actions that can be performed with the APIs, and construct API requests for Azure Digital Twins import jobs, models, twins, queries, endpoints, and event routes.

## Resources needed for hands-on exercises

This module includes hands-on exercises. To complete all the exercises, you'll need the following resources:
* An Azure subscription. If you don't have one, you can [create one for free now](https://azure.microsoft.com/free).
    - In your account, you'll also need subscription-level permission to manage access to Azure resources (such as the *Owner* role). If you don't have this permission, you'll need cooperation of someone that does have that permission and can run some commands on your behalf.

As part of the module, you'll be asked to create a [Postman](https://web.postman.co/) account.