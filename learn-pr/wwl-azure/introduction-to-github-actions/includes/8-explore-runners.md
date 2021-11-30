When you execute jobs, the steps execute on a Runner.

The steps can be the execution of a shell script or the execution of a predefined Action.

GitHub provides several hosted runners to avoid you needing to spin up your infrastructure to run actions.

Now, the maximum duration of a job is 6 hours, and for a workflow is 72 hours.

For JavaScript code, you have implementations of node.js on:

 -  Windows
 -  macOS
 -  Linux

If you need to use other languages, a Docker container can be used. Now, the Docker container support is only Linux-based.

These options allow you to write in whatever language you prefer.

JavaScript actions will be faster (no container needs to be used) and more versatile runtime.

The GitHub UI is also better for working with JavaScript actions.

## Self-hosted runners

If you need different configurations to the ones provided, you can create a self-hosted runner.

GitHub has published the source code for self-hosted runners as open-source, and you can find it here: [https://github.com/actions/runner](https://github.com/actions/runner).

It allows you to customize the runner completely. However, you then need to maintain (patch, upgrade) the runner system.

Self-hosted runners can be added at different levels within an enterprise:

 -  Repository-level (single repository).
 -  Organizational-level (multiple repositories in an organization).
 -  Enterprise-level (multiple organizations across an enterprise).

### **GitHub strongly recommends that you don't use self-hosted runners in public repos.**

Doing it would be a significant security risk, as you would allow someone (potentially) to run code on your runner within your network.

For more information on self-hosted runners, see: [About self-hosted runners](https://docs.github.com/actions/hosting-your-own-runners/about-self-hosted-runners).
