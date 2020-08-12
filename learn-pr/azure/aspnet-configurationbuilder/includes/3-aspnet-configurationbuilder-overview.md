
Configuring the app is central to building it in a way that allows its dependencies to vary, based on the environment in which it's deployed. In .NET Framework apps, the most common mechanism to customize app configuration is through the *ConfigurationManager* type. You can use a configuration manager to read settings that are often stored in the *app.config* file for desktop apps, or in the *web.config* file for ASP.NET web apps.

One of the challenges with storing configuration settings in this manner is that values to be kept secret often end up being stored as plain text somewhere. This practice creates a security vulnerability. You use the *ConfigurationBuilder* class to remove this vulnerability.

## What is the ConfigurationBuilder class?

The ConfigurationManager approach that's used by many traditional .NET Framework and ASP.NET web apps allows an administrator to store configuration information as a series of keys and values in a config file. ConfigurationManager has been the primary mechanism to avoid hard-wiring information into an app, and it's well understood by most ASP.NET developers. 

The simplicity of using ConfigurationManager can also be a significant shortcoming. It's not easy to store and retrieve configuration information in sources other than the config file that's associated with the app. Large-scale enterprise systems, especially those running in the cloud, frequently need to adapt their configuration dynamically, and they require other sources of configuration information.

Additionally, the config file that's used by ConfigurationManager is typically held as plain text, although some encryption options are available. Encryption can be cumbersome, and it still requires an encryption key to be stored somewhere. Hard-coding the encryption key in app code isn't a secure solution, even after the app is compiled. A determined attacker could disassemble your code and read the key. These issues can make using ConfigurationManager an unsuitable mechanism for storing sensitive configuration information, such as passwords and connection strings, unless a great deal of care is taken.

A ConfigurationBuilder object is designed to enable you to retrieve configuration information from a variety of sources.

The ConfigurationBuilder mechanism is an extension of the concepts implemented by the ConfigurationManager class. Rather than restricting configuration information to a strict XML grammar stored in a text file, you can use a variety of configuration builders, based on different configuration sources. A configuration builder provides its own specific means to access data. Currently available configuration builders include:

- **Microsoft.Configuration.ConfigurationBuilders.Environment**: Adds settings from the environment variables of the current process
- **Microsoft.Configuration.ConfigurationBuilders.UserSecrets**: Adds user secrets contained in an XML file external to the code base
- **Microsoft.Configuration.ConfigurationBuilders.Azure**: Pulls items from key vault
- **Microsoft.Configuration.ConfigurationBuilders.KeyPerFile**: File based, where the name of the file is the key, and the contents are the value
- **Microsoft.Configuration.ConfigurationBuilders.Json**: Pulls key/value pairs from JSON files

You can also create your own custom ConfigurationBuilder class if you need to access configuration information that's held in store and for which no builder is currently available.

The choice as to which configuration builder to use depends on the scenarios and the requirements of an individual app.

## How ConfigurationBuilder objects work

An app reads information from a configuration builder object in exactly the same way as it would have previously, by using a ConfigurationManager object. You can continue to use the *ConfigurationManager.AppSettings["settingName"]* idiom, and you don't need to change your app code. 

Instead, you provide the details of the configuration builders to use in the app config file. You specify which builders to apply to retrieve app settings and connection strings by using the *configBuilders* attribute of the **appSettings** and **connectionStrings** sections in the app config file.

You add ConfigurationBuilder types to the **\<configBuilders\>** section in the config. Each builder you add is assigned a name (a string that's used to reference the builder from elsewhere in the config), and the full type name. Many builders take additional, builder-specific parameters. You also need to add the assembly that processes the **\<configBuilders\>** section. 

> [!NOTE]
> If you add configuration builders to a project by using the **Install-Package** command or the package manager in Visual Studio, the **\<configBuilders\>** section and associated assemblies are added to the config file automatically.

The following example adds the builders for using environment variables and user secrets. The **userSecretsId** parameter indicates the identity of the user secret that contains the data. At runtime, the builder looks in the *secrets.xml* file, which is stored in a protected location (*%APPDATA%\Microsoft\UserSecrets\<userSecretsId>\secrets.xml* in Windows), for the value to use:

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

In this example, when an app retrieves the value of the *MySecretData* key or the *MyEnvironmentData* key, the configuration entry is composed of values from the specified sources. The values are listed in the order in which they are stated. Here, entries from **Environment** are added first, followed by those from **Secrets**. This means that the last source that has a specified value is surfaced to the user. You can change the search order by switching the sequence in the **configBuilders** attribute.

> [!NOTE]
> The syntax of key/value pairs in the **\<appSettings\>** section requires you to specify a value in the config file, even if it isn't used. In this case, it's common to provide an empty string, as shown in the preceding example.
