
In this module, you've learned that speaker recognition is composed of two main aspects: verification and identification.

The Speaker Verification API can automatically verify and authenticate users by using their voice or speech. Each voice has unique characteristics that can be used to identify a person, just like a fingerprint. Using voice for access control not only offers better security, but also simplifies the authentication experience for customers.

Given a group of prospective speakers, the Speaker Identification API can automatically identify the person speaking in an audio file. The API compares the input audio to the provided group of speakers, and if it finds a match, it returns the speaker's identity. All the speakers you want to compare should go through an enrollment process first to get their voices registered to the system and have voice prints created.

## Cleanup

To avoid any unexpected costs in your Azure account, delete the **mslearn-speakerapi** resource group. Deleting this group will remove all the resources we created in this module. Here are the steps you need to take:

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).
1. In the left pane, select **Resource groups**, and then find the **mslearn-speakerapi** resource group.
1. Select the resource group, and either right-click the row or use the **ellipsis** (...) button to open the context menu.
1. Select **Delete resource group**.
1. Enter the name of the **mslearn-speakerapi** resource group, and then select **Delete**. Azure will remove all the resources for you.
