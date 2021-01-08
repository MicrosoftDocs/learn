You are the administrator for Contoso, Ltd. You have been asked to evaluate the Data Subject Request (DSR) process in the Microsoft cloud. You have created a use case scenario for executing a DSR.

## Setup

1. Sign into https://aad.portal.azure.com 
2. Select **All Services**, select **Azure Active Directory**, and then select the **Overview** blade if it is not already active.
3. In the **Tenant information** tile for the Default Directory, copy or write down the **Primary domain** value (for example yourprimarydomain.onmicrosoft.com).
4. Download [datasubject01.csv](https://github.com/RichardLuckett/learn-pr/blob/NEW-azure-data-subject-requests/learn-pr/azure/azure-data-subject-requests/media/datasubject01.csv)  
5. Using Excel or Notepad, open the **datasubject01.csv** file and edit the **User name [userPrincipalName] Required** field for Avery. Replace **@contoso.com** with **@_yourprimarydomain_.onmicrosoft.com**.
>**Important:** The next step will fail if you do not use a valid domain name from your Azure Active Directory. Optionaly, you can search and replace @contoso.com with @yourprimarydomain.onmicrosoft.com in the file.
6. Save and close the file.
7. Select **All Services** and then select **Users**.
8. Drop down the **Bulk operations** list and select **Bulk create**.
9. In the Bulk create user dialog box click **select a file**.
10. In the **Open** dialog box, navigate to path where datasubject01.csv was downloaded, select **datasubject01.csv** and the click **Open**.
11. Click on the **Submit** button and verify that the creation was successful.
12. Close the confirmation.


## Review a DSR and determine appropriate process

13. Review DSR
	- DSR form received today
	- Identity verified today
		- Avery Howard is a financial planning client that resides in the United Kingdom.
		- Avery was contacted and was able to provide national ID card verification.

|||
|---|---|
|Subject's Name|Avery Howard|
|Date of Birth|11-18-1999|
|Address|123 Park Square, Bristol, BS12 3CD, UNITED KINGDOM|
|Telephone|+44 07123 456789|
|Email|avery@_yourprimarydomain_.microsoftonline.com|
|With regard to|Right to erasure (right to be forgotten)| 
|Preferred feedback method|In writing to address|


14. Identify the steps that you will use in DSR process and then execute the DSR.
    * Discover
    * Access
    * Rectify
    * Restrict
    * Delete
    * Export / Receive

[Answer:](Discover and then Delete) 


## Use Azure portal to connect to Azure AD. 
Introduction paragraph <!--- This should probably be replaced with actual content/paragraph. ---> 

15. Discover
    * Sign into the Azure portal
    * Navigate to Azure Active Directory and select **Users**
    * Locate the user account in the **All users** blade.
    * Select **Profile** to review the personal data and confirm that this is the data subject
    

## Execute DSR. 
Introduction paragraph <!--- This should probably be replaced with actual content/paragraph. ---> 

4. Delete
    * Sign into the Azure portal <!--- Aren't fist two steps already performed in the previous section, so you don't need to perform them again here? ---> 
    * Navigate to Azure Active Directory and select **Users**
    * In the **All users** blade, select the check-box next to the data subject's user account.
    * Select **Delete user** and then select **Yes** to confirm. 
    * In the **Deleted users** blade, select the check-box next to the data subject's user account.
    * Select **Delete permanently** and then select **Yes** to confirm. 

## Results

After completing this exercise, you will have successfully reviewed and executed a DSR for customer data in in Azure.

## Clean up the resources

<!-- IMPORTANT, advise learners to shutdown or delete any Azure services to avoid incurring further cost in their subscription.  -->

1. Download .csv file <!--- Is the intention to first create many users in Azure AD or to create single user (the one who sent DSR)? If single user (or few users) are created, you can just select and delete them from the GUI (Azure portal), you don't need to use bulk operation for deletion. ---> 
2. Bulk delete customers in default Azure Active Directory domain


