::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=332f3133-6ba7-4331-853c-6ed0c9d5a88d]

::: zone-end

::: zone pivot="text"

Northwind Health's clinical agents need reliable access to specialized tools—drug interaction lookup, lab value reference, clinical guideline retrieval, and appointment scheduling. You might already have experience connecting agents to pre-built tools through Microsoft Foundry Agent Service using Model Context Protocol (MCP) servers. In this module, you shift from consumption to creation: building production-grade MCP servers that meet enterprise reliability requirements.

Production clinical agents depend on two components working together. A reasoning layer handles multi-step clinical queries, defends against injection attacks, and maintains stable behavior—it decides *what* to do. The tool layer you build here provides the external capabilities that execute those decisions through function calling. When the reasoning layer determines that a drug interaction check is needed, it's the MCP tools you build here that execute that check.

Production clinical tools demand more than basic function wrapping. They need managed identity authentication to meet healthcare compliance standards, sub-500ms latency guarantees, retry logic with circuit breakers to handle downstream failures gracefully, and semantic versioning to ensure tool updates don't break deployed agents. This module teaches you to design, implement, and govern these enterprise-grade tool ecosystems.

Here, you design production MCP server architectures with hosting options and authentication patterns, implement reliability features including retry with exponential backoff and circuit breakers, build dynamic tool routing that selects instances based on health and latency metrics, and establish governance workflows for tool versioning and lifecycle management. By the end, you deploy a clinical tool MCP server with managed identity, circuit-breaker fallback, health-based routing, and a semantic versioning policy—ready for Northwind Health's production agent workloads.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
