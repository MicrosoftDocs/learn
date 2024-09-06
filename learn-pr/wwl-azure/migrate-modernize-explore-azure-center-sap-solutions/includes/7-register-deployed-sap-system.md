Azure Center for SAP solutions (ACSS) creates several required resources during system registration, but for ACSS to fully deploy it also requires an SAP workload in Azure infrastructure and the SAP system prerequisites listed in this article.

A supplemental option for this lesson is the interactive guide, [Register an existing SAP system](https://mslearn.cloudguides.com/guides/Azure%20Center%20for%20SAP%20solutions%20-%20Register%20an%20existing%20SAP%20system) to simulate the ACSS SAP system registration experience in the U.S. version of the Azure portal (currently English only).

System registration in ACSS:

When you register a system with ACSS, these resource types are created to represent the SAP system on Azure:

- Virtual Instance for SAP solutions (VIS).
- Central service instance for SAP solutions.
- App server instance for SAP solutions.
- Database for SAP solutions.

These resources don't have any billing or cost associated with them.

Azure Center for SAP solutions system registration also creates:

- A managed resource group that is used by the ACSS service.
- A Storage account within the managed resource group that contains blobs.
- Scripts and logs in the Storage account blobs necessary for the service to provide capabilities including discovering and registering all components of SAP system.

> [!NOTE]
> Check that you're trying to register a [supported SAP system configuration](/azure/sap/center-sap-solutions/register-existing-system#supported-systems).

After you register an SAP system with Azure Center for SAP solutions, you can use its visualization, management, and monitoring capabilities through the Azure portal.
