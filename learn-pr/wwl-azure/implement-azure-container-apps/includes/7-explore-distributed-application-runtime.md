


The Distributed Application Runtime (Dapr) is a set of incrementally adoptable features that simplify the authoring of distributed, microservice-based applications. Dapr provides capabilities for enabling application intercommunication through messaging via pub/sub or reliable and secure service-to-service calls.

Dapr is an open source, [Cloud Native Computing Foundation (CNCF)](https://www.cncf.io/projects/dapr/) project. The CNCF is part of the Linux Foundation and provides support, oversight, and direction for fast-growing, cloud native projects. As an alternative to deploying and managing the Dapr OSS project yourself, the Container Apps platform:

* Provides a managed and supported Dapr integration
* Handles Dapr version upgrades seamlessly
* Exposes a simplified Dapr interaction model to increase developer productivity

## Dapr APIs

:::image type="content" source="../media/azure-container-apps-distributed-application-runtime-building-blocks.png" alt-text="Decorative":::

| Dapr API | Description |
|--|--|
| [Service-to-service invocation](https://docs.dapr.io/developing-applications/building-blocks/service-invocation/service-invocation-overview/) | Discover services and perform reliable, direct service-to-service calls with automatic mTLS authentication and encryption. |
| [State management](https://docs.dapr.io/developing-applications/building-blocks/state-management/state-management-overview/) | Provides state management capabilities for transactions and CRUD operations. |
| [Pub/sub](https://docs.dapr.io/developing-applications/building-blocks/pubsub/pubsub-overview) | Allows publisher and subscriber container apps to intercommunicate via an intermediary message broker. |
| [Bindings](https://docs.dapr.io/developing-applications/building-blocks/bindings/bindings-overview/) | Trigger your applications based on events |
| [Actors](https://docs.dapr.io/developing-applications/building-blocks/actors/actors-overview/) | Dapr actors are message-driven, single-threaded, units of work designed to quickly scale. For example, in burst-heavy workload situations. |
| [Observability](/azure/container-apps/observability) | Send tracing information to an Application Insights backend. |
| [Secrets](https://docs.dapr.io/developing-applications/building-blocks/secrets/secrets-overview/) | Access secrets from your application code or reference secure values in your Dapr components. |
 
> [!NOTE]
> The table covers stable Dapr APIs. To learn more about using alpha APIs and features, [visit limitations](/azure/container-apps/dapr-overview?tabs=bicep1%2Cyaml#unsupported-dapr-capabilities).

## Dapr core concepts 

The following example based on the Pub/sub API is used to illustrate core concepts related to Dapr in Azure Container Apps.

:::image type="content" source="../media/distributed-application-runtime-container-apps.png" alt-text="Diagram that shows the Dapr pub/sub A P I and how it works in Container Apps.":::

| Label | Dapr settings | Description |
|--|--|--|
| 1 | Container Apps with Dapr enabled | Dapr is enabled at the container app level by configuring a set of Dapr arguments. These values apply to all revisions of a given container app when running in multiple revisions mode. |
| 2 | Dapr | The fully managed Dapr APIs are exposed to each container app through a Dapr sidecar. The Dapr APIs can be invoked from your container app via HTTP or gRPC. The Dapr sidecar runs on HTTP port 3500 and gRPC port 50001. |
| 3 | Dapr component configuration | Dapr uses a modular design where functionality is delivered as a component. Dapr components can be shared across multiple container apps. The Dapr app identifiers provided in the scopes array dictate which dapr-enabled container apps load a given component at runtime. |

## Dapr enablement

You can configure Dapr using various [arguments and annotations](https://docs.dapr.io/reference/arguments-annotations-overview/) based on the runtime context. Azure Container Apps provides three channels through which you can configure Dapr:

* Container Apps CLI
* Infrastructure as Code (IaC) templates, as in Bicep or Azure Resource Manager (ARM) templates
* The Azure portal

## Dapr components and scopes

Dapr uses a modular design where functionality is delivered as a component. The use of Dapr components is optional and dictated exclusively by the needs of your application.

Dapr components in container apps are environment-level resources that:

* Can provide a pluggable abstraction model for connecting to supporting external services.
* Can be shared across container apps or scoped to specific container apps.
* Can use Dapr secrets to securely retrieve configuration metadata.

By default, all Dapr-enabled container apps within the same environment load the full set of deployed components. To ensure components are loaded at runtime by only the appropriate container apps, application scopes should be used.
