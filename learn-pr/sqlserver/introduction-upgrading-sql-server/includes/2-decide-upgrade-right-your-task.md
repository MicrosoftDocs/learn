As the database administrator for a law company, you know you have SQL Server 2005 and SQL Server 2000 databases that Microsoft no longer supports. The databases might function effectively with applications, but you can't guarantee to the business that they're as secure as they could be. Microsoft no longer provides patches and updates, so you're not protected from the latest threats. Also, you can't take advantage of the features in newer versions of SQL Server that could offer enhanced productivity.

Here, we'll look at the main questions an organization will ask before it begins a database migration operation.

## Which versions of SQL Server can be upgraded?

To ensure you upgrade your database to the most secure and performant standard possible, don't upgrade to a version earlier than SQL Server 2014. Versions of SQL Server from 2012 onward can be upgraded to SQL Server 2019. If you discover earlier versions, such as SQL Server 2008, still in existence, you first upgrade to SQL Server 2017. You can then upgrade to SQL Server 2019.

## Reasons to upgrade to SQL Server 2019

Check if your company is running any SQL Server 2008 or 2008 R2, as these databases are no longer supported by Microsoft. If you're bound to any rules of compliance, check that you still adhere to them. Also, security patches and updates aren't provided, so your databases are more prone to malicious attack. Security combined with the improved performance you'll see are the most compelling reasons to upgrade.

The new Intelligent Query Processing family of features ensures that your various workloads will run faster with fewer interventions from your DBA team. Your existing queries can see performance improvements without any code changes. Also, old versions of SQL Server can't use the performance benefits of newer hardware. You can't upgrade your servers or move to the cloud without upgrading. Organizations have been quick to move to the cloud to eliminate the need to manage hardware in an onsite server room.

You want to enable your legal team to query data where it resides, rather than having to load and transform it into your existing data warehouse. Using the features of Polybase allows organizations to leverage their existing data sources.

By upgrading to SQL Server 2019, you can introduce machine learning and data science into your IT realm to take your data analysis to another level. Both the Standard and Enterprise editions offer basic R and Python integration.

## Business impact of upgrading

Upgrading a database might result in downtime and loss of user access to business applications or reporting. However, because this downtime is planned, you can schedule it at night or at the weekend, when few users are accessing the system. When compared to a hardware failure that might come without warning, a planned migration offers a lower risk to the business.

Websites with global reach might have a consistently high amount of traffic, because differing time zones create a constant peak. Ask your website administrator to monitor the hit rate and find the time period with the least activity. To avoid angry customers, you can use scheduled updates to warn users or customers that a system may be unavailable during a specified time period.

## Minimizing downtime by using the right tools and methodologies

It's likely you'll have a mix of internal databases used only during office hours and some databases in constant use, such as a web ordering system. Either way, you want to choose the fastest upgrade path to ensure the database isn't offline for longer than necessary.

If you have an internal application, you might have the luxury of being able to migrate the database when it's not in use on the weekend, then switch over the database connection string.

There are still some steps you should take after an upgrade to ensure the application has been fully tested and is ready to go back into production. Having the right tools to help you eliminate downtime by organizing and speeding up the process is key to keeping the business operational.

## How to decide on an upgrade

For your law company, you should consider the following issues:

- SQL Server 2005, SQL Server 2008, and SQL Server 2008 R2 are no longer supported by Microsoft and no updates are published. This lack of support means your databases might be vulnerable to security attacks that have been addressed by recent upgrades. Upgrade these database servers unless you can afford to lose them or allow the data they contain to fall into malicious hands.
- Because these databases are no longer supported, it's highly likely that you aren't in compliance with the data protection laws in your region.
- Your company already uses Azure for other systems and might wish to migrate databases there. You can't migrate a database into Azure SQL Database from SQL Server 2000 or 2005.
- You can upgrade a SQL Server 2005 database server to SQL Server 2017 directly. However, to upgrade from SQL Server 2005 to SQL Server 2019, you must first upgrade to SQL Server 2017.

Most database administrators will only want to make changes to business-critical production databases when necessary. Any planned change to a production database should be done when appropriate backups have been taken, and the timing has the least impact on the business and end users.

The risk of losing data during a migration can be mitigated through tested backups, but when a database is used constantly, timing can be difficult. After a thorough documentation of your landscape, you'll decide if you need to upgrade each of your databases.
