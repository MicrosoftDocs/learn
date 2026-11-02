::: zone pivot="video"

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=4e268feb-a2ea-40d3-80fa-da561f3a14d5]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Web IQ retrieves web information in a form that agents can use as context. It builds on Bing's global web index and returns structured results with source information, rather than requiring you to build and maintain your own web crawling and extraction pipeline.

For example, a music assistant can discover an artist's tour page, read the page to check dates, find recent announcements, and locate images or videos. Different questions need different retrieval methods.

> [!TIP]
> Foundry's standard **Web search** tool already provides current web grounding with citations and is a straightforward option for general web questions. Choose **Web IQ** when you need more explicit control over retrieval: dedicated news, image, and video searches; Browse for reading a known URL; and configurable result counts, content formats, and content lengths. Its query-relevant passages help limit unrelated context and can reduce token usage. You can also reuse Web IQ through REST, SDKs, and MCP across different agents and applications. These capabilities require a separate Web IQ resource and connection; they don't guarantee better answers for every query.

## Choose a Web IQ method

Web IQ provides the following methods:

| Method | Purpose | Example use |
|---|---|---|
| **Web Search** | Discover and rank relevant web pages for a query, returning query-relevant content and source URLs. | Find official tour announcements for a band. |
| **News** | Search news articles for reporting relevant to a query. | Find coverage of a newly announced tour. |
| **Images** | Search for images and return image results with associated metadata and source links. | Find pictures of a band or concert venue. |
| **Videos** | Search for videos and return results with associated metadata and links. | Find an artist's performance videos or interviews. |
| **Browse** | Retrieve content from a specific URL that the application already knows. | Read a tour page discovered by Web Search to check its event details. |
| **Auto** | Return typed evidence and supporting citations across eligible answer types for a query, reducing the need to select individual search methods. | Retrieve evidence about an artist's announcements across web and news results. |

Use **Web Search** when you need to discover sources; use **Browse** when you already have a source URL. A workflow can combine them: search for relevant pages, select a promising result, and browse it for more complete content when permitted.

**Auto** can return evidence from web, news, images, videos, and structured answers such as weather and time zones. You can constrain eligible answer types with a response filter and choose a mode that prioritizes speed or comprehensiveness.

> [!NOTE]
> Auto is currently a beta REST API and requires an AppID enabled for Auto. Don't assume every method is available to every account or exposed through every integration. The documented Web IQ MCP tools are `web`, `news`, `images`, `videos`, and `browse`; the tools visible to a client depend on the account's allowed services.

## Retrieve useful context efficiently

Web IQ supports controls that help tailor retrieval to the task. Depending on the method, you can configure:

- **Query and scope**: Use a precise query and, where supported, site restrictions to focus on relevant sources.
- **Language and region**: Provide market context so results better match the user's needs.
- **Result count and content length**: Limit how much material is returned to balance coverage with the model's context budget.
- **Content format**: Use query-relevant passages for grounding, or supported full-document formats when your account has access.
- **Media filters**: Refine image or video results using supported attributes such as image size or video duration.

For Web Search, query-relevant passages can reduce the amount of unrelated text sent to the model. Full-document access depends on the application's permissions; requesting a different format doesn't bypass those controls.

## Ground answers without assuming certainty

Web IQ supplies evidence, not a guarantee that every source is correct or current. Source titles, URLs, and available timestamps help the agent and user assess the evidence. A crawl timestamp indicates when content was collected; it isn't necessarily the date of the event described.

In the music assistant example, an old tour announcement shouldn't be treated as proof of an upcoming concert. Prefer authoritative sources, check dates, cite supporting pages, and acknowledge missing or conflicting information. Image and video search results also don't grant unrestricted rights to reuse the media.

Web IQ can be called through REST APIs, SDKs, or MCP-compatible clients. Microsoft Foundry agents can use its MCP tools to retrieve web context without implementing a separate search client for each method.

::: zone-end
