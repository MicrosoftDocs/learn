---
author: Rodrigo Santos
ms.service: non-product-specific
ms.topic: include
ms.date: 03/01/2021
ms.author: rodsan
---

### What is data-flow?

Data-flow refers to data movement between processes, data stores, and external entities.

### Data-flow context to include

|Context|Questions|
|-------|---------|
|Description|Is the data-flow passing a session token, SQL string, or user credentials? If not, what is it passing?|
|Protocol|Does the flow use HTTPS or SOAP? If not, what does it use?|
|Flow sequence|Is the data-flow enumerated to make it easier to follow the flow sequence?|
|Type|What type of data is in the data-flow? Cookies? XML? SOAP payload? REST payload? JSON payload?|
|Additional controls|Does the data-flow have forgery protection enabled? Other security flags enabled?|
|Authentication|Does the process rely on Azure Active Directory for authentication? If not, what does it rely on?|
|Authorization|Does it rely on Access Control Lists (ACL) for authorization? If not, what does it rely on?|

### Woodgrove data-flow elements

<ul><li>Request and responses between element connections</li></ul>

### Data-flow labeling example

**Data-flow** - 1- HTTPS Request(session token)