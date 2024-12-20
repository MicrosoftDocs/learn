Microservices architectures can be difficult to manage. For example, you might rely on separate teams implementing cross-cutting requirements, such as security, in a consistent way.

In the online store, your developer teams built the product details and order details microservices at different host URLs. Also the order details service responds by using XML. You want to ensure that all responses are in JSON format to make things easier for the client app developers.

In this unit, you learn about the features of API Management. You can use these features to integrate different microservices and present them to client applications with consistent behavior at a single URL.

## Microservices architecture challenges

The microservices approach to architecture creates a modular application in which each part is loosely coupled to the others. Independent deployment of services reduces the effect of any bugs that might make it through testing into production. This modular approach makes it easier to roll back to a stable version. Also, you can create small, autonomous teams of developers for each microservice. This division fits well with modern Agile practices.

However, microservices architectures can also present challenges, such as:

- Client apps are coupled to microservices. If you want to change the location or definition of the microservice, you might have to reconfigure or update the client app.
- Each microservice can be presented under different domain names or IP addresses. This presentation can give an impression of inconsistency to users and can negatively affect your branding.
- It can be difficult to enforce consistent API rules and standards across all microservices. For example, one team might prefer to respond with XML and another might prefer JSON.
- You're reliant on individual teams to implement security in their microservice correctly. It's difficult to impose these requirements centrally.

## How does API Management help?

By adding multiple APIs, functions, and other services to API Management, you can assemble those components into an integrated product that presents a single entry point to client applications. Composing an API using API Management has advantages that include:

- Client apps are coupled to the API expressing business logic, not the underlying technical implementation with individual microservices. You can change the location and definition of the services without necessarily reconfiguring or updating the client apps.
- API Management acts as an intermediary. It forwards requests to the right microservice regardless of location and returns responses to users. Users never see the different URIs where microservices are hosted.
- You can use API Management policies to enforce consistent rules on all microservices in the product. For example, you can transform all XML responses into JSON, if that is your preferred format.
- Policies also enable you to enforce consistent security requirements.

API Management also includes helpful tools - you can test each microservice and its operations to ensure that they behave in accordance with your requirements. You can also monitor the behavior and performance of deployed services.

Azure API Management supports importing Azure Function Apps as new APIs or appending them to existing APIs. The process automatically generates a host key in the Azure Function App, which is then assigned to a named value in Azure API Management.

In the next unit, you'll add the order details microservice to the Online Store API that you created in the preceding exercise. By doing that, you integrate order details with the product details microservice and present them both in the same domain as part of an integrated API.
