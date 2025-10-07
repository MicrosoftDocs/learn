This module explored Infrastructure as Code (IaC) and Configuration as Code foundational concepts that enable modern DevOps practices. You learned how treating infrastructure like software code—with version control, automated testing, and continuous deployment—transforms infrastructure management from manual, error-prone processes to reliable, automated operations.

## Key takeaways

**Infrastructure as Code:**

- Treats infrastructure as version-controlled code rather than manual configurations
- Enables "cattle not pets" approach—easily replaceable infrastructure
- Provides consistency, auditability, and rapid provisioning
- Tools: Azure Resource Manager, Bicep, Terraform, Ansible

**Configuration Management:**

- Automates application and environment configuration
- Reduces documentation burden—code IS the documentation
- Enables drift detection and automatic correction
- Prevents "works on my machine" problems

**Declarative vs. Imperative:**

- **Declarative:** Specify _what_ you want (easier, idempotent by design)
- **Imperative:** Specify _how_ to get there (more control, familiar to developers)
- Many teams use both—declarative for provisioning, imperative for configuration

**Idempotency:**

- Same operation produces same result regardless of how many times you run it
- Essential for cloud auto-scaling, recovery, and automation
- Prevents errors from re-running scripts or failed deployments

## Next steps

Now that you understand IaC fundamentals, you can:

- Implement version-controlled infrastructure definitions
- Choose appropriate declarative or imperative approaches for your scenarios
- Design idempotent scripts ensuring consistent, reliable deployments
- Build automated infrastructure pipelines with confidence

## Learn more

- [Create target environment - Azure Pipelines \| Microsoft Learn](/azure/devops/pipelines/process/environments)
- [Integrate DevTest Labs environments into Azure Pipelines \| Microsoft Learn](/azure/devtest-labs/integrate-environments-devops-pipeline)
- [What is Infrastructure as Code? - Azure DevOps \| Microsoft Learn](/devops/deliver/what-is-infrastructure-as-code)
- [Repeatable Infrastructure - Azure Architecture Center \| Microsoft Learn](/azure/architecture/framework/devops/automation-infrastructure)
- [Infrastructure as code \| Microsoft Learn](/dotnet/architecture/cloud-native/infrastructure-as-code)
