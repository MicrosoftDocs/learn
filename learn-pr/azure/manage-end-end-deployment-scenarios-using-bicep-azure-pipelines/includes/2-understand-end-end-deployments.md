TODO intro

## Control plane and data plane

- Many Azure resources have a control plane and a data plane
- ARM and Bicep generally only interacts with the control plane
- But deployments often need to do data tier operations too
- e.g. upload a blob, modify a database schema, deploy an application to an App Service, or deploy software to a VM

There are also some resources that don't neatly distinguish their control and data planes for deployment, such as Azure Data Factory and Azure API Management. Both services support fully automated deployments by using Bicep, but they require special consideration. We link to more information in the summary.

## Pipeline design

Can consider a single pipeline for everything, or a pipeline for infra + pipeline for app

Single for everything:
Pros:
 - Simpler
 - Things don't get out of sync

Cons:
 - If you have a separate team managing infra and app, it can be hard to coordinate

Infra pipeline vs. app pipeline:
Pros:
 - More flexible

Cons:
 - Easy to get out of sync - e.g. when you need a new app setting for a new version of your app, the app pipeline needs to wait for the infra pipeline to complete

Guidance: usually better to go with a single pipeline where you can

## Last-mile deployments

ARM deployment scripts
- Runs in ARM
- Can use a managed identity
- Can run in between resource deployments, so you can run everything in a Bicep file

Pipeline scripts and tasks
- Runs from your pipeline agent
- Authentication might require a service principal (although you probably already have one to run the Bicep deployment), or might require another form of identity like a key
- Deployment requires more coordination between parts
- Often more flexible and can be used for more scenarios

## Outputs

Route outputs from Bicep deployments into a script, and/or between pipelines
