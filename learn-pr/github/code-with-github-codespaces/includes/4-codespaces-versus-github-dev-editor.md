You're probably asking yourself, when should I use GitHub Codespaces and when should I use GitHub.dev?

You can use GitHub.dev to navigate files and sources code repositories from GitHub, and make and commit code changes. You can open any repository, fork, or pull request in GitHub.dev editor.

If you want to do more heavy lifting like testing your code, use GitHub Codespaces. It has compute associated with it so you can build your code, run your code, and have terminal access. GitHub.dev doesn't have compute in it. With GitHub Codespaces, you get the power of a personal Virtual Machine (VM) with terminal access, the same way you could use your local environment, just in the cloud.

### Comparison of Codespaces and GitHub.dev

The following table lists the main differences between Codespaces and GitHub.dev:

|    | GitHub.dev | GitHub Codespaces |
|--------|--------|--------|
| **Cost** | Free | Free monthly quota of usage for personal accounts |
| **Availability** |  Available to everyone on GitHub.com | Available to everyone on GitHub.com |
| **Startup** | GitHub.dev opens instantly with a key-press and you can start using it right away without having to wait for configuration or installation | When you create or resume a Codespace, the Codespace is assigned a VM, and the container is configured based on the contents of a devcontainer.json file. This setup takes a few minutes to create the development environment. |
| **Compute** | There's no associated compute, so you can't build and run your code or use the integrated terminal. | With GitHub Codespaces, you get the power of a dedicated VM to run and debug your application. |
| **Terminal access** | None | GitHub Codespaces provides a common set of tools by default, meaning that you can use the Terminal exactly as you would in your local environment. |
| **Extensions** | Only a subset of extensions that can run on the web appear in the extensions view and can be installed | With GitHub Codespaces, you can use most extensions from the Visual Studio Code Marketplace. |

### Continue working on Codespaces

You can start your workflow in GitHub.dev and continue working on a Codespace. If you try to access the Run and Debug View or the Terminal, you're notified that they're not available in GitHub.dev.

To continue your work in a Codespace, select **Continue Working on…**. Select **Create New Codespace** to create a Codespace on your current branch. Before you choose this option, you must commit any changes.
