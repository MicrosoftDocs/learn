## Host your own repository

The default package source for Windows Package Manager is the [Windows Package Manager Community Repository](https://github.com/microsoft/winget-pkgs).  However, you can use your own repository instead.

The Windows Package Manager team have released information on how to stand-up a lightweight dev environment that you can start to use to understand how to host and run a repository within Microsoft Azure.

You can find detailed instructions and on how to deploy this within Microsoft Azure and also use it within your Windows Package Manager clients within the [Windows Package Manager CLI REST Source repository.](https://github.com/microsoft/winget-cli-restsource)

### Why host your own repository

Hosting your own repository will allow you to control what packages and versions of those packages are available for your organization to install when using Windows Package Manager.  It gives you the control your organization might need in regard to what software is, or isn't available for your users to install.

Using Group Policy you can configure what installer source repository what is the default for your end users.