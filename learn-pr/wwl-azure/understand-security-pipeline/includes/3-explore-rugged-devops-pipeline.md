As previously stated, the goal of a *Rugged DevOps* pipeline is to enable development teams to work fast without introducing unwanted vulnerabilities into their project.

:::image type="content" source="../media/rugged-devops-workflow-3816bb1e.png" alt-text="A diagram represents the Rugged DevOps pipeline. 10 circles are arranged in a continuous circle in the following order. Open-source software OSS Management service, package manager, version control, build and CI agent, source scanner, release pipeline with testing, dynamic scanner, deployment, monitoring, and DevOps team. Two other circles outside the larger circle are labeled external package feeds and the approval process. External package feeds point to OSS management service, which in turn points to the approval process that points to package manager, which points back to OSS Management service.":::


Two essential features of Rugged DevOps pipelines that aren't found in standard DevOps pipelines are:

 -  Package management and the approval process associated with it. The previous workflow diagram details other steps for adding software packages to the pipeline and the approval processes that packages must go through before they're used. These steps should be enacted early in the pipeline to identify issues sooner in the cycle.
 -  Source Scanner, also an extra step for scanning the source code. This step allows for security scanning and checking for security vulnerabilities that aren't present in the application code. The scanning occurs *after* the app is built but *before* release and pre-release testing. Source scanning can identify security vulnerabilities earlier in the cycle.

In the rest of this lesson, we address these two essential features of Rugged DevOps pipelines, the problems they present, and some of the solutions for them.
