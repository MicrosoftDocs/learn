You want to establish a plan for migrating your existing Spring Petclinic microservices application to Azure.

In this unit, you'll do the following tasks:

 -  Examine the application components based on the information provided in its GitHub repository.
 -  Consider the Azure services most suitable for hosting your application.
 -  Consider the Azure services most suitable for storing data of your application.
 -  Consider resource organization in Azure.
 -  Consider tools for connecting to and managing your Azure environment.

You'll run the initial deployment in the next exercise.

## Functional services

PetClinic is composed into four core Spring apps. All of them are independently deployable applications organized by business domains.

 -  **Customers service:** Contains general user input logic and validation including pets and owners information (Name, Address, City, Telephone).
 -  **Visits service:** Stores and shows visits information for each pet in comments.
 -  **Vets service:** Stores and shows Veterinarians' information, including names and specialties.
 -  **API Gateway:** The API Gateway is a single entry point into the system, used to handle requests and route them to an appropriate service or to invoke multiple services, and aggregate the results. The three core services expose an external API to client. In real-world systems, the number of functions can grow quickly with system complexity. Hundreds of services might be involved in rendering one complex webpage.

The following diagram shows the architecture of the PetClinic application.

:::image type="content" source="../media/microsoft-services-architecture-diagram-10984584.jpg" alt-text="Diagram shows the architecture of the sample application.":::


There are several common patterns in distributed systems that support core services. Azure Spring Apps provides tools that enhance Spring Boot applications to implement the following patterns:

 -  **Config service:** Azure Spring Apps Config is a horizontally scalable centralized configuration service for distributed systems. It uses a pluggable repository that currently supports local storage, Git, and Subversion.
 -  **Service discovery:** It allows automatic detection of network locations for service instances, which could have dynamically assigned addresses because of autoscaling, failures, and upgrades.

## Review the application components

To follow the Azure Spring Apps deployment examples, you need the location of the source code provided. You can review the sample Spring Petclinic application by reviewing the following assets:

 -  From a web browser, navigate to the [lab starter branch of the GitHub repo hosting the Spring Petclinic application code](https://github.com/Azure-Samples/spring-petclinic-microservices/tree/labstarter) and review the README.md file.
 -  In the web browser displaying the GitHub repo, navigate to each folder containing the code of the individual *spring-petclinic-\** services and review the content. You don't need to know their full details, but you should understand their basic structure.
