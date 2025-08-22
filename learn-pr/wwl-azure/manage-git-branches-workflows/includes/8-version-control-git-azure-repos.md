## Hands-On Git Mastery with Azure Repos

**Estimated completion time:** 60 minutes

### Strategic Learning Context

This comprehensive lab experience demonstrates enterprise-grade Git workflows within Azure DevOps, providing practical experience with the concepts and techniques covered throughout this module. You'll implement real-world scenarios that mirror enterprise development practices while building foundational skills in Git branch management.

## Azure DevOps Version Control Strategy

Azure DevOps supports two distinct version control paradigms, each optimized for different organizational needs:

### Team Foundation Version Control (TFVC): Centralized Legacy Model

- **Centralized architecture**: Single server-based repository with exclusive file locking
- **Limited local capabilities**: Minimal offline functionality requiring constant server connectivity
- **Path-based branching**: Server-side branch creation with hierarchical organization
- **Enterprise legacy support**: Ideal for organizations transitioning from traditional centralized systems

### Git: Modern Distributed Excellence

- **Distributed architecture**: Complete local repositories with full history and capabilities
- **Offline productivity**: Complete version control operations without network connectivity
- **Flexible branching**: Local and remote branch creation with sophisticated merge strategies
- **Industry standard**: Preferred choice for modern development workflows and cloud-native practices

> [!IMPORTANT] > **Strategic Recommendation**: Git serves as the default version control provider for new Azure DevOps projects. Choose Git unless your organization specifically requires TFVC's centralized features for legacy system integration.

### Learning Objectives and Enterprise Skills

Upon completing this hands-on laboratory, you will demonstrate proficiency in:

- **Repository synchronization**: Clone existing repositories and establish local development environments
- **Commit lifecycle management**: Save work with atomic commits and comprehensive history tracking
- **Historical analysis**: Review change history for debugging, compliance, and code archaeology
- **Advanced branch operations**: Implement sophisticated branching strategies using Visual Studio Code

These objectives align with enterprise development practices and provide immediately applicable skills for professional software development environments.

## Prerequisites and Environment Setup

### Technical Requirements

Ensure your development environment includes the following enterprise-standard tools:

- **Microsoft Edge** or any [Azure DevOps-supported browser](/azure/devops/server/compatibility) for web interface interaction
- **Azure DevOps organization**: Create your organization following [Microsoft's official guidance](/azure/devops/organizations/accounts/create-organization) if you don't have access to an existing one
- **Git 2.44.0 or later**: Download from the [official Git for Windows page](https://gitforwindows.org/) for optimal Azure DevOps integration
- **Visual Studio Code**: Install from the [official download page](https://code.visualstudio.com/) for modern Git workflow management
- **C# extension**: Add the [C# extension](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp) for comprehensive development capabilities

### Enterprise Development Context

This lab environment mirrors real-world enterprise development scenarios, where teams collaborate on shared codebases using sophisticated version control workflows. The combination of Visual Studio Code and Azure DevOps represents industry-standard tooling for modern software development teams.

## Laboratory Exercise Structure

This comprehensive hands-on experience consists of four progressive exercises designed to build enterprise-ready Git proficiency:

### Exercise 0: Environment Preparation and Configuration

Establish your development environment with proper tooling and Azure DevOps integration, ensuring optimal setup for professional development workflows.

### Exercise 1: Repository Cloning and Local Setup

Master the process of cloning existing repositories, establishing local development environments, and configuring remote synchronization for team collaboration.

### Exercise 2: Commit Lifecycle and Change Management

Implement professional commit practices including atomic changes, descriptive messaging, and proper staging workflows that support code review and project history maintenance.

### Exercise 3: Historical Analysis and Code Archaeology

Develop skills in reviewing change history, understanding code evolution, and leveraging Git's powerful history tools for debugging and compliance purposes.

### Exercise 4: Advanced Branch Operations and Workflow Implementation

Practice sophisticated branching strategies using Visual Studio Code's integrated Git capabilities, preparing you for complex enterprise development scenarios.

### Access Your Lab Environment

[:::image type="content" source="../media/launch-exercise-25d42425.png" alt-text="Screenshot of a launch button, which will take you to the lab.":::
](https://go.microsoft.com/fwlink/?linkid=2269558)

This hands-on laboratory provides a safe, guided environment for experimenting with Git workflows while building practical skills directly applicable to enterprise software development. The exercises progress from fundamental operations to advanced branching scenarios, ensuring comprehensive understanding of modern version control practices.
