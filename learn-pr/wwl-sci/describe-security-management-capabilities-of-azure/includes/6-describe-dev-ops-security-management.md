
DevOps combines development (Dev) and operations (Ops) to unite people, process, and technology in application planning, development, delivery, and operations. Modern enterprises rely on DevOps platforms for deployment, including the pipelines and production environments that developers require to be productive. Traditional application security methods didn't consider the increased attack surface that these pipelines and environments represent. With attackers shifting their focus to these upstream tools, a new approach is needed to secure DevOps platform environments.

Defender for DevOps, a service available in Defender for Cloud, empowers security teams to manage DevOps security across multi-pipeline environments.

## What Defender for DevOps does

Defender for DevOps uses a central console to empower security teams with the ability to protect applications and resources from code to cloud across multi-pipeline environments, such as GitHub, Azure DevOps, and GitLab. Findings from Defender for DevOps can then be correlated with other contextual cloud security insights to prioritize remediation in code. Key capabilities in Defender for DevOps include:

- **Unified visibility into DevOps security posture**: Security administrators have full visibility into DevOps inventory and the security posture of preproduction application code. They can configure their DevOps resources across multi-pipeline and multicloud environments in a single view that includes findings from code, secrets, and open-source dependency vulnerability scans. They can also assess the security configurations of their DevOps environment.
- **Strengthened cloud resource configurations throughout the development lifecycle**: Security of Infrastructure as Code (IaC) templates, which are used to define and deploy infrastructure rapidly and reliably, can be assessed to minimize cloud misconfigurations from reaching production environments. This allows security administrators to focus on any critical evolving threats.
- **Prioritized remediation of critical issues in code**: Comprehensive code-to-cloud contextual insights within Defender for Cloud help developers prioritize critical code fixes with Pull Request annotations. Security admins can assign developer ownership by triggering custom workflows that feed directly into the tools developers use.

## DevOps security overview

Defender for DevOps provides your security teams with a high-level overview of discovered issues in connected DevOps environments through the Defender for DevOps console. The security overview surfaces metrics across key risk dimensions:

- **Code scanning vulnerabilities**: Security weaknesses found in the application code itself.
- **Exposed secrets**: Credentials, API keys, or other sensitive information inadvertently included in code or configuration files.
- **Open-source software (OSS) vulnerabilities**: Known security vulnerabilities in third-party open-source dependencies used by the application.
- **Recommendations**: Actions your security team can take to improve the security configuration of connected DevOps environments.

:::image type="content" source="../media/devops-metrics-inline.png" lightbox="../media/devops-metrics-expanded.png" alt-text="Screenshot of the Defender for DevOps console, showing the number of vulnerabilities found by Defender for DevOps.":::

Together, these capabilities help organizations embed security into their development workflows, so that vulnerabilities are identified and addressed before code reaches production environments.

## DevSecOps and AI development pipelines

Teams building AI-powered applications use the same development pipelines as any other software project, which means they're subject to the same categories of risk. Code that provisions AI infrastructure, stores API keys for AI services, or configures AI endpoints can introduce serious security vulnerabilities if those secrets or misconfigurations aren't caught early.

Defender for DevOps helps security teams identify these issues in AI development workflows. For example, it can detect if an AI service API key has been committed to a code repository, or if an infrastructure template deploys an AI endpoint without proper authentication controls. Catching these issues during development is far less costly than addressing them after they've reached a production AI application.

By extending DevSecOps practices to AI development workflows, organizations ensure that the same security discipline applied to traditional application development also covers the AI applications they're building.

## How DevSecOps connects to the broader Defender for Cloud platform

Defender for DevOps doesn't operate in isolation. Findings from code scanning, secrets detection, and infrastructure-as-code (IaC) analysis feed directly into the broader Defender for Cloud experience. In the Defender CSPM plan, these DevOps findings can be correlated with cloud infrastructure risks to provide a code-to-cloud view of security issues.

This integration means that security teams can trace a production risk back to its source in code. For example, if CSPM identifies a misconfigured virtual network in production, the infrastructure template that deployed it can often be found and corrected—preventing the same misconfiguration from being redeployed in the future.

Similarly, attack path analysis in CSPM can incorporate findings from Defender for DevOps, giving security teams a more complete picture of how a vulnerability in code could ultimately lead to a compromise of a production workload.

This code-to-cloud visibility makes DevSecOps an essential component of an organization's overall security posture, rather than just a practice limited to development teams.
