You're probably asking yourself, when should I use GitHub Codespaces and when should I use github.dev?

You can use github.dev to simply navigate files and sources code repositories from GitHub, and make and commit code changes. You can open any repository, fork, or pull request in github.dev editor.

If you're wanting to do more heavy lifting like testing your code, you want to use GitHub Codespaces for that since github.dev has no compute associated with it. Because of this you won't be able to build and run your code or have terminal access. Meanwhile GitHub Codespaces you get the power of a personal Virtual Machine (VM) with terminal access, the same way you could use your local enviornment, just in the cloud.

Let's review the differences between Codespaces and github.dev with the table below.

### Codespace vs. github.dev

|  | github.dev | GitHub Codespace |
|--------|--------|--------|
| Cost | Free | Free monthly quota of usage for personal accounts |
| Availability |  Available to everyone on GitHub.com | Available to everyone on GitHub.com |
| Startup | Github.dev opens instantly with a key-press and you can start using it right away without having to wait for additional configuration or installation | When you create or resume a codespace, the codespace is assigned a VM and the container is configured based on the contents of a devcontainer.json file. This setup may take a few minutes to create the development environment. |
| Compute | There is no associated compute, so you won’t be able to build and run your code or use the integrated terminal. | With GitHub Codespaces, you get the power of a dedicated VM on which you can run and debug your application.|
| Terminal access | None | GitHub Codespaces provides a common set of tools by default, meaning that you can use the Terminal exactly as you would in your local environment.|
| Extensions | Only a subset of extensions that can run on the web will appear in the Extensions View and can be installed | With GitHub Codespaces, you can use most extensions from the Visual Studio Code Marketplace.|

### Continue working on Codespaces

You can start your workflow in github.dev and continue working on a codespace. If you try to access the Run and Debug View or the Terminal, you'll be notified that they are not available in github.dev.

To continue your work in a codespace, click Continue Working on… and select Create New Codespace to create a codespace on your current branch. Before you choose this option, you must commit any changes.
