**Open-source software** is software whose source code is made publicly available for anyone to inspect, modify, and distribute. The Open Source Initiative provides the widely accepted definition:

_"Open-source software is software with source code that anyone can inspect, modify, and enhance. The copyright holder grants users the rights to study, change, and distribute the software to anyone and for any purpose, subject to the terms of an open-source license."_

This definition emphasizes several key principles:

- **Source code availability:** The complete source code must be publicly accessible, not just executable binaries.
- **Freedom to modify:** Users can change the software to suit their needs, fix bugs, or add features.
- **Redistribution rights:** Users can share the software with others, either in original or modified form.
- **License terms:** Usage rights are defined by an open-source license that specifies permissions, restrictions, and obligations.

Open-source software differs fundamentally from **proprietary software**, where the source code remains secret, and usage rights are tightly controlled by the copyright holder.

## The collaborative open-source model

**Open-source development** involves collaborative software creation with multiple contributors:

### Community-driven development

- **Distributed contributors:** Developers from around the world contribute code, documentation, testing, and support.
- **Voluntary participation:** Many contributors participate voluntarily, motivated by solving problems, learning, reputation building, or supporting tools they use.
- **Meritocracy:** Influence in projects typically correlates with quality and quantity of contributions rather than organizational hierarchy.
- **Transparent processes:** Development happens in public repositories where anyone can observe discussions, decisions, and changes.

### Collaborative workflows

- **Public repositories:** Code is hosted on platforms like GitHub, GitLab, or Bitbucket where anyone can view it.
- **Issue tracking:** Bugs and feature requests are tracked publicly, allowing community members to identify problems and propose solutions.
- **Pull request reviews:** Contributors submit changes through pull requests that are reviewed by maintainers and other community members before merging.
- **Release management:** Maintainers coordinate releases, ensuring stability and compatibility while incorporating community contributions.

### Project governance models

Different open-source projects adopt various governance approaches:

- **Benevolent dictator:** A single individual (often the founder) makes final decisions about project direction (e.g., Python with Guido van Rossum historically).
- **Core team:** A small group of maintainers collectively makes decisions through consensus or voting.
- **Foundation governance:** Large projects often create foundations (like Apache Foundation, Linux Foundation) that provide legal structure, resources, and governance frameworks.
- **Corporate sponsorship:** Many open-source projects are primarily maintained by employees of companies that depend on the software.

## Widespread adoption of open-source software

Open-source software has become ubiquitous across all sectors of technology:

### Industry adoption statistics

- **Enterprise usage:** Over 90% of enterprises use open-source software in production environments.
- **Internet infrastructure:** The majority of web servers run on Linux (open-source), serve content through Apache or Nginx (open-source), and use databases like PostgreSQL or MySQL (open-source).
- **Cloud computing:** Major cloud platforms extensively use and support open-source technologies—Kubernetes, Docker, Terraform, and numerous other open-source tools form the foundation of modern cloud infrastructure.
- **Mobile devices:** Android, the world's most popular mobile operating system, is built on the Linux kernel and includes extensive open-source components.

### Technology stack composition

Modern technology stacks are predominantly open-source:

- **Operating systems:** Linux powers cloud infrastructure, containers, and many embedded systems.
- **Programming languages:** Python, JavaScript, Java, Go, Rust, Ruby, PHP—most popular languages are open-source.
- **Databases:** PostgreSQL, MySQL, MongoDB, Redis, Elasticsearch dominate database deployments.
- **Web technologies:** React, Angular, Vue.js, Express, Django, Rails enable web application development.
- **Development tools:** Git, Docker, Kubernetes, Jenkins, VS Code are essential open-source development tools.

## Microsoft's embrace of open-source

Microsoft exemplifies the transformation in enterprise attitudes toward open-source software:

### Historical shift

Microsoft historically viewed open-source as a threat to its proprietary software business model. This changed dramatically over the past decade as the company recognized open-source's strategic importance.

### Open-source in Azure

Azure extensively integrates open-source technologies:

:::image type="content" source="../media/open-source-azure-66a7643e.png" alt-text="Screenshot of open-source tools and technologies in Azure.":::

**Languages and runtimes:** Azure supports Python, Node.js, Java, PHP, Ruby, Go, and other open-source languages as first-class platform options.

