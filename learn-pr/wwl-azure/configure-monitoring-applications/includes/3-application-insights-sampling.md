
Sampling is a feature in Application Insights that allows you to reduce telemetry traffic, data costs, and storage costs, while preserving a statistically correct analysis of application data. Sampling also helps you avoid Application Insights throttling your telemetry. The sampling filter selects items that are related, so that you can navigate between items when you're doing diagnostic investigations.

In general, for most small and medium size applications you don't need sampling. The most useful diagnostic information and most accurate statistics are obtained by collecting data on all your user activities.

The main advantages of sampling are:

- Application Insights service drops ("throttles") data points when your app sends a high rate of telemetry in a short time interval. Sampling reduces the likelihood that your application sees throttling occur.
- Allows you to keep within the quota of data points for your pricing tier.
- Allows you to reduce network traffic from the collection of telemetry.

## How sampling works

The sampling algorithm decides which telemetry items to drop, and which ones to keep. It is true whether sampling is done by the SDK or in the Application Insights service. The sampling decision is based on several rules that aim to preserve all interrelated data points intact, maintaining a diagnostic experience in Application Insights that is actionable and reliable even with a reduced data set. For example, if your app has a failed request included in a sample, the extra telemetry items (such as exception and traces logged for this request) are retained. Sampling either keeps or drops them all together. As a result, when you look at the request details in Application Insights, you can always see the request along with its associated telemetry items.

The sampling decision is based on the operation ID of the request, which means that all telemetry items belonging to a particular operation are either preserved or dropped. For the telemetry items that don't have an operation ID set (such as telemetry items reported from asynchronous threads with no HTTP context) sampling simply captures a percentage of telemetry items of each type.

When presenting telemetry back to you, the Application Insights service adjusts the metrics by the same sampling percentage that was used at the time of collection, to compensate for the missing data points. So, when looking at the telemetry in Application Insights, the users are seeing statistically correct approximations that are close to the real numbers.

The accuracy of the approximation largely depends on the configured sampling percentage. Also, the accuracy increases for applications that handle a large volume of similar requests from lots of users. On the other hand, for applications that don't work with a significant load, sampling isn't needed as these applications can usually send all their telemetry while staying within the quota, without causing data loss from throttling.

When metric counts are presented in the portal, they're renormalized to take into account sampling. Doing so minimizes any effect on the statistics.

## Sampling types

There are three different sampling methods:

- Adaptive sampling automatically adjusts the volume of telemetry sent from the SDK in your ASP.NET/ASP.NET Core app, and from Azure Functions. This is the default sampling when you use the ASP.NET or ASP.NET Core SDK. Adaptive sampling is currently only available for ASP.NET/ASP.NET Core server-side telemetry, and for Azure Functions.
- Fixed-rate sampling reduces the volume of telemetry sent from both your ASP.NET or ASP.NET Core or Java server and from your users' browsers. You set the rate. The client and server will synchronize their sampling so that, in Search, you can navigate between related page views and requests.
- Ingestion sampling happens at the Application Insights service endpoint. It discards some of the telemetry that arrives from your app, at a sampling rate that you set. It doesn't reduce telemetry traffic sent from your app, but helps you keep within your monthly quota. The main advantage of ingestion sampling is that you can set the sampling rate without redeploying your app. Ingestion sampling works uniformly for all servers and clients, but it doesn't apply when any other types of sampling are in operation.

If adaptive or fixed rate sampling methods are enabled for a telemetry type, ingestion sampling is disabled for that telemetry. However, telemetry types that are excluded from sampling at the SDK level will still be subject to ingestion sampling at the rate set in the portal.