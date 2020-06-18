
Configuration is central to building an app in a way that allows its dependencies to vary, based on the environment in which it's deployed. In .NET Framework applications, the most common mechanism to customize app configuration is through the *ConfigurationManager* type. You can use a configuration manager to read settings that are often stored in the app.config file for desktop apps, or in the web.config file for ASP.NET web apps.

One of the challenges with storing configuration settings in this manner is that values to be kept secret often end up being stored as plain text somewhere. This practice creates a security vulnerability. You use the *ConfigurationBuilder* type to remove this vulnerability.

## What is the ConfigurationBuilder type?

The *ConfigurationManager* approach used by many traditional .NET Framework and ASP.NET web applications allows an administrator to store configuration information as a series of keys and values in a configuration file. *ConfigurationManager* has been the primary mechanism to avoid hard-wiring information into an application, and is well understood by most ASP.NET developers. 

The simplicity of using *ConfigurationManager* can also be its downfall. It's not easy to store and retrieve configuration information in sources other than the .config file associated with the app. Large-scale enterprise systems, especially the ones running in the cloud, frequently need to adapt their configuration dynamically, and require other sources of configuration information.

Additionally, the .config file used by *ConfigurationManager* is typically held as plain text, although some encryption options are available. However, encryption can be cumbersome, and still requires an encryption key to be stored somewhere. Hard-coding the encryption key in application code isn't a secure solution, even after the application is compiled. A determined attacker could disassemble your code and read the key. These issues can make using *ConfigurationManager* an unsuitable mechanism for storing sensitive configuration information, such as passwords and connection strings, unless a great deal of care is taken.

A *ConfigurationBuilder* object is designed to enable you to retrieve configuration information from different kinds of sources.

The *ConfigurationBuilder* mechanism is an extension of the concepts implemented by the *ConfigurationManager* class. Rather than restricting configuration information to a strict XML grammar stored in a text file, you can use a range of different configuration builders, based on different configuration sources. A configuration builder provides its own specific means to access data. Currently available configuration builders include:

- **Microsoft.Configuration.ConfigurationBuilders.Environment**. Adds settings from the environment variables of the current process
- **Microsoft.Configuration.ConfigurationBuilders.UserSecrets**. Adds user secrets contained in an XML file external to the code base
- **Microsoft.Configuration.ConfigurationBuilders.Azure**. Pulls items from key vault
- **Microsoft.Configuration.ConfigurationBuilders.KeyPerFile**. File based, where the name of the file is the key, and the contents are the value
- **Microsoft.Configuration.ConfigurationBuilders.Json**. Pulls key/value pairs from JSON files

You can also create your own custom *ConfigurationBuilder* class if you need to access configuration information held in store, for which no builder is currently available.

The choice as to which configuration builder to use depends on the scenarios and the requirements of an individual application.

## How ConfigurationBuilder objects work

An application reads information from a configuration builder object in exactly the same way as it would previously have done, using a *ConfigurationManager* object. You can continue to use the *ConfigurationManager.AppSettings["settingName"]* idiom, and you don't need to change your application code. Instead, you provide the details of the configuration builders to use in the application configuration file. You specify which builders to apply to retrieve application settings and connection strings by using the *configBuilders* attribute of the *appSettings* and *connectionStrings* sections in the application configuration file.

You add ConfigurationBuilder types to the *\<configBuilders\>* section in the configuration file. Each builder you add is assigned a name (just a string that's used to reference the builder from elsewhere in the configuration file), and the full type name. Many builders also take further, builder-specific parameters. You also need to add the assembly that processes the *\<configBuilders\>* section. 

> [!NOTE]
> If you add configuration builders to a project using the **Install-Package** command, or the Package Manager in Visual Studio, the **configBuilders** section and associated assemblies will be added to the configuration file automatically.

The example below adds the builders for using environment variables and user secrets. The **userSecretsId** parameter indicates the identity of the user secret that contains the data. At runtime, the builder will look in the file **secrets.xml**, stored in a protected location (**%APPDATA%\Microsoft\UserSecrets\<userSecretsId>\secrets.xml** on Windows) for the value to use:

```XML
<configuration>
  <configSections>
    <section name="configBuilders" type="System.Configuration.ConfigurationBuildersSection, System.Configuration, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" restartOnExternalChanges="false" requirePermission="false" />
    ...
  </configSections>
  <configBuilders>
    <builders>
      <add name="Environment" type="Microsoft.Configuration.ConfigurationBuilders.EnvironmentConfigBuilder, Microsoft.Configuration.ConfigurationBuilders.Environment, Version=2.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" />
      <add name="Secrets" userSecretsId="c96e0578-6490-4a2d-b6c5-cb2b0baaeae8" type="Microsoft.Configuration.ConfigurationBuilders.UserSecretsConfigBuilder, Microsoft.Configuration.ConfigurationBuilders.UserSecrets, Version=2.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" />
    </builders>
  </configBuilders>
  <appSettings configBuilders="Environment,Secrets">
    <add key="MySecretData" value="" />
    <add key="MyEnvironmentData" value="" />
  </appSettings>
  ...
<configuration>
```

In this example, when an application retrieves the value of the **MySecretData** key or the **MyEnvironmentData** key, the configuration entry will be composed of values from the given sources. This is done in the order in which they are stated. In this example, first entries from **Environment** will be added, then those from **Secret**. This means that the last source that has a specified value will be surfaced to the user. You can change the search order by switching the sequence in the **configBuilders** attribute.

> [!NOTE]
> The syntax of key/value pairs in the *\<appSettings\>* section requires you to specify a value in the configuration file, even if it isn't used. In this case, it's common to provide an empty string, as shown in the example above.
