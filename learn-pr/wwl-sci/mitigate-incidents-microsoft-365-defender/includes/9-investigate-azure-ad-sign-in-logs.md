To perform a sign-in investigation including conditional access policies evaluated, you can query the following tables with KQL:


| Location | Table |
| :--- | :--- |
| Microsoft Defender XDR Threat Hunting| AADSignInEventsBeta|
| Microsoft Entra ID Log Analytics| SigninLogs|


The Microsoft Entra monitoring Sign-in Logs provide access to the same information available in the SigninLogs table. To access the Sign-in Logs blade, select Microsoft Entra ID in the Azure portal, then Sign-in Logs in the Monitoring Group.  The query output will provide default columns including the Date, User, Application, Status, and Conditional Access (policy applied).  

