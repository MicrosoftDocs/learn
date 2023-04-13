
Security can't be a separate department in a silo. It also can't be added at the end of a project. Security must be part of DevOps, and together they're called DevSecOps.

The biggest weakness is not knowing the flaw in your solution. Microsoft has created a threat modeling tool to remediate it, which helps you understand potential security vulnerabilities in your solution.

The Threat Modeling Tool is a core element of the Microsoft Security Development Life cycle (SDL).

It allows software architects to identify and mitigate potential security issues early when they're relatively easy and cost-effective to resolve.

As a result, it dramatically reduces the total cost of development.

The tool has been designed with non-security experts in mind, making threat modeling easier for all developers by providing clear guidance on creating and analyzing threat models.

The tool enables anyone to:

 -  Communicate about the security design of their systems.
 -  Analyze those designs for potential security issues using a proven methodology.
 -  Suggest and manage mitigations for security issues.

In this exercise, we'll see how easy it's to use the Threat Modeling tool to see potential vulnerabilities in your infrastructure solution that one should consider when provisioning and deploying the Azure resources and the application solution into the solution.

## Getting started

 -  Download and install the [Threat Modeling tool](https://aka.ms/threatmodelingtool).

## How to do it

1.  Launch the Microsoft Threat Modeling Tool and choose the option to Create a Model.

    :::image type="content" source="../media/microsoft-threat-modeling-tool-4fd0f6ef.png" alt-text="Microsoft Threat Modeling Tool.":::


2.  From the right panel, search and add `Azure App Service Web App` and `Azure SQL Database`, and link them up to show a request and response flow, as demonstrated in the following image.

    :::image type="content" source="../media/azure-app-service-web-app-eb7e7ee3.png" alt-text="Azure App Service Web App, and Azure SQL Database request cycle.":::


3.  From the toolbar menu, select View -&gt; Analysis view. The analysis view will show you a complete list of threats categorized by severity.

    :::image type="content" source="../media/threat-list-48ab5b08.png" alt-text="Threat list.":::


4.  To generate a full report of the threats, select Reports -&gt; Create a full report from the toolbar menu, and select a location to save the report.

    A full report is generated with details of the threat, the SLDC phase it applies to, possible mitigation, and links to more information.

    :::image type="content" source="../media/azure-app-service-azure-database-1fed139c.png" alt-text="Azure App Service Web App, and Azure SQL Database request.":::


## There's more

You can find a complete list of threats used in the threat modeling tool [here](/azure/security/develop/threat-modeling-tool-threats).
