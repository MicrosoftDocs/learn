
These patterns store the configuration information in an external location and provide an interface that can be used to quickly and efficiently read and update configuration settings.

The type of external store depends on the hosting and runtime environment of the application.

A cloud-hosted scenario is typically a cloud-based storage service but could be a hosted database or other systems.

The backing store you choose for configuration information should have an interface that provides consistent and easy-to-use access.

It should expose the information in a correctly typed and structured format.

The implementation might also need to authorize users' access to protect configuration data and be flexible enough to allow storage of multiple configuration versions (such as development, staging, or production, including many release versions of each one).

Many built-in configuration systems read the data when the application starts up and cache the data in memory to provide fast access and minimize the impact on application performance.

Depending on the type of backing store used and its latency, it might be helpful to implement a caching mechanism within the external configuration store.

For more information, see the Caching Guidance. The figure illustrates an overview of the External Configuration Store pattern with optional local cache.

:::image type="content" source="../media/applications-accessing-external-configuration-ef278b40.png" alt-text="Applications are accessing the external configuration store, which is accessing cloud storage, or databases.":::


This pattern is helpful for:

 -  Configuration settings are shared between multiple applications and application instances, or where a standard configuration must be enforced across various applications and application instances.
 -  A standard configuration system doesn't support all the required configuration settings, such as storing images or complex data types.
 -  As a complementary store for some application settings, they allow applications to override some or all the centrally stored settings.
 -  To simplify the administration of multiple applications and optionally monitor configuration settings by logging some or all types of access to the configuration store.
