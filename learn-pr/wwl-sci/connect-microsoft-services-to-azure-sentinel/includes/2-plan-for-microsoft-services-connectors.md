Once you've installed the Content Hub solutions, you can connect Microsoft and Azure-related services in the Data Connector page configuration section in just a few mouse clicks.  It's easy to overlook specific considerations for each connector.  This module will demonstrate the connecting of three services. Each service sends data to different Data Types (tables).

First, is the Office 365 connector.  The Configuration option allows for the sending of Exchange, SharePoint, and Teams data.  Based on your organization's specific needs, you can decide which data to ingest.  The Data types show that all the data will reside in the OfficeActivity table.

The second is Azure Active Directory, which has two options for Sign-On logs and Audit logs.

Third is Azure Active Directory Identity Protection.  This connector will send data to the SecurityAlert table.  The SecurityAlert table will hold the alert data only without the underlying data that caused the alert.  A second option is to Create Incidents, which is Recommended! This process will automatically create an Incident based on and connected to the alert ingested to the SecurityAlert table from Azure Active Directory Identity Protection.  You can also activate the incident creation rule on the Analytics page.

The final connector is the Azure Activity. The Azure Activity Log is a subscription log that provides insight into subscription-level events that occur in Azure. Including events from Azure Resource Manager operational data, service health events, write operations taken on the resources in your subscription, and the status of activities performed in Azure.
