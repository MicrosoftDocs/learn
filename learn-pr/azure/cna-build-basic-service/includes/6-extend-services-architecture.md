With the Express.js-based app configured to provide access to a PostgreSQL database through REST API routes, you're ready to implement a frontend Next.js web app that delivers management capabilities. While it's possible to build the frontend interface by using Express.js, you decided to follow the services-based architecture and separate the implementation of the frontend and backend functionality.

> [!NOTE]
> Similarly, you could use Next.js to implement REST API routes.

> [!NOTE]
> Next.js is an open-source frontend development web framework that includes support for server-side rendering.

## How to extend the services architecture

Applications tend to become increasingly complex, as their number of features increase in response to demands for rapid responsiveness, innovative features, and zero downtime. Cloud-native applications facilitate the development and implementation of these features through separation between their loosely coupled components.

In your case, the Express.js app exposes a REST API that provides the ability to add inventory data to a PostgreSQL database. To observe the data and perform data-management tasks, you intend to use a Next.js app. This is an example of a CQRS-based approach.

CQRS separates the models for reading and writing data. This process involves dividing a system's operations into two separate categories:

- Commands that change the state of a system.
- Queries that only return results, without affecting the state of the system.

In some cases, CQRS extends beyond the separation of operations and includes distinct physical data stores for reads and writes, with replication keeping them in sync.

> [!NOTE]
> In more complex scenarios, CQRS systems might implement Event Sourcing for updates, which store events only, rather than actual data.

Each of the two services you'll use to implement this pattern has its own data model that corresponds to the actual data in the target database. Because of their separation, services benefit from the capabilities associated with the cloud-native application components, including independent scaling, increased level of resiliency, and support for updates without needing to rearchitect the entire application.
