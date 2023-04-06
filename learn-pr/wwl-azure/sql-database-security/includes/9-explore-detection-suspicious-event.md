
You receive an email notification upon detection of anomalous database activities. The email provides information on the suspicious security event, including the nature of the anomalous activities, database name, server name, application name, and event time. In addition, the email provides information on possible causes and recommended actions to investigate and mitigate the potential threat to the database.

**Example:** Email notification providing information on a suspicious security event.

:::image type="content" source="../media/azure-sql-database-security-event-notification-82a0f8fa.png" alt-text="Screenshot showing an example of a recent SQL alert.":::


**Click** the **View recent SQL alerts** link in the email to launch the Azure portal and show the Microsoft Defender for Cloud alerts page, which provides an overview of active threats detected on the database.

:::image type="content" source="../media/viewing-recent-sql-alert-notification-257aeb10.png" alt-text="Screenhost showing an example of viewing a recent SQL alert.":::
**Click** a specific alert to get additional details and actions for investigating this threat and remediating future threats.<br>

:::image type="content" source="../media/veiwing-specific-alert-details-and-actions-2403eebd.png" alt-text="Screenhsot showing an example of viewing a specific alert to get additional details and actions.":::
**For example**, SQL injection is one of the most common Web application security issues on the Internet that is used to attack data-driven applications. Attackers take advantage of application vulnerabilities to inject malicious SQL statements into application entry fields, breaching or modifying data in the database. For SQL Injection alerts, the alert's details include the vulnerable SQL statement that was exploited.

:::image type="content" source="../media/potential-sql-injection-20cd8bc7.png" alt-text="Screenshot showing an example of a potential SQL injection.":::


### Explore alerts in the Azure portal.

Advanced Threat Protection integrates its alerts with Microsoft Defender for Cloud. Live SQL Advanced Threat Protection tiles within the database and SQL Microsoft Defender for Cloud blades in the Azure portal track the status of active threats.

**Click** the **Advanced Threat Protection alert** to launch the Microsoft Defender for Cloud alerts page and get an overview of active SQL threats detected on the database.

:::image type="content" source="../media/exploring-alerts-in-the-azure-portal-4fadbc06.png" alt-text="Screenshot showing how to explore alerts in the Azure portal.":::
