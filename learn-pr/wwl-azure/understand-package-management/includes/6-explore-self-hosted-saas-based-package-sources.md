**Private package sources** provide controlled access to packages that should be available to a select audience. The following options will give you a starting point for finding the most relevant feeds for your organization.

## Private feeds

**Private feeds** can be used where packages should be available to a select audience rather than the public.

**Key difference:** The main difference between public and private feeds is the need for **authentication**.

- **Public feeds:** Can be anonymously accessible and optionally authenticated.
- **Private feeds:** Can be accessed only when authenticated with proper credentials.

**When to use private feeds:**

- **Proprietary code:** Internal libraries containing business logic or intellectual property.
- **Company-specific packages:** Components developed for internal use.
- **Pre-release packages:** Beta or experimental packages not ready for public consumption.
- **Security requirements:** Packages with security or compliance restrictions.
- **Licensing restrictions:** Commercial packages with licensing limitations.

## Options for private feeds

There are two primary options for hosting private feeds:

### 1. Self-hosting

Some of the package managers are also able to host a feed. One can host the required solution to offer a private feed using **on-premises** or **private cloud resources**.

**Advantages:**

- **Full control:** Complete control over infrastructure and configuration.
- **Data sovereignty:** Keep packages within your own network or data center.
- **Customization:** Customize features to meet specific organizational needs.
- **Integration:** Integrate with existing on-premises systems and authentication.

**Disadvantages:**

- **Maintenance overhead:** Requires infrastructure, updates, and operational support.
- **Initial setup cost:** Time and resources needed for deployment.
- **Scalability:** Must manage scaling and performance yourself.
- **Backup and recovery:** Responsible for disaster recovery and backups.

### 2. SaaS services

A variety of third-party vendors and cloud providers offer **software-as-a-service** feeds that can be kept private. It typically requires a consumption fee or a cloud subscription.

**Advantages:**

- **Managed service:** Infrastructure and maintenance handled by provider.
- **Scalability:** Automatically scales with usage.
- **Quick setup:** Deploy feeds in minutes without infrastructure.
- **Updates included:** Automatic updates and feature improvements.
- **High availability:** Built-in redundancy and disaster recovery.

**Disadvantages:**

- **Ongoing costs:** Monthly or usage-based fees.
- **Less control:** Limited customization compared to self-hosted.
- **Vendor dependency:** Rely on provider's availability and roadmap.
- **Data location:** Packages stored in provider's infrastructure.

## Private package sources by type

The following table contains a non-exhaustive list of self-hosting options and SaaS offerings to host private package feeds for each type covered.

| **Package Type** | **Self-Hosted Private Feed**          | **SaaS Private Feed**                                                                                    |
| ---------------- | ------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| **NuGet**        | NuGet Server, BaGet, Sleet            | Azure Artifacts, MyGet, GitHub Packages                                                                  |
| **npm**          | Sinopia, cnpmjs, Verdaccio            | npmjs (private packages), MyGet, Azure Artifacts, GitHub Packages                                        |
| **Maven**        | Nexus, Artifactory, Archiva           | Azure Artifacts, JFrog Cloud, GitHub Packages                                                            |
| **Docker**       | Docker Registry, Harbor, Portus, Quay | Azure Container Registry, Docker Hub, Amazon Elastic Container Registry (ECR), Google Container Registry |
| **Python**       | PyPI Server, devpi                    | Gemfury, Azure Artifacts, AWS CodeArtifact                                                               |

## Popular solutions

### Multi-format solutions

Some solutions support multiple package types in a single platform:

#### Nexus Repository Manager

- **Supported formats:** Maven, npm, NuGet, Docker, PyPI, and more.
- **Deployment:** Self-hosted (OSS and Pro versions).
- **Features:** Repository management, security scanning, access control.

#### JFrog Artifactory

- **Supported formats:** Maven, Gradle, npm, NuGet, Docker, PyPI, and more.
- **Deployment:** Self-hosted and cloud (JFrog Cloud).
- **Features:** Universal artifact repository, build integration, binary management.

#### Azure Artifacts

- **Supported formats:** NuGet, npm, Maven, Python, Universal Packages.
- **Deployment:** SaaS (Azure DevOps).
- **Features:** Integrated with Azure DevOps, upstream sources, feed views, access control.

#### GitHub Packages

- **Supported formats:** npm, NuGet, Maven, Gradle, Docker, RubyGems.
- **Deployment:** SaaS (GitHub).
- **Features:** Integrated with GitHub repositories, workflow integration, scoped packages.

### Docker-specific solutions

#### Harbor

- **Type:** Self-hosted container registry.
- **Features:** Vulnerability scanning, image signing, replication, RBAC.
- **Best for:** Kubernetes environments, enterprise container management.

#### Azure Container Registry (ACR)

- **Type:** SaaS container registry.
- **Features:** Geo-replication, integrated security scanning, Azure integration.
- **Best for:** Azure-based applications, AKS integration.

## Choosing between self-hosted and SaaS

Consider these factors when deciding:

| **Factor**        | **Self-Hosted**               | **SaaS**                  |
| ----------------- | ----------------------------- | ------------------------- |
| **Control**       | Full control                  | Limited control           |
| **Cost model**    | Upfront + ongoing maintenance | Subscription-based        |
| **Setup time**    | Days to weeks                 | Minutes to hours          |
| **Maintenance**   | Your responsibility           | Provider handles          |
| **Scalability**   | Manual scaling                | Automatic scaling         |
| **Customization** | Highly customizable           | Limited customization     |
| **Data location** | Your infrastructure           | Provider's infrastructure |

**Hybrid approach:** Many organizations use a combination:

- **SaaS for development:** Quick setup, low maintenance for development teams.
- **Self-hosted for production:** Greater control and security for production artifacts.
