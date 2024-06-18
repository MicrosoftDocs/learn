GitHub runners are compute resources that execute GitHub Actions workflows. Each runner can run a single job at a time. They allow developers to perform build, test, and deployment tasks directly within from GitHub repositories. There are two main types of GitHub runners:

 -  GitHub-hosted runners are virtualized or containerized compute resources provided and managed by GitHub.
 -  Self-hosted runners are physical, virtualized, or containerized compute resources that GitHub users and organizations provision and manage themselves.

Each type has some unique characteristics, features a number of distinct capabilities, and warrants several different considerations.

It is important to note that GitHub strongly recommends against using self-hosted runners in public repos. Doing so introduces a significant security risk, since it potentially allows anyone to run code within the organization's private environment.

## GitHub-hosted runners

GitHub-hosted runners offer a convenient solution for executing workflows within GitHub Actions, eliminating the need to administer the underlying hardware and software components. They are designed to scale automatically based on demand, ensuring optimal performance during peak usage periods. GitHub provides several pre-configured environments for GitHub-hosted runners, covering different software configurations and operating systems, including Ubuntu Linux, Microsoft Windows, and macOS.

GitHub-hosted runners include the operating system's default built-in tools. For example, Ubuntu and macOS runners include grep, find, and which. To identify all other tools preinstalled on runners, users can review the software bill of materials (SBOM) for each build of the Windows and Ubuntu runner images. Alternatively, users can review the Runner Image subsection of the Set up job section in workflow logs. The link following the Included Software entry describes all preinstalled tools on the runner that ran the workflow. It is also possible to install additional software on GitHub-hosted runners by creating a job that installs the packages as part of the existing workflow.

GitHub-hosted runners run on GitHub's cloud infrastructure, leveraging virtual machines or containers to execute workflows. Each workflow execution is isolated within its own environment, ensuring security and reproducibility. GitHub-hosted runners seamlessly integrate with GitHub Actions, enabling users to reference them directly within workflows hosted in GitHub repositories.

There are some limits on GitHub Actions usage when using GitHub-hosted runners. In particular, each job in a workflow has the maximum of 6 hours of execution time. If a job reaches this limit, the job is terminated and fails to complete. Each workflow run is limited to 35 days. If a workflow run reaches this limit, its run gets canceled. This period includes execution duration, and time spent on waiting and approval.

### Prerequisites

Before implementing GitHub-hosted runners, users must have a GitHub repository where they can define workflows using GitHub Actions. Runners are available to all GitHub users with access to GitHub Actions.

### Implementation

Unlike self-hosted runners, GitHub-hosted ones are provisioned automatically as part of an individual workflow execution. Users define workflows as YAML-formatted files stored in the .github/workflows directory in GitHub repositories. Within the workflow configuration, users specify the desired runner environment, including the operating system and software dependencies. Runners with matching specifications are set up on demand whenever the workflow is triggered, with one runner per job. Triggers can be either manual or automatic, based on such events as code pushes, pull requests, or repository dispatch events.<br>GitHub-hosted runners authenticate with GitHub by using tokens or credentials provided by GitHub Actions. They rely on built-in connectivity to communicate with the GitHub platform and to download workflow artifacts.

### Maintenance

GitHub manages updates and maintenance of GitHub-hosted runners, ensuring that they remain up-to-date with the latest software versions and security patches. The software tools included in the runners are updated weekly. Runner activities are monitoring and logged, facilitating tracking workflow executions and troubleshooting.

### Licensing and Cost

GitHub-hosted runners are included in the pricing for GitHub Actions, with usage-based billing for workflow minutes beyond the free tier. Users benefit from the automated and cost-efficient scaling, as GitHub automatically provisions and deallocates runners based on demand.

## Self-hosted runners

Compared to GitHub-hosted runners, self-hosted ones provide greater control and customization options, with execution environments capable of accommodating a wider range of requirements. They can be deployed on-premises or in the cloud, depending on such criteria as network connectivity, cost, and resource availability.

Self-hosted runners are provisioned and managed by users, giving them full control over the execution environment. They are fully customizable, including hardware specifications, software configurations, and network settings. They also facilitate integration with existing infrastructure and tooling, minimizing the possibility of compatibility and interoperability issues.

Unlike with GitHub-hosted runners, there are no limits on the time it takes to complete individual job execution and workflow runs.

### Prerequisites

Users must set up and configure self-hosted runners on their chosen infrastructure, including installing the runner software and any additional software dependencies. The source code for the self-hosted runners is available as an open-source project on GitHub at [https://github.com/actions/runner](https://github.com/actions/runner). Each self-hosted runner acts as an agent that communicates with GitHub Actions to execute workflows.

Self-hosted runners require outbound network connectivity, authentication credentials, and authorization to access the GitHub platform and download workflow artifacts. Depending on the location of the runners, it might be necessary to configure firewall rules to satisfy these requirements.

### Implementation

As with GitHub-hosted runners, the implementation involves defining YAML-formatted workflows and storing them the .github/workflows directory in GitHub repositories. However, in order for workflows to use self-hosted runners, users need to register them first, providing the required authentication tokens or credentials. As part of the registration, users specify such characteristics as the runner name, labels, and execution environment parameters.

The registration can take place at different levels within an enterprise:

 -  Repository-level (single repository)
 -  Organizational-level (multiple repositories in an organization)
 -  Enterprise-level (multiple organizations across an enterprise)

### Maintenance

Users are responsible for updating and maintaining self-hosted runners, including installing software updates and security patches. Maintenance also involves monitoring runner health and performance, as well as troubleshooting any issues that arise throughout the runner runtime.

### Licensing and cost

Self-hosted runners do not incur additional licensing charges beyond the pricing for GitHub Actions and any associated infrastructure costs, including compute, storage, and network. Optimizing resource allocation and utilization become the user's responsibility.<br>
