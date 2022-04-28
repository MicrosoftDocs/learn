Now that you have a fundamental understanding of what App Center can do, let's look at some of the services in more detail. You will be able to examine the capabilities of the App Center Build service, and decide whether it is appropriate for your apps.

The App Center Build service connects the source code of your app to a secure cloud infrastructure that takes care of the build work for you. The Build service eliminates the need for building on developer machines or configuring a build server yourself. The App Center Build service also connects with other App Center services to further automate your workflow. You can automatically run automated UI tests with App Center Test and distribute your release with App Center Distribute.

## What platforms are supported?

You can connect App Center Build services to your iOS, Android, UWP, and tvOS apps. Those apps could have been built with any number of frameworks or languages, including Swift, Kotlin, Xamarin, Java, Unity, or React Native. If you're using any of these systems to develop your app, App Center Build should be able to build your app.

## What source control systems can be used?

App Center Build services can connect to several source control systems. If you use a supported source control system, App Center Build can be configured to connect to it and retrieve your app's code directly.

App Center Build supports the following source control systems:

* GitHub
* Bitbucket
* Azure DevOps

> [!NOTE]
> Additional systems may be added or in preview as App Center evolves.

Connect App Center to these source control systems via their respective third-party approval systems, giving App Center permission to view the source repositories available on whatever account you choose. If your organization uses service accounts to manage source control permissions, you would provide access to App Center through those accounts. For personal development, you can provide access to App Center through your individual account.

## Create a build from app source code

When App Center can access your source code repositories, you can configure any number of branches to be built. For any branch, you configure your desired build settings. Within those settings, you decide whether to build automatically every time App Center sees a new commit, or only when you manually start a build.

When your app builds, you can also configure signing of your build. After a one-time configuration in App Center, you can add build signing to any of your builds. These signed builds can then be distributed to groups of users, such as app testers, or directly to an app store like Google Play Store or Apple App Store.

Additionally, if your build requires special processes, there is also a [system for creating custom build scripts](/appcenter/build/custom/scripts) that run at various points within the build lifecycle: _post-clone_, _pre-build_, and _post-build_. These scripts can take advantage of environment variables provided either by App Center or by your own custom variables.

## How are apps built?

When App Center builds your app, it is built using a clean environment every time. Your app's build gets a clean virtual machine (VM) that is used to build the source code into a release. After the app is built and the release is saved, the VM used to build your app is discarded. This process keeps the build environment clean and secure from your other App Center builds and other App Center users.

Builds for iOS and Android apps are run on macOS VMs using several development and runtime packages. UWP apps are built on VMs using Hosted Windows Agents. If your app build requires special software to build, you will need to make sure that software is available on the default build VMs. Build VMs are provided with several included software packages. The [latest software available to the iOS build VMs](/appcenter/build/software) is listed on the App Center documentation. You can also see the [latest software and capabilities available on the Hosted Windows Agents](/azure/devops/pipelines/agents/hosted?view=azure-devops#software) on the Azure Pipelines documentation.

## Test your app launches on real devices?

Once your app is built, you can also test that it launches on real devices. In the build configuration, you can toggle this setting. When it is enabled, App Center will launch your app on a physical device and take a screenshot of the result. This launch test will allow you to verify your app can load successfully with each build.
