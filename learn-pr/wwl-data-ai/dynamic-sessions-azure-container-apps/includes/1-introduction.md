::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=472bf3a9-9abd-4f47-8358-4e7c30d9397b]

::: zone-end

::: zone pivot="text"

AI applications often generate code to analyze data, perform calculations, and create files. This module guides you through using Azure Container Apps dynamic sessions to execute that code in isolated, ephemeral environments without exposing the AI application's process or host.

Imagine you're a developer building an AI-assisted document analysis application. Users upload operational data and ask the application to calculate trends or create visual summaries. A language model can propose Python code for each request, but the code isn't inherently trustworthy. Running the code in the application container could expose credentials, consume shared resources, or affect other users. Each conversation also needs temporary file storage so that several related operations can use the same uploaded data. Your client expects interactive responses without waiting for a new execution environment to start for every request. The application must keep each tenant's files and execution state separate. It must also restrict network access, enforce execution limits, and remove temporary state when work ends. Azure Container Apps dynamic sessions provide prewarmed, Hyper-V-isolated environments for this work. Session identifiers let the backend preserve temporary state across related requests while keeping control of access.

After completing this module, you'll be able to:

- Explain how Azure Container Apps dynamic sessions isolate AI-generated and user-submitted code.
- Choose between a built-in code interpreter and a custom container session pool.
- Configure session capacity, lifecycle, and outbound network access for an AI workload.
- Use session identifiers to execute code and exchange files from application code.
- Handle session expiration, execution limits, timeouts, and failed executions.

> [!NOTE]
> The Python examples in this module use the `azure-identity` and `requests` libraries. The library maintainers update both libraries regularly. For current usage guidance, see the [Azure Identity client library documentation](/python/api/overview/azure/identity-readme) and the [Requests documentation](https://requests.readthedocs.io/).

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
