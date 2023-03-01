
Use this set of Try-This exercises to get some hands-on experience with Azure.

In this demonstration, we will configure and test an app registration.

## Configure an app registration via the Azure portal

> [!NOTE]
> The application registration process is constantly being updated and improved. Validate before your demo

In this exercise, we will demo how to register an application.

1.  In the **Portal** search for and select **Azure Active Directory**.
2.  Under **Manage** select **App registrations**.
3.  Click **New registration**.
     -  Name: **AZ500 app**
     -  Review the **Supported app types**
     -  Select **Accounts in this organizational directory only (Single tenant)**
     -  Redirect URL &gt; **Web**: **https://oauth.pstmn.io/v1/browser-callback**
     -  Click **Register**
4.  Wait for the application to register.
5.  On the **Overview** tab, review the **Application (Client ID)**, **Directory (tenant ID)**, and **Object ID**.
6.  Under **Manage** click **Certificates and Secrets**.
7.  Review the use of client secrets that an application uses to prove its identity when requesting a token.
8.  Click **New client secret**.
     -  Description: **key1**
     -  Expires: **In 1 year**
     -  Click **Add**
9.  Wait for the application credentials to update.

## 
