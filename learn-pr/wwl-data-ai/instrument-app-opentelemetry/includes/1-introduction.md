AI applications built on distributed architectures require end-to-end visibility into request flows to maintain performance and reliability. This module guides you through instrumenting applications with OpenTelemetry on Azure to capture distributed traces, diagnose latency issues, and gain deep observability into AI solution components.

Imagine you're a developer building a retrieval-augmented generation (RAG) pipeline for a customer support AI application. The system consists of four microservices: an API gateway that receives user queries, an embedding service that converts text into vector representations, a vector search service that retrieves relevant documents, and an LLM orchestration service that generates responses. Users report intermittent slow responses, but your team can't pinpoint which service causes the delays. Some requests complete in under two seconds, while others take over ten seconds. Without visibility into how a single request flows through all four services, debugging requires manually correlating logs across separate outputs. Each service writes its own log format to its own destination, making it difficult to reconstruct the full path of any given request. Your client expects 95th-percentile response times under three seconds and needs a dashboard showing real-time service health. OpenTelemetry provides the standardized instrumentation framework to capture traces across all services and export them to Azure Monitor for unified analysis and visualization.

After completing this module, you'll be able to:

- Explain how OpenTelemetry provides vendor-neutral observability for distributed AI applications on Azure.
- Add and configure the Azure Monitor OpenTelemetry Distro in an application to collect telemetry data.
- Create and manage custom spans and traces to capture request flows across distributed services.
- Export telemetry data to Azure Monitor Application Insights for analysis and visualization.
- Use trace data in Application Insights to identify and debug performance issues in distributed workflows.

> [!NOTE]
> All code examples in this module are based on the most recent version of the `azure-monitor-opentelemetry` package at the time of writing. The package is updated often and the recommendation is to visit the [Azure Monitor OpenTelemetry documentation](/azure/azure-monitor/app/opentelemetry-enable) for the most up-to-date information.
