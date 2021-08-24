Because cloud-native applications don't require a specific technology's selection for their individual components, you can base their implementation details on your preferences. Also, many cloud offerings such as Azure Database for PostgreSQL allow you to use the same open-source versions of technologies that you're familiar with. They also use the underlying platform to minimize administrative overhead that's associated with their usage.

You will leverage these benefits when building your solution. To start, you will implement an Express.js-based web service with REST API routes providing access to the newly deployed PostgreSQL database.

## What are the benefits of modular design?

The modularization principle of the services model provides a high degree of separation between individual services. You can independently upgrade, deploy, scale, and restart each service, without affecting other services' availability or performance. In turn, this promotes the application of DevOps practices to your applications' lifecycles. The result is expedited new feature releases facilitated by small, frequent, and incremental changes.

The loose coupling of services allows you to change the underlying technology without forcing significant code rewrites of the entire application. For example, the Express.js backend service could be containerized and deployed to a Kubernetes cluster, allowing it to scale dynamically based on demand. Another alternative is to  deploy it as a container-based or code-based Azure App Service web app, which also supports autoscaling.

Similarly, you could modify the backend service to connect to a different database of choice, potentially relying on the same set of libraries. Most common object-relational mapper libraries available with Node.js, such as Prisma or Sequelize, support a range of relational database products. These include PostgreSQL, MariaDB, and Microsoft SQL Server.

Another benefit of the modular design is its extensibility. You have the option to add another component, such as a management service accessible with a Next.js web app and containerizing it without significant changes to the existing application.

:::image type="content" source="../media/4-basic-service-sample-architecture.png" alt-text="The high-level architecture of the sample basic service.":::

## How to implement a basic service?

The two architectural patterns that commonly serve as the basis for building and optimizing services are domain-driven design (DDD) and Command and Query Responsibility Segregation (CQRS). These patterns also influence the way cloud-native applications are modeled.

DDD is a software-development approach that focuses on the functionality of the application to define boundaries between services. CQRS is commonly combined with DDD. Its purpose is to replace the traditional create, read, update, and delete (CRUD)-based approach, which relies on a single interface for all data management tasks. Instead, CQRS separates read and update operations for a data store. This provides another layer of isolation that aligns with the premise behind DDD.

Your objective is to modify the existing Express.js-based web service to provide access to a PostgreSQL database. Express.js is an open-source, backend web application framework for Node.js. It simplifies building web applications and APIs. Node.js is a JavaScript runtime engine for building client and server applications. Express.js has a module-based architecture that simplifies implementation of a wide range of tasks. These include traditional web development and accessing databases such as MongoDB and PostgreSQL.

You can use multiple methods to access a PostgreSQL database from Express.js applications. The most popular ways involve using object-relational mapper libraries, which map programmatic constructs into corresponding database schema. This approach facilitates portability, providing an abstraction layer between the actual database objects and their service-based representation.

The methods implemented by the Express.js application are exposed through routes, which define how the application's endpoints respond to client requests. When implementing them, you should consider applying the principles of CQRS, although this might not be applicable to basic services because of increased complexity.
