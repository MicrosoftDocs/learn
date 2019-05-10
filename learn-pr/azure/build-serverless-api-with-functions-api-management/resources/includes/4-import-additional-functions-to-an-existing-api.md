
Within an Microservices architecture client applications need to interact with multiple services if the clients talk to the microservices directly via mechanisms such as HTTP-based REST. Usually referred as direct client-to-microservice communication, this approach will produce considerable problems and as such it deosn't make sense for clients to talk to microservices directly.

Some of the main reasons to manage external API communication in microservices-based architectures are

- Client applications are coupled to internal microservices and becomes a problem when you wish to split, merge, or rewrite microservices
- APIs are not surfaced under the same domain or IP address
- Common API rules cannot be easily applied across microservices
- Managing API changes and introducing new versions is difficult

To overcome these problems an API Gateway (API Management) can be implemented as a single entry point for all clients that addresses the issues faced in direct client to microservice communication

## How does API Management help?

- API Management abstracts APIs from their implementation and hosts them under the same domain or a static IP address
- Using API Management secures APIs by aggregating them in Azure API Management, and not exposing your microservices directly
- With API Management you can also execute rules on APIs
- API Management simplifies changing APIs
- You can also monitor APIs when using API Management
- API Management makes it easy to publish APIs to external developers

  Azure API Management supports importing Azure Function Apps as new APIs or appending them to existing APIs. The process automatically generates a host key in the Azure Function App, which is then assigned to a named value in Azure API Management.
