Microsoft offers a suite of protections for Azure SQL Database databases as part of the Advanced Threat Protection (ATP) feature. ATP monitors the connections to the Azure SQL Database databases and the queries which are executed against the database. You can configure ATP from the Azure portal. This screen is reached from the Security section of your databases main blade.

:::image type="content" source="../media/module-33-security-final-17.png" alt-text="Advanced Threat Protection in the Azure portal":::

To get maximum benefit out of Advanced Threat Protection you will want to enable auditing on your databases. Auditing will allow for deeper investigation into the source of the problem if ATP detects an anomaly. ATP supports alerts for the following threats:

**Vulnerability to SQL injection**—This alert looks for T-SQL code coming into your database that may be vulnerable to SQL injection attacks. An example would be a stored procedure call that did not sanitize user inputs.

**Potential SQL injection**—This alert is triggered when an attacker is actively attempting to execute a SQL injection attack.

**Access from unusual location**—This alert is triggered when a user logs in from an unusual geographic location.

**Access from unusual Azure data center**—This alert is looking for attacks from an Azure data center that is not normally accessed.

**Access from unfamiliar principal**—This alert is raised when a user or applications log in to a database that they have not previously accessed.

**Access from a potentially harmful application**—This alert detects common tools that are used to attack databases.

**Brute force SQL credentials**—This alert is triggered when there a high number of login failures with different credentials.
