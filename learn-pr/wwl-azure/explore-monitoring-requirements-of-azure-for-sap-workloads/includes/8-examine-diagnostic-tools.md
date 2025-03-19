Run SAP HANA Health Check through HANA\_Configuration\_Minichecks. This tool returns potentially critical technical issues that should have already been raised as alerts in SAP HANA Studio.

1. Refer to [SAP Note \#1969700](https://me.sap.com/notes/1969700) and download the SQL Statements.zip file attached to that note. Store this .zip file on the local hard drive.
2. In SAP HANA Studio, on the **System Information** tab, right-click in the **Name** column and select **Import SQL Statements**.
3. Select the **SQL Statements.zip** file stored locally, and a folder with the corresponding SQL statements will be imported.
4. At this point, many different diagnostic checks can be run with these SQL statements.

     - For example, to test SAP HANA System Replication bandwidth requirements, right-click the **Bandwidth** statement under **Replication: Bandwidth** and select **Open in SQL Console**. The complete SQL statement opens allowing input parameters to be changed and then executed.
     - Another example is right-clicking on the statements under **Replication: Overview**. Select **Execute** from the context menu. This results in information that helps with troubleshooting.
5. Do the same for HANA\_Configuration\_Minichecks and check for any X marks in the **C** (Critical) column.

Sample outputs include:

- HANA\_Configuration\_MiniChecks\_Rev102.01+1 for general SAP HANA checks.
- HANA\_Services\_Overview for an overview of what SAP HANA services are currently running.
- HANA\_Services\_Statistics for SAP HANA service information (CPU, memory, etc.).
- HANA\_Configuration\_Overview\_Rev110+ for general information on the SAP HANA instance.
- HANA\_Configuration\_Parameters\_Rev70+ to check SAP HANA parameters.
