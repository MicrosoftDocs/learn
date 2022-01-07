While the adoption of cloud computing is on the rise to support business productivity, a lack of security infrastructure can inadvertently compromise data.

The 2018 Microsoft Security Intelligence Report finds that:

 -  Data **isn't** encrypted both at rest and in transit by:
    
     -  7% of software as a service (SaaS) storage apps.
     -  86% percent of SaaS collaboration apps.
 -  HTTP headers session protection is supported by **only**:
    
     -  4% of SaaS storage apps.
     -  3% of SaaS collaboration apps.

## Rugged DevOps (or DevSecOps)

*DevOps* is about working faster. *Security* is about-emphasizing thoroughness. Security concerns are typically addressed at the end of the cycle. It can potentially create unplanned work right at the end of the pipeline. *Rugged DevOps* integrates DevOps with security into a set of practices designed to meet the goals of both DevOps and safety more effectively.

:::image type="content" source="../media/rugged-devops-771a0ca8.png" alt-text="Venn Diagram with one DevOps circle and one Security circle overlapping. The overlap is labeled rugged DevOps.":::


A rugged DevOps pipeline allows development teams to work fast without breaking their project by introducing unwanted security vulnerabilities.

> [!NOTE]
> Rugged DevOps is also sometimes referred to as *DevSecOps*. You might encounter both terms, but each term refers to the same concept.

## Security in the context of rugged DevOps

Historically, security typically operated on a slower cycle and involved traditional security methodologies, such as:

 -  Access control.
 -  Environment hardening.
 -  Perimeter protection.

Rugged DevOps includes these traditional security methodologies and more. With rugged DevOps, security is about securing the pipeline.

Rugged DevOps involves determining where to add protection to the elements that plug into your build and release pipelines.

Rugged DevOps can show you how and where you can add security to your automation practices, production environments, and other pipeline elements while benefiting from the speed of DevOps.

Rugged DevOps addresses broader questions, such as:

 -  Is my pipeline consuming third-party components, and if so, are they secure?
 -  Are there known vulnerabilities within any of the third-party software we use?
 -  How quickly can I detect vulnerabilities (also referred to as *time to detect*)?
 -  How quickly can I remediate identified vulnerabilities (also referred to as *time to remediate*)?

Security practices for detecting potential security anomalies need to be as robust and fast as your DevOps pipeline's other parts. It also includes infrastructure automation and code development.
