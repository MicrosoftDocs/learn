Use this set of Try-This exercises to get some hands-on experience with Azure.

In this demonstration, we will configure and test an app registration. 

## Task 1 - Configure an app registration via the Azure portal

> [!NOTE] 
> The application registration process is constantly being updated and improved. Validate before your demo

In this task, we will demo how to register an application.

1. In the **Portal** search for and select **Azure Active Directory**.
1. Under **Manage** select **App registrations**.
1. Click **New registration**.
	* Name: **AZ500 app**
	* Review the **Supported app types**
	* Select **Accounts in this organizational directory only (Single tenant)**
	* Redirect URL > **Web**: **http://localhost**
	* Click **Register**
1. Wait for the application to register.
1. On the **Overview** tab, review the **Application (Client ID)**, **Directory (tenant ID)**, and **Object ID**. 
1. Under **Manage** click **Certificates and Secrets**.
1. Review the use of client secrets that an application uses to prove its identity when requesting a token.
1. Click **New client secret**.
	* Description: **key1**
	* Expires: **In 1 year**
	* Click **Add**
1. Wait for the application credentials to update. 
1. Create a txt file using Notepad. 
1. Note the **key1** value. Copy the value to your file. 
1. On the **Overview** tab, copy the **Application (Client ID)** and **Directory (tenant ID)** to your file. 

## Task 2 - Test the application

> [!NOTE] 
> You will need the information from Task 1, and [Microsoft Graph Postman](https://www.postman.com) or you can use [Microsoft Graph](https://developer.microsoft.com/graph/graph-explorer/preview) before you can complete testing the application registration.

In this task, we will test the app registration. 

1. In the **Postman** application sign in if needed.
1. Set to **POST** and the URL to 'https://login.microsoftonline.com/[Insert_Tenant_(Directory)_ID]/oauth2/v2.0/token'
1. Click the **Body** tab, 
	* Copy from notepad (from Task1) and Paste **Client (App ID)** under **client_id** and the **VALUE** column
	* Copy from notepad (from Task1) and Paste **Client (App) Secret** under **client_secret** and the **VALUE** column
	* Click **Send** on the top right corner of the window
1. Wait for it to execution to finish
1. Click **Params** tab, and review the **access_token** value (usually displayed on line 5)
1. Switch to the Azure portal and in Az500 app (same place you finished on Task 1), under **Manage** select **API Permissions** on the left column
1. Click **Add a permission**, and **Request API permissions** blade will come up
	* Inside the **Request API permissions** blade, select **Microsoft Graph**
	* Select **Application permissions**
	* Scroll down inside the same blade and select **User** category
	* Checkbox by **User.Read.All**
	* Click **Add permissions**
1. Once the change has been committed click on **User.Read.All** entry
	* Show that **Admin consent required** is set to "Yes"
	* Close that window
	* Select **Grant admin consent for az500...**
	* Read the pop up banner
	* After reviewing the banner, click **Yes**
1. Switch back to postman, copy the **access_token** value from the previous query
	* Click on the left pane **Get https.... .../users**
	* Validate the **Get** URL is set to `https://graph.microsoft.com/v1.0/users`
	* In the **Headers** tab, under **Authorization**, replace everything in value column except for Bearer value. 
	* Click **Send** in to the right of the window
	* Validate a Status of green **200 OK** is displayed in middle right of the window
1. Review the **Body** of the token that was provided

