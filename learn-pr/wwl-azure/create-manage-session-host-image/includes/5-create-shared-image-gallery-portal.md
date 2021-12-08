An image gallery is the primary resource used for enabling image sharing. Allowed characters for Gallery name are uppercase or lowercase letters, digits, dots, and periods. The gallery name cannot contain dashes. Gallery names must be unique within your subscription.

The following example creates a gallery named *myGallery* in the *myGalleryRG* resource group.

1.  Sign in to the Azure portal.
2.  Use the type **Shared image gallery** in the search box and select **Shared image gallery** in the results.
3.  In the **Shared image gallery** page, click **Add**.
4.  On the **Create shared image gallery** page, select the correct subscription.
5.  In **Resource group**, select **Create new** and type *myGalleryRG* for the name.
6.  In **Name**, type *myGallery* for the name of the gallery.
7.  Leave the default for **Region**.
8.  You can type a short description of the gallery, like *My image gallery for testing.* and then click **Review + create**.
9.  After validation passes, select **Create**.
10. When the deployment is finished, select **Go to resource**.:::image type="content" source="../media/image-gallery-3665d981.png" alt-text="Screenshot of image gallery definition.":::
    

## Create an image definition

Image definitions create a logical grouping for images. They are used to manage information about the image versions that are created within them. Image definition names can be made up of uppercase or lowercase letters, digits, dots, dashes and periods.

Create the gallery image definition inside of your gallery. In this example, the gallery image is named *myImageDefinition*.

1.  On the page for your new image gallery, select **Add a new image definition** from the top of the page.
2.  In the **Add new image definition to shared image gallery**, for **Region**, select *East US*.
3.  For **Image definition name**, type *myImageDefinition*.
4.  For **Operating system**, select the correct option based on your source VM.
5.  For **VM generation**, select the option based on your source VM. In most cases, this will be *Gen 1*.
6.  For **Operating system state**, select the option based on your source VM.
7.  For **Publisher**, type *myPublisher*.
8.  For **Offer**, type *myOffer*.
9.  For **SKU**, type *mySKU*.
10. When finished, select **Review + create**.
11. After the image definition passes validation, select **Create**.
12. When the deployment is finished, select **Go to resource**.:::image type="content" source="../media/image-gallery-definition-5a73ced9.png" alt-text="Screenshot of gallery image definition.":::
    

## Create an image version

Create an image version from a managed image.

When choosing target regions for replication, remember that you also have to include the *source* region as a target for replication.

Allowed characters for image version are numbers and periods. Numbers must be within the range of a 32-bit integer. Format: *MajorVersion*.*MinorVersion*.*Patch*.

1.  In the page for your image definition, select **Add version** from the top of the page.
2.  In **Region**, select the region where your managed image is stored. Image versions should be created in the same region as the managed image they are created from.
3.  For **Name**, type *1.0.0*. The image version name should follow *major*.*minor*.*patch* format using integers.
4.  In **Source image**, select your source-managed image from the drop-down.
5.  In **Exclude from latest**, leave the default value of *No*.
6.  For **End of life date**, select a date from the calendar that is a couple of months in the future.
7.  In **Replication**, leave the **Default replica count** as 1. To replicate to the source region, leave the first replica as the default and then pick a second replica region to be *East US*.
8.  Select **Review + create**. Azure will validate the configuration.
9.  When image version passes validation, select **Create**.
10. When the deployment is finished, select **Go to resource**.

It can take a while to replicate the image to all of the target regions.

## Share the gallery

We recommend that you share access at the image gallery level. The procedure below walks you through sharing the gallery that you created.

1.  On the page for your new image gallery, in the menu on the left, select **Access control (IAM)**.
2.  Under **Add a role assignment**, select **Add**. The **Add a role assignment** pane will open.
3.  Under **Role**, select **Reader**.
4.  Under **assign access to**, leave the default of **Azure AD user, group, or service principal**.
5.  Under **Select**, type in the email address of the person that you would like to invite.
6.  If the user is outside of your organization, you will see the message. This **user will be sent an email that enables them to collaborate with Microsoft.** Select the user with the email address and then select **Save**.

If the user is outside of your organization, they will receive an email invitation to join the organization. The user needs to accept the invitation to be able to see the gallery and all of the image definitions and versions in their list of resources.
