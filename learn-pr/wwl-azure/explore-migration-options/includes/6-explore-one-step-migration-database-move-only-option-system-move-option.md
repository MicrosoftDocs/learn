- Ensure connectivity to Azure is available via ExpressRoute (highly recommended and with higher-speed connectivity) or Virtual Private Network (VPN) into Azure.
- Provision the target infrastructure in Azure that includes SAP NetWeaver and SAP HANA database servers. The Azure infrastructure can be rapidly deployed using predefined ARM templates.
- Software Update Manager (SUM) is started on the on-premises source SAP application server.
- Uptime activities are executed from the on-premises SAP application server and the shadow repository is created.
- As part of the downtime phase, export files are generated on the source system and these files are then transferred to Azure via Express Route or VPN.
- File transfers can occur in **Sequential Data Transfer** or **Parallel Data Transfer** modes.

## Sequential Data Transfer mode

- In Sequential Data Transfer mode, all tables are exported to the file system of the on-premises server.
- Once the export is finalized, the complete SUM directory is transferred to the target application server in Azure.
- The SUM directory is re-synchronized during the HOSTCHANGE phase of DMO.
- SUM is initiated on the target Azure application server and the import is started.
- Post-processing is completed.

## Parallel Data Transfer mode

- In Parallel Data Transfer mode, data is immediately transferred to the Azure target after the export is completed for each file via the dmotocloud.sh script.
- This mode can be used to minimize migration downtime.
