

You can use the Intune Data Warehouse to build professional looking reports that provide insight into your enterprise mobile environment. For example, some of the reports include:

 -  Trend of users enrolling in Intune so you can optimize your license purchases
 -  App and OS versions break down so you can review that status of devices
 -  Enrollment and device compliance trends so you can smoothly roll out policy updates

The Data Warehouse provides you access to more information about your mobile environment than the Microsoft Intune admin center. With the Intune Data Warehouse you can access:

 -  Historical Intune data
 -  Data refreshed on a daily cadence
 -  A data model using the OData standard

 >[!Note]
 >If you are a using co-managed mobile device management (MDM) with Microsoft Configuration Manager and Microsoft Intune, you need to retrieve your data from Configuration Manager. The Intune Data Warehouse only contains Intune data. You can use a Configuration Manager Power BI dashboard for your custom reports. For related information, see Power BI Desktop.

Requirements for accessing the Intune Data Warehouse (including the API) are:

 -  User must be one of:
    
     -  Azure Active Directory (Azure AD) global administrator
     -  An Intune service administrator
     -  User with role-based access to Intune data warehouse resources
     -  User-less authentication using application-only authentication
 -  Install the latest version of Power BI Desktop. You can download Power BI Desktop from: PowerBI.microsoft.com

When accessing data in the Data Warehouse with Power BI, you have two options:

 -  Load the data in Power BI using the OData link
 -  Use the Intune Compliance App

### Load the data in Power BI using the OData link

With a client authenticated to Azure AD, the OData URL connects to the RESTful endpoint in the Data Warehouse API that exposes the data model to your reporting client. Follow these instructions to use Power BI Desktop to connect and create your own reports. You're not limited to Power BI Desktop, but can use your favorite analytic tool with the OData URL provided the client supports OAUTH2.0 authentication and the OData v4.0 standard.

1.  Sign in to the Endpoint Manager portal and choose **Reports**.
2.  Select **Data warehouse**. Retrieve the URL listed in the **Odata feel for reporting service** field. For example:
    
    ```
    https://fef.{yourinfo}.manage.microsoft.com/ReportingService/DataWarehouseFEService/dates?api-version=beta
    
    ```
3.  Open **Power BI Desktop**.
4.  Choose **Home** > **Get Data**. Select **OData feed**.
5.  Type or paste the OData URL into the URL box.
6.  Authenticate to Azure AD for your tenant from the Power BI desktop client by signing in on the Organizational account tab.
7.  Select the desired tables needed for reporting.
8.  Create custom dashboards and reports using the Power BI Desktop.

### Use the Power BI App

Alternatively, you can use the Power BI Intune Compliance app, which is in preview. This contains pre-configured reports focused on device compliance reporting. This uses the web version of Power BI and allows for customization and sharing of reports.

1.  Sign in to the Endpoint Manager portal and choose **Reports**.
2.  Select **Get Power BI App**, then **Get it now**.
3.  Install the App. You'll either need to sign in with a user licensed for Power BI or sign up for a trial.
4.  Once in the app, note a message that sample data is being shown. Connect your data by signing in.
5.  When the data has refreshed (this can take up to 5 minutes), select the Intune Compliance workspace to view the dashboards and reports.
