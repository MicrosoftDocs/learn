Before hunting with notebooks, it is essential to understand the foundation of Azure Sentinel is the Log Analytics data store, which combines high-performance querying, dynamic schema, and scales to massive data volumes.  The Azure portal and all Azure Sentinel tools use a standard API to access this data store. The same API is also available for external tools such as Python and PowerShell. There are two libraries that you can use to simplify API access:

- Kqlmagic

- msticpy

### Kqlmagic

The Kqlmagic library provides an easy to implement API wrapper to run KQL queries.

### msticpy

Microsoft Threat Intelligence Python Security Tools is a set of Python tools intended to be used for security investigations and hunting. Many of the tools originated as code Jupyter notebooks written to solve a problem as part of a security investigation. Some of the tools are only useful in notebooks (for example, much of the nbtools subpackage), but many others can be used from the Python command line or imported into your code.

The package addresses three central needs for security investigators and hunters:

- Acquiring and enriching data

- Analyzing data

- Visualizing data

msticpy can query using KQL; the library also provides predefined queries for Azure Sentinel, Microsoft 365 Defender for Endpoint, and the Microsoft  Security Graph.  An example of a function is the list_logons_by_account, which retrieves the logon events for an account.  For details about msticpy visit: [https://msticpy.readthedocs.io/](https://msticpy.readthedocs.io/?azure-portal=true)

