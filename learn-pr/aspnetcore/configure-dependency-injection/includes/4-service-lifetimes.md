When you register a service, you must choose a lifetime that matches how the service is used in the app. The lifetime affects how the service behaves when it's injected into components. So far, you've registered services with using the `AddSingleton` method. This method registers a service with a singleton lifetime. There are three built-in lifetimes for services in ASP.NET Core:

- **Singleton**
- **Scoped**
- **Transient**

## Singleton lifetime

Services registered with a singleton lifetime are created once and shared across the app. The service is created when the app starts and is reused for the lifetime of the app. This lifetime is useful for services that are expensive to create or that don't change often. For example, a service that reads configuration settings from a file can be registered as a singleton.

Singleton services are added to the service container using the `AddSingleton` method.

## Scoped lifetime

Services registered with a scoped lifetime are created once per client request (connection). The service is created when a client request is received and is disposed of when the request is completed. This lifetime is useful for services that are stateful or that store client-specific data. For example, a service that fetches data from a database can be registered as a scoped service.

Scoped services are added to the service container using the `AddScoped` method.

## Transient lifetime

Services registered with a transient lifetime are created each time they're requested. The service is created each time it's injected into a component. This lifetime is useful for lightweight, stateless services. For example, a service that generates a random number can be registered as a transient service.

Transient services are added to the service container using the `AddTransient` method.
