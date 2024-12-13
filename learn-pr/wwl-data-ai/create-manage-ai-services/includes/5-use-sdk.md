
You can develop an application that uses Azure AI services using REST interfaces, but it's easier to build more complex solutions by using native libraries for the programming language in which you're developing the application.

:::image type="content" source="../media/sdk.png" alt-text="A diagram of an app submitting a call to an Azure AI services resource through a language-specific SDK, which abstracts the JSON request and response." border="false":::

Software development kits (SDKs) for common programming languages abstract the REST interfaces for most AI services. SDK availability varies by individual AI services, but for most services there's an SDK for languages such as:

- Microsoft C# (.NET Core)
- Python
- JavaScript (Node.js)
- Go
- Java

Each SDK includes packages that you can install in order to use service-specific libraries in your code, and online documentation to help you determine the appropriate classes, methods, and parameters used to work with the service.
