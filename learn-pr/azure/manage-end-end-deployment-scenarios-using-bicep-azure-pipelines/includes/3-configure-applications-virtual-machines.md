
## Build applications

Applications typically need to be compiled or built
Might also include things like compressing images and text files that will be served to your users
This turns the source code in the repo into a set of deployable files

### Artifacts

You don't want to commit these artifacts to your repo, because they're derived from the source code
The pipeline creates them by running build steps, which creates the files on the agent's file system
To make them available to the subsequent stages and jobs in your pipeline, you publish them as pipeline artifacts
You use a special pipeline task to publish an artifact
Deployment jobs automatically download the artifacts so they're ready to deploy and use

## Deploy applications

The way you deploy depends on the service you use to host the site.

### App Service

- For your toy company, you use App Service
- A deployment pipeline can deploy an app by using a built-in task
- App Service has its own data plane authentication system for deployments, but the Azure Pipelines task takes care of translating the AAD identity to the credentials required for deployment
- After your app is deployed, you often want to warm it up. You can do this in the app configuration file, which is deployed alongside the app file
- Deployment slots can be used to safely deploy a new version, warm it up, and then switch to it in one operation

### Other services

If you're deploying applications to a virtual machine, there are a variety of ways you can achieve this. For many scenarios, you need to use specialized tooling like Chef, Puppet, or Ansible. You also need to plan how you authenticate.

For Kubernetes and AKS, there are alternative approaches with specialized tooling.
