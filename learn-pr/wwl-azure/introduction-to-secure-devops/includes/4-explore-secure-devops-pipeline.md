
As previously stated, the goal of a *Secure DevOps* Pipeline is to enable development teams to work fast without introducing unwanted vulnerabilities to their project.

:::image type="content" source="../media/secure-devops-workflow-895bcdec.png" alt-text="Diagram showing Secure DevOps Pipeline. 10 circles are arranged in a continuous circle.":::


Two essential features of Secure DevOps Pipelines that aren't found in standard DevOps Pipelines are:

 -  Package management and the approval process associated with it. The previous workflow diagram details other steps for adding software packages to the Pipeline and the approval processes that packages must go through before they're used. These steps should be enacted early in the Pipeline to identify issues sooner in the cycle.
 -  Source Scanner is also an extra step for scanning the source code. This step allows for security scanning and checking for vulnerabilities that aren't present in the application code. The scanning occurs *after* the app is built *before* release and pre-release testing. Source scanning can identify security vulnerabilities earlier in the cycle.

In the rest of this lesson, we address these two essential features of Secure DevOps Pipelines, the problems they present, and some of the solutions for them.
