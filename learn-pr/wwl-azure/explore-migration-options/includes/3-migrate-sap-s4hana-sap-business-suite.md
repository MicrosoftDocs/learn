For many SAP customers, events in their migration of SAP HANA to the cloud are driven by two factors:

- End of life first-generation SAP HANA appliances, causing customers to reevaluate their platform.
- The desire to take advantage of the early value proposition of SAP Business Warehouse (BW) on HANA in a flexible TDI model over traditional databases and later BW/4HANA.

As a result, initial migrations of SAP HANA to Microsoft Azure are focused on SAP BW to take advantage of SAP HANA’s in-memory capability for the BW workload. This results in migration of the BW application to utilize SAP HANA at the database layer, and eventually the more involved migration of BW on HANA to BW/4HANA.

:::image border="false" type="content" source="../media/journey-azure-sap-workloads-0a433e12.png" alt-text="Diagram showing the journey to Azure for S A P workloads.":::

The SAP Database Migration Option (DMO) with System Move option of Software Update Manager (SUM), used as part of the migration allows the customer to perform the migration in a single step. Moving in a single step from source system on-premises, or to the target system residing in Microsoft Azure, and minimizing overall downtime.

:::image border="false" type="content" source="../media/sap-business-warehouse-hana-and-business-warehouse-4hana-migrations-981ec7de.png" alt-text="Diagram showing S A P B W on HANA and B W 4 HANA migrations.":::
