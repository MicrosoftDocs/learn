When you register a service, you must choose a lifetime that matches how the service is used in the app. The lifetime affects how the service behaves when it's injected into components. So far, you've registered services using the `AddSingleton` method. This method registers a service with a singleton lifetime. There are three built-in lifetimes for services in ASP.NET Core:

- **Singleton**
- **Scoped**
- **Transient**

### Singleton lifetime

Services registered with a singleton lifetime are created once when the app starts and are reused for the lifetime of the app. This lifetime is useful for services that are expensive to create or that don't change often. For example, a service that reads configuration settings from a file can be registered as a singleton.

Use the `AddSingleton` method to add a singleton service to the service container.

### Scoped lifetime

Services registered with a scoped lifetime are created once per configured scope, which ASP.NET Core sets up for each request. A scoped service in ASP.NET Core is typically created when a request is received and disposed of when the request is completed. This lifetime is useful for services that access request-specific data. For example, a service that fetches a customer's data from a database can be registered as a scoped service.

Use the `AddScoped` method to add a scoped service to the service container.

### Transient lifetime

Services registered with a transient lifetime are created each time they're requested. This lifetime is useful for lightweight, stateless services. For example, a service that performs a specialized calculation can be registered as a transient service.

Use the `AddTransient` method to add a transient service to the service container.

## Services that depend on other services

When you register a service that depends on another service, you must take service lifetime into account. If a service with a shorter lifetime is injected into a service with a longer lifetime, the shorter-lived service can't outlive the longer-lived service. For example, a singleton service can't depend on a scoped service because the scoped service is disposed of when the request is completed.
