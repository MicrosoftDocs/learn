You are the administrator for Contoso, Ltd. You have been asked to evaluate the Data Subject Request (DSR) process in the Microsoft cloud. You have created a use case scenario for executing a DSR.

## Setup

1. Download .csv file <!--- Isn't there additional step needed, to populate .csv file that you downloaded with customers? After that you upload the .csv file, which bulk creates customers. ---> 
2. Bulk create customers in default Azure Active Directory domain

## Review a DSR and determine appropriate process

1. Review DSR
	- DSR form received today
	- Identity verified today
		- Avery Howard is a financial planning client that resides in the Netherlands.
		- Avery was contacted and was able to provide national ID card verification.

|||
|---|---|
|Subject's Name|Avery Howard|
|Date of Birth|11-18-1999|
|Address|van Milboulevard 2973, Schipluiden, Bilzen, 6222VD|
|Telephone|+31 655 5592 98|
|Email|averyh@contoso.com|
|With regard to|Right to erasure 'right to be forgotten'  <!--- Will it be clear to the readers that this is single right? (I know that it was discussed in earlier topics. Would it make sense to put 'right to be forgoten' in brackets, ('right to be forgoten')? ---> | 
|Preferred feedback method|In writing to address|


2. Identify the steps that you will use in DSR process and then execute the DSR.
    * Discover
    * Access
    * Rectify
    * Restrict
    * Delete
    * Export / Receive

## Use Azure portal to connect to Azure AD. 
Introduction paragraph <!--- This should probably be replaced with actual content/paragraph. ---> 

3. Discover
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


