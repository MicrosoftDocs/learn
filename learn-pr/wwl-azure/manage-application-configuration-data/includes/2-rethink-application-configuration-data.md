
## Configuration information in files

Most application runtime environments include configuration information that is held in files deployed with the application. In some cases, it's possible to edit these files to change the application behavior after deploying.

However, changes to the configuration require the application to be redeployed, often resulting in unacceptable downtime and other administrative overhead.

Local configuration files also limit the configuration to a single application, but sometimes it would be helpful to share configuration settings across multiple applications.

Examples include database connection strings, UI theme information, or the URLs of queues and storage used by a related set of applications.

It's challenging to manage changes to local configurations across multiple running instances of the application, especially in a cloud-hosted scenario.

It can result in instances using different configuration settings while the update is being deployed. Also, updates to applications and components might require changes to configuration schemas.

Many configuration systems don't support different versions of configuration information.

## Example

It's 2:00 AM. Adam is done making all changes to his super fantastic code piece.

The tests are all running fine. They hit commit -&gt; push -&gt; all commits pushed successfully to git. Happily, Adam drives back home. 10 mins later, they get a call from the SecurityOps engineer, "Adam, did you push the Secret Key to our public repo?"

YIKES! That blah.config file, Adam thinks. How could I've forgotten to include that in .gitignore? The nightmare has already begun.

We can surely blame Adam for sinning, checking in sensitive secrets, and not following the recommended practices of managing configuration files.

Still, the bigger question is that if the underlying toolchain had abstracted out the configuration management from the developer, this fiasco would have never happened!

## History

The virus was injected a long time ago. Since the early days of .NET, the app.config and web.config files have the notion that developers can make their code flexible by moving typical configuration into these files.

When used effectively, these files are proven to be worthy of dynamic configuration changes. However, much time, we see the misuse of what goes into these files.

A common culprit is how samples and documentation have been written. Most samples on the web would usually use these config files to store key elements such as ConnectionStrings and even passwords.

The values might be obfuscated but what we are telling developers is that "hey, It's a great place to push your secrets!".

So, in a world where we're preaching using configuration files, we can't blame the developer for not managing its governance.

We aren't challenging the use of Configuration here. It's an absolute need for an exemplary implementation. Instead, we should debate using multiple JSON, XML, and YAML files to maintain configuration settings.

Configs are great for ensuring the flexibility of the application, config files. However, they aren't straightforward, especially across environments.

## A ray of hope: The DevOps movement

In recent years, we've seen a shift around following some excellent practices around effective DevOps and some great tools (Chef, Puppet) for managing Configuration for different languages.

While these have helped inject values during CI/CD pipeline and greatly simplified configuration management, the blah.config concept hasn't moved away.

Frameworks like ASP.NET Core support the notion of appSettings.json across environments.

The framework has made it practical to use across environments through interfaces like IHostingEnvironment and IConfiguration, but we can do better.
