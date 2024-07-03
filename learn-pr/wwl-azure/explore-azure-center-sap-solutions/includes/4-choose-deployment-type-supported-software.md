When you deploy S/4HANA infrastructure with *Azure Center for SAP solutions (ACSS)* there are infrastructure deployment options you can select, depending on your use case:

- **Distributed with High Availability (HA)** creates distributed HA architecture. This option is recommended for production environments. If you choose this option, you need to select a **High Availability SLA**. Select the appropriate SLA for your use case:
  - **99.99% (Optimize for availability)** shows available zone pairs for virtual machine deployment. The first zone is primary and the next is secondary. Active ASCS and Database servers are deployed in the primary zone. Passive ASCS and Database servers are deployed in the secondary zone. Application servers are deployed evenly across both zones. This option not shown in regions without availability zones, or without at least one M-series and E-series virtual machine SKU available in the zonal pairs within that region.
  - **99.95% (Optimize for cost)** shows three availability sets for all instances. The HA ASCS cluster is deployed in the first availability set. All Application servers are deployed across the second availability set. The HA Database server is deployed in the third availability set. No availability zone names are shown.
- **Distributed** creates distributed non-HA architecture.
- **Single Server** creates architecture with a single server. This option is available for nonproduction environments only.

## Supported software

Azure Center for SAP solutions supports the following SAP software versions:

- **S/4HANA 1909 SPS 03**
- **S/4HANA 2020 SPS 03**
- **S/4HANA 2021 ISS 00**

The following operating system (OS) software versions are compatible with these SAP software versions:

| Publisher | Image and Image Version | Supported SAP Software Version |
|---|---|---|
| Red Hat | Red Hat Enterprise Linux 8.6 for SAP Applications - x64 Gen2 latest | S/4HANA 1909 SPS 03, S/4HANA 2020 SPS 03, S/4HANA 2021 ISS 00, S/4HANA 2022 ISS 00 |
| Red Hat | Red Hat Enterprise Linux 8.4 for SAP Applications - x64 Gen2 latest | S/4HANA 1909 SPS 03, S/4HANA 2020 SPS 03, S/4HANA 2021 ISS 00, S/4HANA 2022 ISS 00 |
| Red Hat | Red Hat Enterprise Linux 8.2 for SAP Applications - x64 Gen2 latest | S/4HANA 1909 SPS 03, S/4HANA 2020 SPS 03, S/4HANA 2021 ISS 00, S/4HANA 2022 ISS 00 |
| SUSE | SUSE Linux Enterprise Server (SLES) for SAP Applications 15 SP4 - x64 Gen2 latest | S/4HANA 1909 SPS 03, S/4HANA 2020 SPS 03, S/4HANA 2021 ISS 00, S/4HANA 2022 ISS 00 |
| SUSE | SUSE Linux Enterprise Server (SLES) for SAP Applications 15 SP3 - x64 Gen2 latest | S/4HANA 1909 SPS 03, S/4HANA 2020 SPS 03, S/4HANA 2021 ISS 00, S/4HANA 2022 ISS 00 |
| SUSE | SUSE Linux Enterprise Server (SLES) for SAP Applications 12 SP5 - x64 Gen2 latest | S/4HANA 1909 SPS 03 |
| SUSE | SUSE Linux Enterprise Server (SLES) for SAP Applications 12 SP4 - x64 Gen2 latest | S/4HANA 1909 SPS 03 |

You can use `latest` if you want to use the latest image and not a specific older version. If the *latest* image version is newly released in marketplace and has an unforeseen issue, the deployment can fail. If you're using Portal for deployment, we recommend choosing a different image *sku train* (for example, 12-SP4 instead of 15-SP3) until the issues are resolved. However, if deploying via API/CLI, you can provide any other *image version* that is available. To view and select the available image versions from a publisher, use the following commands:

  ```Powershell
  Get-AzVMImage -Location $locName -PublisherName $pubName -Offer $offerName -Sku $skuName | Select Version
  ```
  
  Where, for example:

  ```Powershell
  $locName = "eastus"
  $pubName = "RedHat"
  $offerName = "RHEL-SAP-HA"
  $skuName = "82sapha-gen2"
  ```

You can start your ACSS-based deployment after you choose a deployment option, SAP software and OS; and have provisioned the necessary infrastructure and prerequisites.
