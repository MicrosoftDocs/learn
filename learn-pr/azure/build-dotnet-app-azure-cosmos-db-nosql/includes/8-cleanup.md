After completing the project, you might wish to clean up your development environment or return it to its typical state.

## [Develop in browser](#tab/github-codespaces)

Deleting the GitHub Codespaces environment ensures that you can maximize the amount of free core hours entitlement you get for your account.

1. Sign into the GitHub Codespaces dashboard (<https://github.com/codespaces>).

1. Locate your currently running codespace in the list of codespaces.

1. Open the context menu for the codespace and then select **Delete**.

## [Develop locally](#tab/visual-studio-code)

You aren't necessarily required to clean up your local environment, but you can stop the running development container and return to running Visual Studio Code in the context of a local workspace.

1. Open the **Command Palette**.

1. Search for and then select **Dev Containers: Reopen Folder Locally**.

> [!TIP]
> Visual Studio Code will stop the running development container, but the container still exists in Docker in a stopped state. You always have the option to deleting the container instance, container image, and volumes from Docker to free up more space on your local machine.

---
