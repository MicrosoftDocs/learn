Configuration of your LUIS containers is done through the docker command argument. There are required settings and optional settings. During the creation of the docker container for your LUIS application, you use some of these command arguments.  For example, the command used to create the docker container in unit 2 was,

```powershell
docker run --rm -it -p 5000:5000 --memory 4g --cpus 2 --mount type=bind,src=c:\input,target=/input
--mount type=bind,src=c:\output\,target=/output
mcr.microsoft.com/azure-cognitive-services/luis
Eula=accept
Billing={ENDPOINT_URI}
ApiKey={API_KEY}
```

In this command, some of the arguments were specific to creating a container that is not LUIS-specific but more generic such as:

- --rm is a docker command that tells the docker engine to remove the container when it exits
- -it For interactive processes (like a shell), you must use -i -t together in order to allocate a tty for the container process. -i -t is often written -it as you’ll see in later examples. Specifying -t is forbidden when the client is receiving its standard input from a pipe
- -p for the port number
- --memory to indicate how much computer memory to allocate to the container
- --cpus to indicate how many CPUs or CPU cores to allocate to the container
- -- mount arguments to indicate where the input and output directories are located.

The remaining arguments are specific to a LUIS container and were the minimum options required to create the LUIS container and have it connect to the LUIS app that was exported.

- EULA=accept - is used to accept the end-user license agreement.  You must specify a value for this argument and it must be set to accept.
- Billing - this argument is used to point to the endpoint URI of the Cognitive Services resource on Azure used to meter billing information for the container. You must specify a value for this configuration setting, and the value must be a valid endpoint URI for a Cognitive Services resource on Azure.
- ApiKey - specifies the Azure resource key used to track billing information for the container. You must specify a value for the ApiKey and the value must be a valid key for the Cognitive Services resource specified for the Billing configuration setting.

The remaining options are covered here.

### Application insights

Like many Azure services, you can gain insights to the LUIS container to gather telemetry information for the container. You can easily monitor your container for availability, performance, and usage. You can also quickly identify and diagnose errors in your container. To use application insights for your container, during creation, add the option to the docker run command:

```powershell
InstrumentationKey=123456789
```

### Fluentd settings

Fluentd is an open-source data collector for unified logging.  The settings are used to connect to a Fluentd server.  Using this option allows you to write logging information and metric data to the specified Fluentd server.   The following table outlines the options available for this argument.

| Name | Data Type | Description |
|---|---|---|
|Host|String|IP address or host name of Fluentd server|
|Port|Integer|Fluentd server port.  Default is port 24224|
|HeartbeatMs|Integer|Heartbeat interval measured in milliseconds. Used to send a heartbeat to the Fluentd server in the event that no traffic has been sent within the specified interval.  Default is 60,000 ms (1 minute)|
SendBufferSize|Integer|Size of the network buffer for send operations.  Default value is 32 Kilobytes)|
|TlsConnectionEstablishmentTimeoutMs|Integer|The timeout, in milliseconds, to establish a SSL/TLS connection with the Fluentd server. The default value is 10000 milliseconds (10 seconds).
If UseTLS is set to false, this value is ignored.|
|UseTLS|Boolean|Tells docker whether the container should use SSL/TLS for communication with the Fluentd server.  Default value is false.|

### HTTP proxies

If your network requires the use of HTTP proxy services, you can use the argument to specify the proxy settings for outbound requests.  The following table outlines the options for this argument.

|Name|Data Type|Description|
|---|---|---|
|HTTP_Proxy|string|URL for the proxy to use.  Example: http://proxy:8888
&lt;proxy-url&gt;|
|HTTP_PROXY_CREDS|string|If the proxy requires authentication, you provide the credentials necessary to authenticate with the proxy server in the setting.  Example HTTP_PROXY_CREDS=&lt;username&gt;:&lt;password*gt;|

### Logging settings

The Logging settings manage ASP.NET Core logging support for your container.  There are currently three logging providers that you can use:

- Console - ASP.NET Core console logging provider.
- Debug - ASP.NET Core Debug logging provider.
- Disk - A JSON logging provider that can write logging data to an output mount.

An example of this argument is ``` Logging:Disk:Format=json ```.

These options, both required and optional, are set during the use of the ``` docker run ``` command.  You cannot configure the options after the container is running.