Suppose you were recently hired as the Identity & Security Architect of a large, multinational insurance company. You're tasked with creating new security policies that:

- Prohibits the use of legacy authentication methods
- Limits the use of mobile devices that aren't connected to the corporate network

The leadership team expects to be able to reduce the amount of legacy authentication by 50% in the next six weeks. They also expect to limit all mobile access to OneDrive when not connected to the corp network within two weeks. Because you're brand new to the company, you need to learn the environment quickly in order to create these policies. You expect there will be more data than you can process manually and you need a way to monitor the data on an on-going basis. You build a KQL query in Log Analytics that

- Monitors the type of client apps used
- Breaks down authentications by legacy and mobile authentications, user, date, and application. 

You convert this query into a workbook and build policies to address the specific users and applications that are using legacy authentications clients or mobile clients from an unprotected network.


## Learning objectives

In this module, you will:

- Choose the right activity logs.
- Route your activity logs to a different endpoint.
- Write queries to retrieve the activity data you need.
- Create a new Microsoft Entra workbook to generate a rich report of your activity data.
- Use an existing Microsoft Entra workbook to solve your business problem.

## Prerequisites

- Familiarity with Microsoft Entra ID
