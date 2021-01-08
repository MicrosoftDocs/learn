You are the administrator for Contoso, Ltd. You have been asked to evaluate the Data Subject Request (DSR) process in the Microsoft cloud. You have created a use case scenario for executing a DSR.

## Setup

1. Sign into [Azure Active Directory portal](https://aad.portal.azure.com).
2. Select **Azure Active Directory**, and then select the **Overview** blade if it is not already active.  
3. In the **Tenant information** tile for the Default Directory, copy or write down the **Primary domain** value (for example yourprimarydomain.onmicrosoft.com).
4. Download [datasubject01.csv](https://github.com/RichardLuckett/learn-pr/blob/NEW-azure-data-subject-requests/learn-pr/azure/azure-data-subject-requests/media/DataSubject01.csv)  <!--- I was not able to download .csv file, I got 404 error. I assume that .csv file will be moved to some other location, which does not incude author alias when module is released? ---> 
5. Using Excel or Notepad, open the **datasubject01.csv** file and edit the **User name [userPrincipalName] Required** field for Avery. Replace **@contoso.com** with **@_yourprimarydomain_.onmicrosoft.com**. <!--- I think that it would make sense to first say that this is the Primary domain value that you copied earlier (in step 2). I see too many times that students when doing the lab, simply copy example URL that is provided in the instructions (@_yourprimarydomain_.onmicrosoft.com) and then wonder why it does not work. ---> 
>**Important:** The next step will fail if you do not use a valid domain name from your Azure Active Directory. Optionaly, you can search and replace @contoso.com with @yourprimarydomain.onmicrosoft.com in the file.
6. Save and close the file.
7. Select **All Services** and then select **Users**.
8. Drop down the **Bulk operations** list and select **Bulk create**.
9. In the Bulk create user dialog box click **select a file**. <!--- Select a file should be capitalized. ---> 
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

**Answer:** >!Discover and then Delete 


## Use Azure portal to connect to Azure Active Directory 
You will now use the Azure Active Directory admin center to discover the personal information in Azure Active Directory.

15. Verify that you are still signed into the Azure portal <!--- My understanding is that you are using Azure Active Directory portal, not Azure portal. First step was to open Azure Active Directory portal, so I would suggest to rephrase this sentence and remove Azure portal. ---> and that the Azure Active Directory admin center is active.
In the Azure Active Directory admin center, select **All Services**, select **Azure Active Directory**, select **Users**, and then slect the **All Users** blade if it is not already active. <!--- Is there any reason why we are directing readers to click **All Services**, while **Azure Active Directory** is available directly on the main dashboard? ---> 
16. Click Search users and type **Avery** <!--- I don't have real lab environment, so I'm just checking ... Are there many other users in the environment? If no, then Avery is visible on the first screen. But maybe it's nothing wrong to instruct readers to search for her, as in real world environment there will be many users in Azure AD. ---> 
17. Click on **Avery Howard** to view the data subject's profile.
18. Review and confirm that the personal information contained in the profile matches the subject's information in the DSR. 
    

## Fulfill DSR. 
You will now fulfill the DSR by deleting the data subject's user account. 

19. In the **All users** blade, select the check-box next to the data subject's user account. <!--- I understand that this should be obvious, but would it make sense to reference Avery Howard in the brackets at the end, (Avery Howard)? ---> 
20. Select **Delete user** and then select **Yes** to confirm. 
21. In the **Deleted users** blade, select the check-box next to the data subject's user account. <!--- If we are providing step by step instructions, I think that students also need to click **Deleted users** task on the blade first. ---> 
22. Select **Delete permanently** and then select **Yes** to confirm. 

## Results

After completing this exercise, you will have successfully reviewed and executed a DSR for customer data in in Azure. This meets your requirement to validate the DSR process in Azure.

## Clean up the resources
>**Note**: If you have completed all the steps in this lab you will not have any resources that need to be cleaned up. However, if you have only partially completed the lab then complete the following steps.

1. In the Azure portal, search for Azure Active Directory. <!--- In this lab we used Azure Active Directory portal, not Azure portal. I suggest to update this step accordingly. ---> 
2. Select All Users.
3. Search for and select **Avery Howard**.
4. Select **Delete user** and then select **Yes** to confirm. 
5. In the **Deleted users** blade, select the check-box next to the data subject's user account.
6. Select **Delete permanently** and then select **Yes** to confirm. 




