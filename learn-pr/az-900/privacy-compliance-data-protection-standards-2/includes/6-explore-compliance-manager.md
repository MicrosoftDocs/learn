[Azure compliance documentation](https://docs.microsoft.com/azure/compliance/?azure-portal=true) is a website that provides links to detailed documentation about legal and regulatory standards, and compliance in Azure. 

Here you can find:

* Compliance offerings across the following categories:
    + Global
    + US government
    + Financial services
    + Health
    + Media and manufacturing
    + Regional

There are also additional compliance resources, including audit reports, privacy and GDPR information, compliance implementations and mappings, and white papers and analyst reports, as well as country/region privacy and compliance guidelines. Some of those resources may need you to be signed in to your cloud service, to access it.  

## Tailwind Traders E-Commerce compliance requirements  

E-commerce is an important part of Tailwind Traders modern sales strategy, enabling customers to order products online, easily. The e-commerce application allows customers to pay by credit card, so Tailwind Traders has a responsibility under the Payment Card Industry (PCI) Data Security Standard (DSS). This global standard (known as PCI DSS) seeks to prevent fraud through increased control of credit card data and applies to any organization that stores, processes or transmits payment and cardholder data.  

You've been tasked with investigating whether hosting this application on Azure would be compliant with PCI DSS, so you start with the Azure compliance documentation website.

> [!NOTE]
> Compliance status for Azure products and services does not automatically translate to compliance for the service or application you build or host on Azure. Customers are responsible for ensuring that they achieve compliance with the appropriate legal and regulatory standards. 

### Compliance offerings   
Under Compliance offerings, you find PCI DSS under Financial services. This link takes you to a [Payment Card Industry (PCI) Data Security Standard (DSS) article](https://docs.microsoft.com/microsoft-365/compliance/offering-pci-dss?view=o365-worldwide) with:
+ An overview of PCI DSS
+ Microsoft's compliance and PCI DSS
+ Microsoft in-scope cloud services
+ Audit, reports and certificates
+ Frequently asked questions

### Additional compliance resources
Under Additional compliance resources, in the Audit reports category, there's also a link to [PCI DSS](https://servicetrust.microsoft.com/ViewPage/MSComplianceGuideV3?docTab=7027ead0-3d6b-11e9-b9e1-290b1eb4cdeb_PCI_DSS). From here you can access several different files including the Attestation of Compliance resports and the PCI DSS Shared Responsibility Matrix.

Finally, under Compliance blueprints, you find [PCI-DSS](https://docs.microsoft.com/azure/governance/blueprints/samples/pci-dss-3.2.1/). This blueprint sample deploys a core set of policies that map to PCI DSS compliance and help you govern your Azure workloads against this standard. You can then see if the Azure resources in your application architecture have been configured correctly for PCI DSS compliance, or which resources you need to remediate.

> [!div class="checklist"]
> * Azure compliance documentation is the gateway to a comprehensive set of resources regarding legal and regulatory standards, and compliance in Azure.