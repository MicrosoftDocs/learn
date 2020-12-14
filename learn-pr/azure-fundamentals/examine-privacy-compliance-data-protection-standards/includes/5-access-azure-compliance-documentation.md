Here, you learn how to access detailed documentation about legal and regulatory standards and compliance on Azure.

E-commerce is an important part of Tailwind Traders' sales strategy. Its [online retail store](https://www.tailwindtraders.com/?azure-portal=true) enables customers to easily browse and order products. Customers typically pay by credit card, so Tailwind Traders has a responsibility under the Payment Card Industry (PCI) Data Security Standard (DSS). This global standard, known as PCI DSS, seeks to prevent fraud through increased control of credit card data. The standard applies to any organization that stores, processes, or transmits payment and cardholder data.

You've been tasked with investigating whether hosting the company's e-commerce application on Azure would be compliant with PCI DSS. You start with the Azure compliance documentation.

## What is the Azure compliance documentation?

The [Azure compliance documentation](https://docs.microsoft.com/azure/compliance/?azure-portal=true) provides you with detailed documentation about legal and regulatory standards and compliance on Azure.

Here you find compliance offerings across these categories:

* Global
* US government
* Financial services
* Health
* Media and manufacturing
* Regional

There are also additional compliance resources, such as audit reports, privacy information, compliance implementations and mappings, and white papers and analyst reports. Country and region privacy and compliance guidelines are also included. Some resources might require you to be signed in to your cloud service to access them.

## Examine PCI DSS compliance

The legal team at Tailwind Traders wants to learn more about how PCI DSS relates to the company's e-commerce application on Azure.

As an optional exercise, here you follow along.

1. Go to the [Azure compliance documentation](https://docs.microsoft.com/azure/compliance/?azure-portal=true).
1. Under **Financial services**, select **PCI DSS**.

    :::image type="content" source="../media/5-financial-services.png" alt-text="A screenshot of the Azure compliance documentation page. The financial service category is shown, and PCI DSS is highlighted.":::

    There you see:

    * An overview of the PCI DSS standard.
    * How PCI DSS applies to Microsoft.
    * Which cloud services are in scope.
    * An overview of the audit cycle.
    * Answers to frequently asked questions.
    * Additional resources and white papers.

### Access additional compliance resources

From the [Azure compliance documentation](https://docs.microsoft.com/azure/compliance/?azure-portal=true), you can access additional compliance resources.

For example, from the **Audit reports** section, you find a link to audit reports for [PCI DSS](https://servicetrust.microsoft.com/ViewPage/MSComplianceGuideV3?docTab=7027ead0-3d6b-11e9-b9e1-290b1eb4cdeb_PCI_DSS?azure-portal=true).

:::image type="content" source="../media/5-audit-reports.png" alt-text="A screenshot of the Azure compliance documentation page. The audit reports section is shown, and PCI DSS is highlighted.":::

From there, you can access several different files, including the Attestation of Compliance reports and the PCI DSS Shared Responsibility Matrix.

Under **Compliance blueprints**, you find reference blueprints, or policy definitions, for common standards that you can apply to your Azure subscription. The [PCI DSS](https://docs.microsoft.com/azure/governance/blueprints/samples/pci-dss-3.2.1/?azure-portal=true) blueprint deploys a core set of policies that map to PCI DSS compliance and help you govern your Azure workloads against this standard.

:::image type="content" source="../media/5-compliance-blueprints.png" alt-text="A screenshot of the Azure compliance documentation page. The compliance blueprints section is shown, and PCI-DSS v.3.2.1 is highlighted.":::

You can then see if the Azure resources in your application architecture have been configured correctly for PCI DSS compliance, or which resources you need to remediate.

Because standards evolve, the Tailwind Traders team might check the audit report periodically to ensure that Azure has any recent changes.
