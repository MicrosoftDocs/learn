



In the  **Configuration > General settings** section you can configure some common settings for your app. Some settings require you to scale up to higher pricing tiers.

Below is a list of the currently available settings:

* **Stack settings**: The software stack to run the app, including the language and SDK versions. For Linux apps and custom container apps, you can also set an optional start-up command or file.

    :::image type="content" source="../media/open-general-linux.png" alt-text="Establishing the stack settings that include the programming language.":::

* **Platform settings**: Lets you configure settings for the hosting platform, including:

    * **Bitness**: 32-bit or 64-bit.
    * **WebSocket protocol**: For ASP.NET SignalR or socket.io, for example.
    * **Always On**: Keep the app loaded even when there's no traffic. By default, **Always On** isn't enabled and the app is unloaded after 20 minutes without any incoming requests. It's required for continuous WebJobs or for WebJobs that are triggered using a CRON expression.
    * **Managed pipeline version**: The IIS pipeline mode. Set it to **Classic** if you have a legacy app that requires an older version of IIS.
    * **HTTP version**: Set to 2.0 to enable support for HTTPS/2 protocol.

    * **ARR affinity**: In a multi-instance deployment, ensure that the client is routed to the same instance for the life of the session. You can set this option to **Off** for stateless applications.

* **Debugging**: Enable remote debugging for ASP.NET, ASP.NET Core, or Node.js apps. This option turns off automatically after 48 hours.

* **Incoming client certificates**: require client certificates in mutual authentication. TLS mutual authentication is used to restrict access to your app by enabling different types of authentication for it.
