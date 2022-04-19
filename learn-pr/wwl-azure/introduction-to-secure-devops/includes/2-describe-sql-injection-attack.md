SQL Injection is an attack that makes it possible to execute malicious SQL statements. These statements control a database server behind a web application.

Attackers can use SQL Injection vulnerabilities to bypass application security measures.

They can go around authentication and authorization of a web page or web application and retrieve the content of the entire SQL database.

They can also use SQL Injection to add, modify, and delete records in the database.

An SQL Injection vulnerability may affect any website or web application that uses an SQL database such as MySQL, Oracle, SQL Server, or others.

Criminals may use it to gain unauthorized access to, delete, or alter your sensitive data: customer information, personal data, trade secrets, intellectual property, and more.

SQL Injection attacks are among the oldest, most prevalent, and most dangerous web application vulnerabilities.

The OWASP organization (Open Web Application Security Project) lists injections in their OWASP Top 10 2017 document as the number one threat to web application security.

In this tutorial, we'll simulate a SQL injection attack.

## Getting started

 -  Use the [SQL Injection Azure Resource Manager Template](https://azure.microsoft.com/resources/templates/sql-injection-attack-prevention/) to provision a web app and an SQL database with known SQL injection vulnerability.
 -  Ensure you browse the 'Contoso Clinic' web app provisioned in your SQL injection resource group.

    :::image type="content" source="../media/contoso-clinic-web-browser-8d46b68d.png" alt-text="Contoso Clinic from web browser.":::


## How it works

1.  Navigate to the Patients view, and in the search box, type `"'"` and hit enter. You'll see an error page with SQL exception indicating that the search box feeds the text into a SQL statement.

    :::image type="content" source="../media/server-error-application-syntax-f441fe7d.png" alt-text="Server error in application. SQL syntax.":::


    The helpful error message is enough to guess that the text in the search box is being appended into the SQL statement.

2.  Next, try passing a SQL statement `'AND FirstName = 'Kim'--` in the search box. You'll see that the results in the list below are filtered down to only show the entry with firstname Kim.

    :::image type="content" source="../media/patients-table-290c5cdd.png" alt-text="Patients table.":::


3.  You can try to order the list by SSN by using this statement in the search box `'order by SSN--`.

    :::image type="content" source="../media/patients-table-order-2f2ef7cf.png" alt-text="Patients table order by SSN.":::


4.  Now for the finale, run this drop statement to drop the table that holds the information displayed on this page... `'AND 1=1; Drop Table Patients --`. Once the operation is complete, try and load the page. You'll see that the view errors out with an exception indicating that the dbo.patients table can't be found.

    :::image type="content" source="../media/invalid-object-name-patients-5a5dc6b9.png" alt-text="Invalid object name dbo.Patients.":::


## There's more

The Azure security center team has other [playbooks](https://azure.microsoft.com/blog/enhance-your-devsecops-practices-with-azure-security-center-s-newest-playbooks/) you can look at to learn how vulnerabilities are exploited to trigger a virus attack and a DDoS attack.
