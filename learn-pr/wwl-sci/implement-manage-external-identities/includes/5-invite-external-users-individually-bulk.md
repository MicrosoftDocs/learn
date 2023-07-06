As a user who is assigned any of the limited administrator directory roles, you can use the Azure portal to invite B2B collaboration users. You can invite guest users to the directory, to a group, or to an application. After you invite a user through any of these methods, the invited user's account is added to Azure Active Directory (Azure AD), with a user type of *Guest*. The guest user must then redeem their invitation to access resources. An invitation of a user does not expire.

:::image type="content" source="../media/external-user-flow-d79a0a22.png" alt-text="Diagram of how a guest user is invited to the directory, and how they can access resources once they are granted access.":::


After you add a guest user to the directory, you can either send the guest user a direct link to a shared app, or the guest user can select the redemption URL in the invitation email. Make sure your organization's external collaboration settings are configured such that you're allowed to invite guests. By default, all users and admins can invite guests. But your organization's external collaboration policies might be configured to prevent certain types of users or admins from inviting guests.

## How users in your organization can invite guest users to an app

After a guest user has been added to the directory in Azure AD, an application owner can send the guest user a direct link to the app they want to share. Azure AD admins can also set up self-service management for gallery or SAML-based apps in their Azure AD tenant. This way, application owners can manage their own guest users, even if the guest users haven’t been added to the directory yet. When an app is configured for self-service, the application owner uses their Access Panel to invite a guest user to an app or add a guest user to a group that has access to the app. Self-service app management for gallery and SAML-based apps requires some initial setup by an admin, which can be summarized as follows:

 -  Enable self-service group management for your tenant
 -  Create a group to assign to the app and make the user an owner
 -  Configure the app for self-service and assign the group to the app

## How to bulk invite Azure AD B2B collaboration users

If you use Azure Active Directory (Azure AD) B2B collaboration to work with external partners, you can invite multiple guest users to your organization at the same time. Specifically, you do the following:

 -  Use **Bulk invite users** to prepare a comma-separated value (.csv) file with the user information and invitation preferences
 -  Upload the .csv file to Azure AD
 -  Verify the users were added to the directory

### Understand the CSV template

Download and fill in the bulk upload CSV template to help you successfully invite Azure AD guest users in bulk. The CSV template you download might look like this example:

:::image type="content" source="../media/understand-template-4329aaff.png" alt-text="Screenshot of a common C S V file opened in spreadsheet format.":::


### CSV template structure

This CSV template will always open with two rows of existing data. The rows in a downloaded CSV template are as follows:

 -  **Version number**: The first row containing the version number must be included in the upload CSV.
 -  **Column headings**: The format of the column headings is **Item name**`[PropertyName]`**Required or blank**. For example, `Email address to invite [inviteeEmail] Required`. Some older versions of the template might have slight variations.
 -  **Examples row**: We have included in the template a row of examples of acceptable values for each column. You must remove the examples row and replace it with your own entries.

### Additional guidance

 -  The first two rows of the upload template must not be removed or modified, or the upload can't be processed.
 -  The required columns are listed first.
 -  We don't recommend adding new columns to the template. Any additional columns you add are ignored and not processed.
 -  We recommend that you download the latest version of the CSV template as often as possible.
