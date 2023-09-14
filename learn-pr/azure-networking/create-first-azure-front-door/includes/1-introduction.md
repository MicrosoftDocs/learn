Azure Front Door allows you to deliver your web application contents to your end users with lower latency, higher availability and provides a more secured experience from anywhere in the world.

## Example scenario

Suppose you're the solution architect for the motor vehicle department of a government organization. The department currently hosts their web applications behind an Application Gateway and would like to migrate to using Front Door as an entry point to their application. An Application Gateway is a resource deployed in a single Azure region and can be prone to a regional outage. The government organization learns about how Front Door can improve performance for their end users and alleviate any fear they may have if a regional outage were to happen.

Since Front Door is a global service, users access the web application at an edge location closest to them. As a result end users see lower latency and a better overall experience while using the application. Backend resources can be strategically deployed around the world where Front Door can access and respond to end user's requests. This set up creates a highly available and scalable web application that isn't prone to a regional outage. Lastly, Front Door provides centralized protection where you can configure policies to detect and prevent exploits and attacks to your web application.

## What will we be doing?

In this module, you create two test web application and configure Azure Front Door to route traffic to these web applications. You then create a Web Application Firewall (WAF) policy and associate it with the Azure Front Door profile to protect your applications from SQL injections and Bot attacks. Lastly, you test routing to each of the origin resources, routing paths configured, and test if WAF is protecting your web application.

## What is the main goal?

By the end of this session, you're able to configure an Azure Front Door profile to improve the delivery of your motor vehicle departments websites. You're also able to protect your backend resources from malicious actors by implementing Web Application Firewall (WAF) policy on your Front Door.

## Prerequisites

* Knowledge of basic networking concepts
* Familiarity with Azure virtual machine and Azure App Service
* Familiarity with Azure virtual network and Azure Load Balancers
* Familiarity with Web Application Firewall (WAF) rules and Azure Private Link service
