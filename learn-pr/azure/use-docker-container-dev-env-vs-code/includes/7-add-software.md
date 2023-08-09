Your customized container is coming along well for your agency. With the power of Dev Containers, you've been able to add a preconfigured dev container, and through the exercises so far, you've customized your experience through the devcontainer.json file. But what if you want to add software beyond what's available in those images or preconfigured dev containers?

## Introduction to installing additional software

Additional software might include another technology stack for your agency. For instance, you might want to include Node.js in any of your dev containers because you know that's part of many development workflows.

When you ran **Dev Containers: Add Development Container Configuration Files**, a `.devcontainer` folder was added to your app. It included a `devcontainer.json` file, based on [this container image](https://github.com/devcontainers/images/tree/main/src/python). Although this image gives us many options for our team, we might want to iterate on them by installing more software.

## Methods to install software

You can install software via the integrated terminal. Most container images are based on Debian or Ubuntu, where you use the `apt` or `apt-get` command to install new packages.

> [!IMPORTANT]
> Whenever you install something from `apt-get`, run `apt-get update` first. This command updates the list of packages and package repos so that you have the most current list cached.

However, if you make changes to your `.devcontainer` folder and need to rebuild your container, you'll have to reinstall anything you've installed manually. To avoid this problem, you can use the `postCreateCommand` property in `devcontainer.json`, as mentioned in the previous unit.

The most efficient practice that persists your changes even after rebuilding is to install software through a Feature.

## Software installation via Features

As mentioned in unit 5 of this module, development container "Features" are self-contained, shareable units of installation code and dev container configuration. The name comes from the idea that referencing one of them allows you to quickly and easily add more tooling, runtime, or library "Features" into your development container for use by you or your collaborators.

When you use the VS Code command **Dev Containers: Add Dev Container Configuration Files**, you're presented a list of scripts to customize the existing dev container configurations, such as installing Git or the Azure CLI.

When you rebuild and reopen in your container, the Features you selected will be available in your devcontainer.json:

```json
"features": {
    "ghcr.io/devcontainers/features/azure-cli:1": {
        "version": "latest"
    }
}
```

The VS Code **Dev Containers: Configure Container Features** command allows you to update an existing configuration.

The Features sourced in VS Code UI now come from a central index, which you can [explore and even contribute to](https://containers.dev/features).

You can review more information about [how Features work](https://containers.dev/implementors/features/) and their [distribution](https://containers.dev/implementors/features-distribution/).

In the next exercise, you'll install Node.js. You'll then verify that Node.js is available in the running container.
