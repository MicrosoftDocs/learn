You're the database administrator for a law company, and you know that you have SQL Server 2005 and SQL Server 2000 databases that Microsoft no longer supports. The databases might function effectively with applications, but you can't guarantee to the business that they are as secure as they could be. Microsoft doesn't provide patches and updates anymore and so you're not protected from the latest threats. What's more, you're unable to take advantage of the features in newer versions of SQL Server that could offer enhanced productivity.

Here, we'll look at the main questions an organization will ask before it begins a database migration operation.

## Which versions of SQL Server can be upgraded?

To ensure you upgrade your database to the most secure and performant possible standard, don't upgrade to a version earlier than SQL Server 2014. Versions of SQL Server from 2005 onwards can be upgraded to SQL Server 2014, 2016, or 2017. If you discover earlier versions such as SQL Server 2000 that are still in existence, first upgrade to SQL Server 2008 to overcome the compatibility level obstacle. You can then upgrade to a later version.

## Reasons to upgrade to SQL Server 2017

If your company is running any SQL Server 2005 databases, these databases are no longer supported by Microsoft, so if you are bound to any rules of compliance, you should check that you still adhere to these rules. Furthermore, security patches and updates are not provided, so your databases are more prone to malicious attack, which is the most compelling reason to upgrade.

Unlike SQL Server 2016 or SQL Server 2017, older versions will not be able to leverage the performance benefits of newer hardware, and you won't be able to upgrade your servers or move to the cloud without upgrading. Organizations have been quick to move to the cloud to eliminate the need to manage hardware in an on-site server room.

By upgrading to SQL Server 2017, you can introduce machine learning and data science into your IT realm to take your data analysis to another level. Both the Standard and Enterprise editions offer basic R and Python integration and, with the Enterprise edition, you can install a standalone Machine Learning Server to consume R and Python models that don't need SQL Server.

## Business impact of upgrading

Upgrading a database may result in downtime and loss of user access to business applications or reporting. However, because this downtime is planned, it can be scheduled at night or at the weekend, when few users are accessing the system. When compared to a hardware failure that may come without warning, a planned migration offers a lower risk to the business.

Websites with global reach may have a consistently high amount of traffic due to differing time zones creating a constant peak. Ask your website administrator to monitor the hit rate and find the time period with the least activity. To avoid angry customers, scheduled down-time enables you to warn users or customers that a system may be unavailable during a specified time period.

## Minimizing downtime by using the right tools and methodologies

In all likelihood, you will have a mix of internal databases used only during office hours, and some databases in constant use, such as a web ordering system. Either way, you want to choose the fastest upgrade path to ensure the database is not offline for longer than necessary. If you have an internal application, you may have the luxury of being able to migrate the database when it's not in use at the weekend, and then switch over the database connection string.

There are still some steps that you should take after an upgrade to ensure the application has been fully tested and is ready to be put back into production. Having the right tools to help you eliminate downtime by organizing and speeding up the process is a crucial aspect in keeping the business operational.

## How to decide on an upgrade

For your law company, you should consider the following issues:

- SQL Server 2000 and SQL Server 2005 are no longer supported by Microsoft and no updates are published. This lack of support means your databases may be vulnerable to security attacks that have been addressed by recent upgrades. Upgrade these database servers unless you can afford to lose them or allow the data they contain to fall into malicious hands.
- Because these databases are no longer supported, it is highly likely that you are not in compliance with the data protection laws in your region.
- Your company already uses Azure for other systems and may wish to migrate databases into Azure as well. You cannot migrate a database into Azure SQL Database from SQL Server 2000 or 2005.
- You can upgrade a SQL Server 2005 database server to SQL Server 2017 directly. However, to upgrade from SQL Server 2000, you must first upgrade to SQL Server 2008.

## Summary

Most database administrators will only want to make changes to business-critical production databases when necessary. Any planned change to a production database should be performed when appropriate backups have been taken, and the timing has the least impact on the business and end users. The risk of losing data during a migration can be mitigated through tested backups, but when a database is in continuous usage, timing can be difficult. After a thorough documentation of your landscape, you will have the clarity to decide if and when to upgrade each of your databases.

The rest of this module focuses on using tools to make the upgrade process fast, efficient, and reliable.