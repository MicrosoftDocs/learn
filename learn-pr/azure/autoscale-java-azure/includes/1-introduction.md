## The sample microservice application

In this module, you'll configure a sample Microservice architecture to be ready for autoscaling. Later, you'll view the application autoscaling details and learn how to trigger it to scale.

To start, you'll clone a Git repository and run a script that sets-up Azure Spring Apps microservice applications connecting to an Azure Database for MySQL.

Your Azure Spring Apps is set up with autoscaling to respond to changes in the environment by adding or removing instances and balancing the load between them. Autoscaling doesn't have any effect on the CPU power, memory, or storage capacity of the application instances powering the app. It only changes the number of application instances.

The script deploys a well-known PetClinic microservice application and is built around small independent services, communicating over HTTP via a REST API. The sample is decomposed into four core microservices. All of them are independently deployable, organized by business domains.

- **Customers service**: Contains general user input logic and validation including pets and owners information (Name, Address, City, Telephone).
- **Visits service**: Stores and shows visits information for each pet.
- **Vets service**: Stores and shows Veterinarians' information, including names and specialties.
- **API Gateway**: A single entry point into the system, used to handle requests and route them to an appropriate service, and aggregate the results.

:::image type="content" source="../media/4-petclinic.jpg" alt-text="Screenshot of your Spring Apps application." lightbox="../media/4-petclinic.jpg":::
