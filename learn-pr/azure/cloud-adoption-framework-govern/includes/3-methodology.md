Implementing proper cloud governance requires proper business policy, protective guardrails, and skilled people taking a consistent, disciplined approach to governance. 

## Building governance maturity

This unit explains the four-step process in the Cloud Adoption Framework (CAF) to build a mature cloud governance solution.

- **Methodology:** Understand the underlying methodology.
- **Governance benchmark:** Assess your current and future state needs.
- **Governance foundation:** Establish your governance foundation with a set of governance tools.
- **Mature governance disciplines:** Iteratively add governance controls to address risks.

The steps will get you started with the Govern methodology in the cloud. They will also set you on a path to mature each governance discipline as your cloud adoption plan progresses.

## Govern methodology

The Govern methodology provides a structured approach to building the governance maturity required to be confident with cloud adoption.

:::image type="content" source="../media/methodology.png" alt-text="The CAF Govern methodology outlined in this section of content." border="false":::

_Figure 1: The CAF Govern methodology outlined in this section._

### Corporate policy

Governance is a big, intimidating topic. Establish proper scope by mitigating tangible risks through corporate policy. Corporate policies drive cloud governance. Proper corporate policy requires three components:

- **Business Risk:** Identify and understand tangible corporate risks and the organization's tolerance for risk.
- **Policy and compliance:** Convert risks into clear policy statements that support compliance requirements without defining specific technical dependencies.
- **Process:** Establish processes to monitor violations and ensure adherence to policy statements.

A focus on these steps will help develop clear and actionable corporate policies. The next unit will go deeper into how to develop a proper corporate policy.

### Governance disciplines

These disciplines support the corporate policies through a mixture of tools and human processes. Each discipline protects the company from defined and specific potential pitfalls:

- **Cost Management:** Optimize costs across a broad portfolio of workloads through the application of budgets, reports, and automated enforcement.
- **Security Baseline:** Apply well-defined security requirements to all supported environments and underlying workloads.
- **Resource Consistency:** Manage resource configuration at scale to ensure that all deployed assets are discoverable, recoverable, and on-boarded into operation management processes.
- **Identity Baseline:** Ensure proper authentication and access by applying roles and assignments to each environment.
- **Deployment Acceleration:** Standardize and centralize deployment templates to ensure consistency across all environments and workloads.

Each of these disciplines will accelerate the application of corporate policies and ensure consistent governance. Later in this module, we'll investigate actionable implementation of each discipline.

## Governance Benchmark

The CAF provides a [Governance Benchmark Tool](https://cafbaseline.com/?azure-portal=true) to help you identify gaps in your organization across the governance disciplines and corporate policy maturity.

:::image type="content" source="../media/benchmark.png" alt-text="Visual of a governance benchmark output showing areas for improvement and a comparison between current-state and future-state governance requirements." border="false":::
_Figure 2: A governance benchmark output showing areas for improvement and a comparison between current- and future-state governance requirements._

Receive a personalized report that outlines the difference between your current state and business priorities, along with tailored resources to help you start assessing your current and future states and establish a vision for applying the framework.

## Governance foundation

Azure includes a suite of governance tools built on top of the Azure Resource Manager platform. The initial governance foundation demonstrates how these tools can be applied to demonstrate cloud governance. As you progress through units of this learn module, you'll learn how to apply these tools to solve governance challenges. First, start with a governance foundation to familiarize yourself with the tools.

:::image type="content" source="../media/3-tdd-in-azure.png" alt-text="Visual of the Azure Resource Manager tools that support governance, with focus on Azure Policy and Azure Blueprints." border="false":::
_Figure 3: The Azure Resource Manager tools that support governance, with focus on Azure Policy and Azure Blueprints._

Subsequent units of this learn module will apply these tools to create a governance foundation for Tailwind Traders.

The CAF contains two different examples of initial governance foundations to apply a sound foundation for governance to new or existing deployments. Each provides a different approach to support your business needs when getting started:

- [Standard governance guide](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/guides/standard?azure-portal=true): A guide for most organizations that's based on the recommended initial two-subscription model and designed for deployments in multiple regions while not spanning public and sovereign/government clouds.
- [Governance guide for complex enterprises](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/guides/complex?azure-portal=true): A guide for enterprises that are managed by multiple independent IT business units or span public and sovereign/government clouds.

## Mature governance disciplines

The governance foundation will introduce you to the tools needed to implement proper governance. To achieve sustainable governance, you will need to apply guardrails for each governance discipline. To be clearer and more effective, teams should start with a single discipline and expand over time. The following table can help mature the the disciplines needed to meet specific business objectives:

| Risk/need | Standard enterprise | Complex enterprise |
|---|---|---|
| Sensitive data in the cloud | [Discipline improvement](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/guides/standard/security-baseline-improvement?azure-portal=true) | [Discipline improvement](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/guides/complex/security-baseline-improvement?azure-portal=true) |
| Mission-critical applications in the cloud | [Discipline improvement](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/guides/standard/resource-consistency-improvement?azure-portal=true) | [Discipline improvement](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/guides/complex/resource-consistency-improvement?azure-portal=true) |
| Cloud cost management | [Discipline improvement](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/guides/standard/cost-management-improvement?azure-portal=true) | [Discipline improvement](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/guides/complex/cost-management-improvement?azure-portal=true) |
| Multicloud | [Discipline improvement](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/guides/standard/multicloud-improvement?azure-portal=true) | [Discipline improvement](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/guides/complex/multicloud-improvement?azure-portal=true) |
| Complex/legacy identity management | N/A | [Discipline improvement](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/guides/complex/identity-baseline-improvement?azure-portal=true) |
| Multiple layers of governance | N/A | [Discipline improvement](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/guides/complex/multiple-layers-of-governance?azure-portal=true) |

Later in this module, we'll discuss each discipline from the Cloud Adoption Framework Governance methodology and relate them to Tailwind Traders' customer narrative.
