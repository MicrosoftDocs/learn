GitHub runners are the compute environments that execute your GitHub Actions workflows. Understanding runners is crucial for optimizing performance, managing costs, and ensuring security in your CI/CD pipelines.

## Runner types overview

GitHub provides two distinct runner options, each suited for different scenarios:

### GitHub-hosted runners

- **Managed by GitHub**: Fully maintained and updated by GitHub
- **On-demand scaling**: Automatically provisioned for each job
- **Multiple environments**: Ubuntu, Windows, and macOS available
- **Built-in tools**: Pre-installed with common development tools
- **Usage-based billing**: Pay only for what you use

### Self-hosted runners

- **Managed by you**: Full control over the environment and configuration
- **Custom environments**: Install any software or hardware configuration needed
- **Private infrastructure**: Runs on your own machines or cloud instances
- **No time limits**: Jobs can run as long as needed
- **Fixed costs**: No per-minute charges after setup

## Security considerations

**Important Security Warning**: Never use self-hosted runners with public repositories. This creates a serious security vulnerability where malicious actors could execute code on your infrastructure through pull requests.

**Safe usage patterns**:

- Use self-hosted runners only with private repositories
- Implement proper network isolation and monitoring
- Regularly update runner software and dependencies
- Use dedicated machines that don't contain sensitive data

## GitHub-hosted runners

GitHub-hosted runners provide a zero-maintenance solution for running your workflows. GitHub handles all the infrastructure management, allowing you to focus on your code rather than server administration.

### Available environments

GitHub offers several runner types with different specifications:

| Runner Type      | OS Version          | Processor  | RAM   | Storage   |
| ---------------- | ------------------- | ---------- | ----- | --------- |
| `ubuntu-latest`  | Ubuntu 22.04        | 4-core CPU | 16 GB | 14 GB SSD |
| `windows-latest` | Windows Server 2022 | 4-core CPU | 16 GB | 14 GB SSD |
| `macos-latest`   | macOS 14            | 4-core CPU | 14 GB | 14 GB SSD |
| `macos-13`       | macOS 13            | 4-core CPU | 14 GB | 14 GB SSD |

### Pre-installed software

Each runner comes with a comprehensive set of development tools:

**Common tools across all platforms:**

- Git, Docker, Node.js, Python, Java, .NET
- Package managers (npm, pip, Maven, NuGet)
- Build tools and compilers
- Testing frameworks

**Platform-specific tools:**

- **Ubuntu**: `apt`, `snap`, various Linux utilities
- **Windows**: PowerShell, Visual Studio Build Tools, Windows SDK
- **macOS**: Xcode, Homebrew, CocoaPods

**Pro tip**: Check the complete software inventory at the [runner images repository](https://github.com/actions/runner-images) or view the "Set up job" section in your workflow logs.

### Usage limits and considerations

Understanding these limits helps you plan your workflows effectively:

- **Job timeout**: 6 hours maximum per job
- **Workflow timeout**: 35 days maximum (including wait time)
- **Concurrent jobs**: Varies by GitHub plan (20 for Free, 180 for Pro)
- **Storage**: 500 MB artifact storage per job

### Prerequisites

Before using GitHub-hosted runners, users must have a GitHub repository where they can define workflows using GitHub Actions. Runners are available to all GitHub users with access to GitHub Actions.

### Setup

Unlike self-hosted runners, GitHub-hosted ones are set up automatically as part of an individual workflow execution. Users define workflows as YAML-formatted files stored in the .github/workflows directory in GitHub repositories. Within the workflow configuration, users specify the desired runner environment, including the operating system and software dependencies. Runners with matching specifications are set up on demand whenever the workflow is triggered, with one runner per job. Triggers can be either manual or automatic, based on such events as code pushes, pull requests, or repository dispatch events.<br>GitHub-hosted runners authenticate with GitHub by using tokens or credentials provided by GitHub Actions. They rely on built-in connectivity to communicate with the GitHub platform and to download workflow artifacts.

### Maintenance

GitHub manages updates and maintenance of GitHub-hosted runners, ensuring that they remain up-to-date with the latest software versions and security patches. The software tools included in the runners are updated weekly. Runner activities are monitoring and logged, facilitating tracking workflow executions and troubleshooting.

### Licensing and Cost

GitHub-hosted runners are included in the pricing for GitHub Actions, with usage-based billing for workflow minutes beyond the free tier. Users benefit from the automated and cost-efficient scaling, as GitHub automatically provisions and deallocates runners based on demand.

## Self-hosted runners

Self-hosted runners give you complete control over your execution environment. They're ideal when you need specific hardware, software configurations, or want to reduce costs for high-volume workflows.

### When to use self-hosted runners

**Perfect for:**

- **Specific hardware requirements**: GPU acceleration, high memory, or custom processors
- **Private network access**: Connect to internal databases, APIs, or services
- **Custom software**: Pre-installed proprietary tools or specific software versions
- **Cost optimization**: High-volume workflows where per-minute billing becomes expensive
- **Compliance requirements**: Data must stay within your infrastructure

**Not recommended for:**

- Public repositories (security risk)
- Occasional or low-volume workflows
- Teams without infrastructure management experience

### Deployment options

You can run self-hosted runners on various platforms:

- **Physical servers**: On-premises hardware
- **Virtual machines**: VMware, Hyper-V, or other hypervisors
- **Cloud instances**: AWS EC2, Azure VMs, Google Compute Engine
- **Containers**: Docker containers (with limitations)
- **Kubernetes**: Using the Actions Runner Controller

### Setup process

Setting up a self-hosted runner involves these key steps:

1. **Download the runner application** from [GitHub's runner repository](https://github.com/actions/runner)
2. **Configure the runner** with authentication tokens
3. **Install as a service** (recommended for production)
4. **Configure labels** to target specific runners in workflows

**Network requirements:**

- Outbound HTTPS (443) access to GitHub.com
- Outbound HTTPS (443) access to objects.githubusercontent.com
- No inbound connections required

### Runner scopes and management

Self-hosted runners can be registered at different organizational levels:

| Scope            | Access Level              | Use Case                              |
| ---------------- | ------------------------- | ------------------------------------- |
| **Repository**   | Single repository only    | Development/testing environments      |
| **Organization** | All repos in organization | Shared team resources                 |
| **Enterprise**   | All orgs in enterprise    | Centralized infrastructure management |

### Targeting runners in workflows

Use labels to specify which runner should execute your job:

```yaml
jobs:
  build:
    runs-on: [self-hosted, linux, x64, gpu]
    steps:
      - name: Build with GPU acceleration
        run: ./build-with-cuda.sh
```

### Maintenance responsibilities

As the runner owner, you're responsible for:

- **Security updates**: Keep the runner application and OS updated
- **Software management**: Install and maintain required development tools
- **Monitoring**: Track runner health and performance metrics
- **Capacity planning**: Scale runners based on workflow demands
- **Backup and recovery**: Ensure runner configurations are backed up

### Cost considerations

While self-hosted runners don't incur GitHub Actions minutes charges, consider these costs:

- **Infrastructure**: Servers, cloud instances, or container orchestration
- **Maintenance**: Time spent on updates, monitoring, and troubleshooting
- **Security**: Additional tools and processes for secure runner management
- **Power and cooling**: For on-premises deployments

**Cost optimization tips:**

- Use autoscaling for cloud-based runners
- Implement runner pooling for multiple repositories
- Schedule runners to shut down during off-hours
- Monitor resource utilization to right-size instances
