App connectors use the APIs of app providers to enable greater visibility and control by Microsoft Defender for Cloud Apps over the apps you connect to. Microsoft Defender for Cloud Apps (MDCA) uses the APIs provided by the cloud provider. All communication between Defender for Cloud Apps and connected apps is encrypted using HTTPS. Each service has its own framework and API limitations such as throttling, API limits, dynamic time-shifting API windows, and others. Microsoft Defender for Cloud Apps worked with the services to optimize the usage of the APIs and to provide the best performance. Taking into account different limitations services impose on the APIs, the Defender for Cloud Apps uses the allowed capacity. Some operations, such as scanning all files in the tenant, require numerous APIs so they're spread over a longer period. Expect some policies to run for several hours or several days.

## Multi-instance support

Defender for Cloud Apps supports multiple instances of the same connected app. For example, if you've more than one instance of Salesforce (one for sales, one for marketing) you can connect both to Defender for Cloud Apps. You can manage the different instances from the same console to create granular policies and deeper investigation. This support applies only to API connected apps, not to Cloud Discovered apps or Proxy connected apps.

## How it works

Defender for Cloud Apps is deployed with system admin privileges to allow full access to all objects in your environment. The App Connector flow is as follows:

1.  Defender for Cloud Apps scans and saves authentication permissions.
2.  Defender for Cloud Apps requests the user list. The first time the request is done, it may take some time until the scan completes.
3.  After completion of the user request, Defender for Cloud Apps periodically scans users, groups, activities, and files. All activities will be available after the first full scan.

Connections may take some time depending on the size of the tenant, the number of users, and the size and number of files that need to be scanned. Depending on the app to which you're connecting, API connection enables the following items:

 -  **Account information** \- Visibility into users, accounts, profile information, status (suspended, active, disabled) groups, and privileges.
 -  **Audit trail** \- Visibility into user activities, admin activities, sign-in activities.
 -  **Account governance** \- Ability to suspend users, revoke passwords, etc.
 -  **App permissions** \- Visibility into issued tokens and their permissions.
 -  **App permission governance** \- Ability to remove tokens.
 -  **Data scan** \- Scanning of unstructured data using two processes -periodically (every 12 hours) and in real-time scan (triggered each time a change is detected).
 -  **Data governance** \- Ability to quarantine files, including files in trash, and overwrite files.
