In the  **Configuration > General settings** section you can configure some common settings for your app. Some settings require you to scale up to higher pricing tiers.

:::image type="content" source="../media/configure-general-settings.png" alt-text="Screenshot of navigating to Configure > General settings.":::

A list of the currently available settings:

* **Stack settings**: The software stack to run the app, including the language and SDK versions. For Linux apps and custom container apps, you can also set an optional start-up command or file.

    :::image type="content" source="../media/open-general-linux.png" alt-text="Establishing the stack settings that include the programming language.":::

* **Platform settings**: Lets you configure settings for the hosting platform, including:

    * **Platform bitness**: 32-bit or 64-bit. For Windows apps only.

    * **FTP state**: Allow only FTPS or disable FTP altogether.

    * **HTTP version**: Set to **2.0** to enable support for HTTPS/2 protocol.

        > [!NOTE]
        > Most modern browsers support HTTP/2 protocol over TLS only, while non-encrypted traffic continues to use HTTP/1.1. To ensure that client browsers connect to your app with HTTP/2, secure your custom DNS name.

    * **Web sockets**: For ASP.NET SignalR or socket.io, for example.

    * **Always On**: Keeps the app loaded even when there's no traffic. When **Always On** isn't turned on (default), the app is unloaded after 20 minutes without any incoming requests. The unloaded app can cause high latency for new requests because of its warm-up time. When **Always On** is turned on, the front-end load balancer sends a GET request to the application root every five minutes. The continuous ping prevents the app from being unloaded.

        Always On is required for continuous WebJobs or for WebJobs that are triggered using a CRON expression.

    * **ARR affinity**: In a multi-instance deployment, ensure that the client is routed to the same instance for the life of the session. You can set this option to **Off** for stateless applications.

    * **HTTPS Only**: When enabled, all HTTP traffic is redirected to HTTPS.

    * **Minimum TLS version**: Select the minimum TLS encryption version required by your app.

* **Debugging**: Enable remote debugging for ASP.NET, ASP.NET Core, or Node.js apps. This option turns off automatically after 48 hours.

* **Incoming client certificates**: Require client certificates in mutual authentication. TLS mutual authentication is used to restrict access to your app by enabling different types of authentication for it.
