SQL Server 2025 introduces deployment, edition, and licensing options that support hybrid, cloud-native, and AI scenarios. This unit explores deployment methods, containerization features, and differences from earlier versions.

## Choose deployment options for SQL Server 2025

SQL Server 2025 expands deployment flexibility, supporting Windows and Linux operating systems, virtual machines, and a wide range of cloud platforms. New in this release are advanced containerization features, improved orchestration for Kubernetes and Azure Arc, and seamless integration with Azure for hybrid and multicloud scenarios.

Key deployment enhancements in SQL Server 2025 include:

- **Enhanced containerization**: Native support for containerized deployments with improved scalability, security, and orchestration using Kubernetes, Azure Arc, and other cloud-native tools.
- **Cloud-native options**: Deploy SQL Server 2025 as a fully managed service in Azure, or in hybrid environments with unified management and monitoring.
- **Immutable infrastructure**: Support for immutable deployments and automated scaling, making it easier to manage and update SQL Server instances in DevOps and CI/CD pipelines.
- **Simplified provisioning**: Streamlined setup and configuration for both on-premises and cloud environments, with unified tooling and improved upgrade paths.

SQL Server 2025 is supported on the latest versions of Windows and Linux, and is available through Azure Marketplace images, container registries, and traditional installation methods.

## Compare editions of SQL Server 2025

SQL Server 2025 offers editions to meet different requirements, with updates to support new features and deployment models:

| Edition | Purpose | Key Limitations | Production Use |
|---------|---------|-----------------|----------------|
| Evaluation | Feature testing | 180-day limit | No |
| Developer | Development and testing | None (feature-wise) | No |
| Express | Basic applications | CPU, memory, database size limits | Yes |
| Web | Web applications | Limited to web workloads | Yes |
| Standard | General business use | Feature limitations | Yes |
| Enterprise | Mission-critical systems | None | Yes |

For a full list of capabilities for each edition, see [What's new in SQL Server 2025](/sql/sql-server/what-s-new-in-sql-server-2025).

## Understand licensing for sql server 2025

SQL Server 2025 paid editions are licensed per core, with options for Software Assurance (SA), and expanded support for pay-as-you-go and consumption-based models in Azure and hybrid environments.

## Identify feature differences from previous releases

SQL Server 2025 includes these key changes from previous releases:

- AI-powered analytics and built-in machine learning integration
- Advanced cloud-connected and hybrid capabilities
- Intelligent query processing and performance improvements
- Enhanced security, compliance, and data protection
- Expanded data virtualization and support for S3-compatible object storage
- New T-SQL language features and developer productivity tools

> [!TIP]
> Stay up to date with all the latest release notes at [SQL Server 2025 release notes](/sql/sql-server/sql-server-2025-release-notes).

### Features removed or deprecated in SQL Server 2025

The following features are deprecated in SQL Server 2025:

- Legacy PolyBase Hadoop connectivity and scale-out groups (replaced by modern connectors and virtualization)
- Machine Learning Server and bundled R/Python/Java runtimes (use external packages and services)
- Distributed Replay (removed from setup)
- Stretch Database (deprecated, to be removed in a future version)
- Some legacy security and management features replaced by new unified management and compliance tools

> [!TIP]
> Review the [SQL Server feature comparison](/sql/sql-server/editions-and-components-of-sql-server-2025) documentation to understand detailed capabilities of each feature across editions.

## Enable preview features

SQL Server 2025 provides a preview feature option to test upcoming capabilities before they become generally available. By enabling this option, you can experiment with innovations like vector indexing, enhanced text chunking, and change event streaming—without affecting your production workloads. This approach gives you the flexibility to test and evaluate new features in a safe, isolated way, bringing agility to your on-premises environment.

Unlike traditional trace flags, which are mainly for debugging and affect the whole server, the preview feature switch is set at the database level. This means you can enable preview features for specific databases, allowing targeted experimentation while keeping the rest of your environment stable. Preview features are intended for evaluation and shouldn't be used in production, but the core database remains fully supported and stable even when preview features are enabled.

> [!IMPORTANT]
> Preview features are not intended for production environments and may change before final release. Use them only in development or test environments.