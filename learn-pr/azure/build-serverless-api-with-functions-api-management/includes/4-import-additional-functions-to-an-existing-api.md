Microservices architectures can be difficult to manage. For example, you rely on each team implementing cross-cutting requirements, such as security, in a consistent way.

<!-- TODO We have two functions - Order Details and Product Details - we don't have order placement or order shipping. Let's align the scenario with the example code in this module. -->
In the online store, your developer teams have built the product details, order placement, and order shipping microservices at different host URLs. Also the order shipping service responds by using XML. You want to ensure that all responses are in JSON format to make things easier for the client app developers.

Here, you will see how API Management can be used to assemble disparate microservices into a consistent product under one domain name and with consistent behavior. <!-- TODO This is an over-commitment for this unit. We don't show any of this assembly or show how it will be done. I would potentially delete everything above this line. -->

## Microservices architecture challenges

The microservices approach to architecture creates a modular application in which each part is loosely coupled to the others. This method makes it easier to implement continuous delivery because new versions of each service can be deployed independently of the others. If bugs are not detected during testing and make it through to production, their impact is reduced and it is easier to roll back to a stable version. Also, you can create small, autonomous teams of developers for each microservice. This division fits well with modern Agile practices.

However, the microservices architecture can also present challenges, such as:

- Client apps are coupled to microservices. If you want to change the location or definition of the microservice, you may have to reconfigure or update the client app.
- Each microservice may be presented under different domain names or IP addresses. This presentation can give an impression of inconsistency to users and can negatively affect your branding.
- It can be difficult to enforce consistent API rules and standards across all microservices. For example, one team may prefer to respond with XML and another may prefer JSON.
- You are reliant on individual teams to implement security in their microservice correctly. It is difficult to impose these requirements centrally.

By using Azure API Management, you can address these issues.

## How does API Management help?

By adding multiple APIs, Functions, and other services to API Management, you can assemble those components into an integrated product that presents a single entry point to client applications. This construction has advantages that include:

- Client apps are coupled to the API Management product, not the individual microservices. You can change the location and definition of the services without necessarily reconfiguring or updating the client apps.
- Client apps always connect to the domain name or IP address of the API Management product. API Management acts as an intermediary. It forwards requests to the right microservice, wherever it is located, and returns responses to users. Users never see the different URIs where microservices are hosted.
- You can use API Management policies to enforce consistent rules on all microservices in the product. For example, you can transform all XML responses into JSON, if that is your preferred format.
- Policies also enable you to enforce consistent security requirements.

API Management also includes helpful tools - you can test each microservice and its operations to ensure that they behave in accordance with your requirements. You can also monitor the behavior and performance of deployed services.

Azure API Management supports importing Azure Function Apps as new APIs or appending them to existing APIs. The process automatically generates a host key in the Azure Function App, which is then assigned to a named value in Azure API Management.

<!-- TODO - Again we drop the student off here without context as to what's going to happen next. -->
