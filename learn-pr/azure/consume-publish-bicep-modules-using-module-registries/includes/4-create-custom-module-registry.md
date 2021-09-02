
## Private module registries

- Why would you use one?
- ACR vs. other registries like Docker Hub
- Mention that even though this is called OCI, it doesn't mean you have to use containers or Kubernetes

### Access control

TODO

## Publish a module

When you create a Bicep module, you write a Bicep file as normal. You then *publish* the file to a module registry by using the `bicep publish` command.

The publish operation performs the same validation steps that happen when you build or deploy a Bicep file, including checking that your code doesn't have any syntactical errors and that you're specifying valid resource definitions. It also runs the Bicep linter to verify that your code passes a series of quality checks.

<!-- TODO 
- Repositories
- Tags and versions
-->

## Configure Bicep to connect to a registry
