Continuous integration (CI) and continuous delivery (CD) are closely related DevOps concepts, representing two distinct stages of the software delivery process. As you know from the previous module, the purpose of CI is to build and test software artifacts. CD automates the process of delivering these artifacts to their intended recipients. By implementing CD, organizations such as the one described in the sample scenario, are able to eliminate the manual effort involved in application deployment. In this unit, explore the characteristics and benefits of CD.

## What is continuous delivery?

Continuous delivery comprises the practices, which automate generation of software releases, ensure they are in a deployable state, and make them available to their consumers. Its focus is on minimizing the *time to deploy* and *time to mitigate (TTM)*, also known as *time to remediate (TTR)*. The latter refers to scenarios where a newly released version of the application reaches the production environment and needs to be rolled back.

:::image type="content" source="../media/2-explore-continuous-delivery.png" alt-text="Diagram of the continuous delivery flow.":::

Continuous delivery tends to be an iterative process, where the same artifact representing the latest software release transitions through several environments, which are dedicated, for example, to user acceptance testing, staging, and production. This provides ample opportunities to validate its functionality and stability.

It's worth noting that DevOps nomenclature includes two closely related terms, which have similar names and the same acronym – continuous delivery and continuous deployment. Both deal with automating and streamlining the software delivery process. The primary distinction between them is that the latter strives to implement full automation, including the production environment, while in case of the former, that final delivery requires a manual approval.

Akin to CI, automation is based on release definitions created by developers and implemented in the repository hosting platform. For example, GitHub offers for this purpose GitHub Actions workflow, while Azure DevOps relies on Azure Pipelines.

## What are the benefits of continuous delivery?

Benefits associated with continuous delivery are direct results of its automation and the shift-left approach. The most relevant ones include:

- **Accelerated release cycles**: Organizations are able to increase the delivery speed of new features, enhancements, and bug fixes, which translates into reduced time-to-market, ultimately benefiting customers.
- **Increased resiliency**: Automated testing allows for detecting issues early in the delivery process. Automated deployment ensures consistency across environments and minimizes the potential impact of human errors. Automation also tends to considerably simplify the rollback process in case there's a need to revert to a previous software version. Incremental rollout (which we'll cover later in this module) facilitate discovery of any potential issues before they might have a wider scale impact. Rapid feedback loops reduce response time if an issue is discovered.
- **Improved collaboration**: CD promotes interaction across development, operations, and security teams by integrating with CI, resulting in one cohesive process encompassing build, testing, and delivery.
- **Efficient resource utilization**: Automation tends to minimize time spent on manual, repetitive, and time-consuming tasks, resulting in optimized usage of human resources.
