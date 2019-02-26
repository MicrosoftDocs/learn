
In this module, you've learned that Speaker Recognition is composed of two main aspects: verification and identification.

Speaker Verification APIs can automatically verify and authenticate users using their voice or speech.  Voice has unique characteristics that can be used to identify a person, just like a fingerprint. Using voice as a signal for access control and authentication scenarios has emerged as a new innovative tool – essentially offering better security that simplifies the authentication experience for customers.

Speaker Identification APIs can automatically identify the person speaking in an audio file, given a group of prospective speakers. The input audio is paired against the provided group of speakers, and in the case that there's a match found, the speaker identity is returned. All speakers should go through an enrollment process first to get their voice registered to the system, and have a voice print created.

## Cleanup

To avoid any unexpected costs in your Azure account, delete the **mslearn-speakerapi** resource group. This will remove all of the resources we created in this module. Here's the steps you need to do.

1. Find the **mslearn-speakerapi** resource group. Select **Resource groups** in the Azure sidebar to quickly locate it.

1. Select the resource group and either right-click on the row, or use the "..." button on the far-right side of the row to open the context menu.

1. Select **Delete resource group**.

1. Type the name of the resource group and click **Delete**. Azure will de-provision all of the resources for you.