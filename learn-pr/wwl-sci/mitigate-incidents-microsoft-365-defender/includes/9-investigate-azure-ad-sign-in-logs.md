

To perform a sign-in investigation including conditional access policies evaluated, you can query the following tables with KQL:


| Location | Table |
| :--- | :--- |
| Microsoft 365 Defender Threat Hunting| AADSignInEventsBeta|
| Azure AD Log Analytics| SigninLogs|


The Azure Active Directory Monitoring Sign-in Logs provide access to the same information available in the SigninLogs table. To access the Sign-in Logs blade, select Azure Active Directory in the Azure portal, then Sign-in Logs in the Monitoring Group.  The query output will provide default columns including the Date, User, Application, Status, and Conditional Access (policy applied).  


