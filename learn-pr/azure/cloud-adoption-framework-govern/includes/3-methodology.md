Implementing proper cloud governance requires proper business policy, protective guardrails, and skilled people taking a consistent, disciplined approach to governance.

## Build governance maturity

This unit explains the four-step process in the Cloud Adoption Framework to build a mature cloud-governance solution:

1. **Methodology**: Understand the underlying methodology
1. **Governance benchmark**: Assess your current-state and future-state needs
1. **Governance foundation**: Establish your governance foundation by using a set of governance tools
1. **Mature governance disciplines**: Iteratively add governance controls to address risks

These steps get you started using the Govern methodology in the cloud. They also set you on a path to mature governance discipline as your cloud adoption plan progresses.

## Govern methodology

The Govern methodology provides a structured approach to building the governance maturity that's required for confidence in cloud adoption.

:::image type="content" source="../media/methodology.png" alt-text="Image that identifies the five disciplines of cloud governance and the components of the corporate policy process." border="false":::

*Figure 1: The Govern methodology: define corporate policy and the five disciplines of cloud governance.*

## Corporate policy

*Governance* is a large subject, and it might be intimidating at first. Governance seeks to establish the proper scope of corporate actions by mitigating tangible risks through corporate policy.

Corporate policies drive cloud governance. Proper corporate policy consists of three components:

- **Business risk**: Identify and understand tangible corporate risks and the organization's tolerance for risk.
- **Policy and compliance**: Convert risks into clear policy statements that support compliance requirements without defining specific technical dependencies.
- **Process**: Establish processes to monitor violations and ensure adherence to policy statements.

A focus on these components helps develop clear and actionable corporate policies. In the next unit, you'll see how to develop a proper corporate policy.

## Governance disciplines

Governance disciplines support corporate policies through a mixture of tools and human processes. Each of the following disciplines protects the organization from specific, defined potential pitfalls:

- **Cost Management discipline**: Optimize costs across a broad portfolio of workloads through the application of budgets, reports, and automated enforcement.
- **Security Baseline discipline**: Apply well-defined security requirements to all supported environments and underlying workloads.
- **Resource Consistency discipline**: Manage resource configuration at scale to ensure that all deployed assets are discoverable, recoverable, and onboarded into operation management processes.
- **Identity Baseline discipline**: Ensure proper authentication and access by applying roles and assignments to each environment.
- **Deployment Acceleration discipline**: Standardize and centralize deployment templates to ensure consistency across all environments and workloads.

Each discipline accelerates the application of corporate policies and ensures consistent governance. Later in this module, we investigate an actionable implementation for each discipline.

## Governance benchmark tool

The Cloud Adoption Framework provides a [governance benchmark tool](/azure/cloud-adoption-framework/govern/benchmark#governance-benchmark-tool?azure-portal=true) to help you identify gaps in the governance disciplines and corporate policy in your organization.

:::image type="content" source="../media/benchmark.png" alt-text="Image of a computer monitor that displays a line chart and a pie chart in a results webpage from the Cloud Adoption Framework benchmark tool." border="false":::

*Figure 2: A governance benchmark output that shows areas for improvement and a comparison between current state and future state governance requirements.*

You can use the governance benchmark tool for a personalized report that outlines the difference between your current state and business priorities, along with tailored resources to help you start assessing your current state and future state and establish a vision for applying the framework.

## Governance foundation

Azure includes a suite of governance tools that are built on top of the Azure Resource Manager platform. The initial governance foundation demonstrates how you can apply these tools to demonstrate cloud governance. As you progress through the units of this module, you learn how to apply these tools to solve governance challenges. First, start with a governance foundation to familiarize yourself with the tools.

:::image type="content" source="../media/3-tdd-in-azure.png" alt-text="Image of the Azure Resource Manager tools that support governance, with a focus on Azure Policy and Azure Blueprints." border="false":::

*Figure 3: The Azure Resource Manager tools that support governance, with a focus on Azure Policy and Azure Blueprints.*

In later units, you apply these tools to create a governance foundation for Tailwind Traders.

The Cloud Adoption Framework contains two ways to apply a sound foundation for governance to new or existing deployments. Each provides a different approach to support your business needs when you get started:

- [Standard governance guide](/azure/cloud-adoption-framework/govern/guides/standard/?azure-portal=true): A guide for most organizations that's based on the recommended initial two-subscription model, and designed for deployments in multiple regions while not spanning public and sovereign/government clouds
- [Governance guide for complex enterprises](/azure/cloud-adoption-framework/govern/guides/complex/?azure-portal=true): A guide for enterprises that are managed by multiple independent IT business units or span public and sovereign/government clouds

## Mature governance disciplines

A governance foundation introduces you to tools that are needed to implement proper governance. To achieve sustainable governance, you need to apply guardrails for each governance discipline. To be more precise and more effective, teams should start with a single discipline and expand over time. The following table can help mature the disciplines that are needed to meet specific business objectives:

| Risk/need | Standard enterprise | Complex enterprise |
|---|---|---|
| Sensitive data in the cloud | [Discipline improvement](/azure/cloud-adoption-framework/govern/guides/standard/security-baseline-improvement?azure-portal=true) | [Discipline improvement](/azure/cloud-adoption-framework/govern/guides/complex/security-baseline-improvement?azure-portal=true) |
| Mission-critical applications in the cloud | [Discipline improvement](/azure/cloud-adoption-framework/govern/guides/standard/resource-consistency-improvement?azure-portal=true) | [Discipline improvement](/azure/cloud-adoption-framework/govern/guides/complex/resource-consistency-improvement?azure-portal=true) |
| Cloud cost management | [Discipline improvement](/azure/cloud-adoption-framework/govern/guides/standard/cost-management-improvement?azure-portal=true) | [Discipline improvement](/azure/cloud-adoption-framework/govern/guides/complex/cost-management-improvement?azure-portal=true) |
| Multicloud | [Discipline improvement](/azure/cloud-adoption-framework/govern/guides/standard/multicloud-improvement?azure-portal=true) | [Discipline improvement](/azure/cloud-adoption-framework/govern/guides/complex/multicloud-improvement?azure-portal=true) |
| Complex/legacy identity management | N/A | [Discipline improvement](/azure/cloud-adoption-framework/govern/guides/complex/identity-baseline-improvement?azure-portal=true) |
| Multiple layers of governance | N/A | [Discipline improvement](/azure/cloud-adoption-framework/govern/guides/complex/multiple-layers-of-governance?azure-portal=true) |

Later in this module, we discuss each discipline from the Cloud Adoption Framework Govern methodology and relate them to Tailwind Traders' customer narrative.
