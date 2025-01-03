Incorporating DevOps into the application lifecycle involves implementing a range of DevOps practices. The ability to maximize DevOps benefits is highly dependent on the extent to which this implementation is successful. In our sample scenario, the organization would need to introduce significant changes to its operating model, starting with promoting collaboration and communication between development and operations teams as well as investing in version control, automation, continuous integration, continuous testing, continuous delivery, and continuous monitoring. You'll explore these practices in this unit.

:::image type="content" source="../media/4-devops-practices.png" alt-text="Diagram showing DevOps practices.":::

## Version control

Version control is the practice of managing updates to code by storing it in designated repositories, tracking its revisions,  and maintaining change history. This facilitates code reviews and the ability to recover from programming errors. In addition, version control systems (VCS) such as Git allow for collaboration in code authoring among multiple developers through such features as repository cloning, pull requests, code change merges, conflict resolution, and support for rollbacks.
The use of version control is a fundamental DevOps practice. Version control is also a prerequisite for such practices as continuous integration and infrastructure as code.

## Continuous Integration (CI) and Continuous Testing

One of the core practices of DevOps is automation. In this case, automation applies to the process of merging code changes, testing them, and building resulting artifacts, as early in the application lifecycle as possible. The intention is to detect any potential issues in the development phase, since this minimizes the effort and cost involved in fixing them. Automated tests validate that code changes haven't introduced errors or regression issues.

## Continuous Delivery (CD)

Continuous delivery automates the process of deploying artifacts built as part of CI, making them available to their consumers. CD automates progression of these artifacts through different environments, such as testing, staging, and production. Continuous integration and continuous delivery (CI/CD) together form a unified, streamlined, end-to-end software development and delivery process.

## Continuous monitoring

Continuous monitoring provides automated real-time visibility into the health and performance of the entire application stack, including its underlying infrastructure. This is accomplished through the collection of telemetry, including logs and metrics, and customizable alerting that delivers notifications about anomalous behavior, facilitating prompt remediation actions.

## Continuous Security (DevSecOps)

Security is an essential part of every phase of the DevOps-based application lifecycle, which is the reason for coining the term DevSecOps. DevSecOps is an extension of DevOps, with the focus on integrating security practices into each stage—from planning, through coding, testing, and deployment, to operations.

## Infrastructure as Code (IaC)

Infrastructure as Code is an integral component of modern software development and operations practices. It involves the use of programming methods to provision and manage infrastructure services. IaC defines infrastructure components such as servers, network devices, and databases by using code. Such code typically resides in a VCS, which manages and tracks changes to infrastructure configurations. The use of code facilitates automated provisioning and configuration of infrastructure, enhancing efficiency, consistency, and scalability. In addition, IaC can be (and frequently is) integrated with CI/CD, yielding a comprehensive software delivery strategy by combining  infrastructure provisioning, with application build, test, and deployment into one continuous, fully automated sequence.
