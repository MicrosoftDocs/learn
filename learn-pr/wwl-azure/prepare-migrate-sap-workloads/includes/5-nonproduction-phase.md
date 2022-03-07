In the non-production phase, you are starting to deploy non-production SAP systems into Azure following a successful pilot, leveraging all the testing and validation tasks. All the criteria and steps applicable to the pilot do apply in this phase as well. The non-production environment typically includes development, unit tests, and business regression tests systems. It is recommended that at least one of them implements high availability configuration that will be used for the future production system. Additional steps you need to consider during that phase include:

1. Before moving systems from the old platform into Azure, collect resource consumption data, such as CPU usage, storage throughput, and IOPS data. This is particularly important regarding the DBMS layer units but is also very helpful in case of the application layer units. In addition, you should measure network and storage latency.

2. Record the availability requirements of the systems you are deploying. The goal is to determine whether non-production systems need to be available 24x7 or whether there are non-production systems that can be temporarily shut down.

3. Determine whether you want to build your own OS images for Azure VMs or whether you want to use Azure Marketplace images.

4. When deploying SAP on SLES and RHEL images from Azure Marketplace, ensure to use SAP-specific images provided by SUSE and Red Hat, respectively.

5. Make sure you fulfill the support requirements SAP has regarding Microsoft support agreements. 

6. Identify the owners of systems being deployed to facilitate maintenance scheduling and notifications

7. Monitor updates to Azure documentation to identify new functionality that might affect your deployments

8. Monitor updates to SAP notes related to Azure, such as SAP Note #1928533 (SAP on Microsoft Azure: Support prerequisites) to identify new VM SKUs, or newly supported OS and DBMS releases. Take advantage of new offerings to realize the best price/performance ratio.

9. Once again, validate the resources on SAP notes, SAP HANA hardware directory, and SAP Product Availability Matrix (PAM) to make sure that there were no changes in supported Azure VM SKUs, supported OS releases, and supported SAP and DBMS releases

10. Reference [https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/iaas.html#categories=Microsoft%20Azure](https://www.sap.com/dmc/exp/2014-09-02-hana-hardware/enEN/iaas.html) regarding new HANA certified Azure VM SKUs. In case of any updates, compare pricing with the SKUs you originally considered, and identify the options with the optimal price/performance ratio

11. Adapt your deployment scripts to leverage new Azure VM SKU types and incorporate new features from which you can benefit.

12. After deployment of the infrastructure, test and evaluate the network latency between SAP application layer VM and DBMS VM according to SAP Note #500235 (Network Diagnosis with NIPING) and SAP Note #1100926 (FAQ: Network performance). Evaluate the results against network latency guidance of SAP Note #1100926. The network latency should be within the moderate to good range. 

13. Perform all the other checks included in the pilot phase before proceeding with the deployment.

14. In migration scenarios, as part of the deployment process, record the resource consumption of systems deployed to Azure and compare it with the historical, on-premises records. Adjust Azure VM sizing if you see that significant differences. Keep in mind that changing Azure VM size affects its storage and network throughput. 

15. Determine the system copy functionality and processes. The goal is to simplify copy of development and test systems to accelerate project delivery. Consider using SAP LaMa as a tool to facilitate such tasks.

16. Optimize Azure role-based access, permissions, and processes to ensure separation of responsibilities, while, at the same time, streamlining your operational model.

17. Test and document high-availability and disaster recovery-related architecture and procedures.