**Databases:** Azure offers managed services for PostgreSQL, MySQL, MariaDB, and Redis, alongside proprietary offerings.

**Container orchestration:** Azure Kubernetes Service (AKS) provides managed Kubernetes, the open-source container orchestration platform.

**Development tools:** Azure DevOps integrates with Git, Jenkins, and other open-source tools, while GitHub (acquired by Microsoft) is the world's largest platform for open-source development.

**Data and analytics:** Azure supports Apache Spark, Hadoop, Kafka, and other open-source big data technologies.

### .NET transformation

The **.NET platform** demonstrates Microsoft's comprehensive commitment to open-source:

**Open-sourcing .NET:** Microsoft released .NET Core (now .NET 5+) as open-source under the MIT license, making the entire platform freely available with source code. The .NET runtime, libraries, compilers, and tools are all open-source.

**Cross-platform development:** By open-sourcing .NET, Microsoft enabled cross-platform development on Windows, Linux, and macOS, dramatically expanding .NET's reach.

**Community contributions:** The .NET repositories on GitHub receive thousands of contributions from developers outside Microsoft, with the company actively reviewing and accepting community improvements.

**Open-source dependencies:** ASP.NET Core applications typically incorporate many open-source components:

- **Frontend libraries:** jQuery, React, Angular, Vue.js enable rich user interfaces.
- **Utility libraries:** Newtonsoft.Json, Serilog, AutoMapper, and countless others provide common functionality.
- **Testing frameworks:** xUnit, NUnit, Moq support test-driven development.

### Contributing to open-source projects

Microsoft actively contributes to open-source projects beyond its own:

**Linux kernel:** Microsoft contributes to the Linux kernel, improving Hyper-V integration and supporting Azure infrastructure.

**Kubernetes:** Microsoft is a major contributor to Kubernetes, helping shape the platform that powers AKS.

**Open-source initiatives:** Microsoft sponsors open-source events, funds critical open-source infrastructure, and employs developers to work full-time on open-source projects.

### Microsoft-created open-source projects

Beyond contributing to existing projects, Microsoft creates and open-sources significant software:

**Visual Studio Code:** The most popular code editor is open-source, with extensions, themes, and improvements contributed by a global community.

**TypeScript:** Microsoft's language for type-safe JavaScript development is open-source and widely adopted.

**PowerShell Core:** Microsoft's automation framework is open-source and cross-platform.

**.NET Foundation:** Microsoft established the .NET Foundation to support open-source projects in the .NET ecosystem, providing resources, governance, and community support.

For more information, see the [.NET Foundation website](https://www.dotnetfoundation.org).

### Strategic rationale

Microsoft's embrace of open-source reflects strategic business decisions:

**Developer adoption:** Developers prefer open-source tools and languages. By supporting open-source, Microsoft attracts developers to its platforms.

**Cloud business:** Open-source workloads drive cloud adoption. Excellent open-source support on Azure makes the platform more attractive.

**Innovation speed:** Open-source enables faster innovation through community contributions, reducing Microsoft's development burden.

**Ecosystem growth:** Open-source communities create valuable extensions, tools, and knowledge that enhance platform value.

**Competitive positioning:** As competitors (AWS, Google Cloud) support open-source extensively, Microsoft must match or exceed their open-source capabilities.

## Why organizations choose open-source

Organizations select open-source software for multiple reasons:

**Cost considerations:** Eliminating licensing fees reduces direct costs, particularly important when deploying software at scale or building products where licensing costs would be passed to customers.

**Flexibility and control:** Access to source code means organizations can modify software to meet specific needs, fix critical bugs independently, and aren't locked into vendor timelines for features or fixes.

**Transparency and security:** Public source code enables security audits, community review identifies vulnerabilities faster, and the absence of hidden backdoors or data collection provides confidence.

**Avoiding vendor lock-in:** Open-source software can typically be deployed anywhere, reducing dependence on specific vendors and improving negotiating positions.

**Community support:** Active open-source communities provide forums, documentation, tutorials, and peer assistance, often rivaling or exceeding commercial support quality.

**Innovation and features:** Cutting-edge technologies often emerge in open-source first, and organizations can contribute features they need rather than waiting for vendor roadmaps.

Understanding what open-source software is and why it has become so widely adopted provides essential context for exploring the concerns organizations must address when implementing open-source components, which the next unit covers.
