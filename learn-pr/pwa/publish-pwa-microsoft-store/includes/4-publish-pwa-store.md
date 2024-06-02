Publishing your PWA to the Microsoft Store extends its reach to millions of Windows users worldwide. This step transforms your PWA from a web experience to a discoverable application within the Microsoft Store ecosystem. Users can install your app with a single click, enjoy updates via the Store, and experience it as a native-like app on their devices. By following the guidelines to reserve your app name, package your PWA, and submit it, you'll be able to showcase your application to a wider audience and ensure a seamless user experience.

## Package PWA for Microsoft Store

The [PWABuilder](https://aka.ms/pwa/mslearn/data) website packages your PWA for the Microsoft Store. Packaging your PWA involves bundling the necessary files and metadata into a format that's recognized by the Store, enabling users to install and use your app seamlessly.

### Reserve app name

In order to create a proper package of your PWA, you first need to reserve a name for your application in the Microsoft Partner Center.  The Partner Center is a platform that helps you manage and deploy applications to Microsoft's storefronts. Reserving a name also lets you obtain the package info required for PWABuilder's packaging process for submission to the Microsoft Store. Here are the steps to reserve a name:

1. Sign in to the **Partner Center Dashboard**.
1. Navigate to the **Apps and Games** section.
1. Select the **+ New Product** button and select **App**.
1. A prompt to reserve a name for your application submission displays.  Enter your app name.
1. After you reserve your app name, you can access your package info. Navigate to the **Product Identity** section and note the three product identity values on the right side of the page.

    :::image type="content" source="../media/product-identity-values.png" alt-text="Screenshot of PWABuilder that shows the Product identity page.  Three unique product identity values for your product are listed on the right side of the page.":::

    - The first value is your Package ID.
    - The second value is your Publisher ID.
    - The last value is your Publisher Display Name.

1. Copy and save the three values. You need all three to package your app with PWABuilder.

### Package app

Before you can submit your PWA to the Microsoft Store, you need to create the proper packages with PWABuilder.

1. Navigate to **PWABuilder.com**.
1. Enter the **URL** of your PWA on the homepage and select **Start**.

    :::image type="content" source="../media/ship-pwa-app-stores.png" alt-text="Screenshot that shows the Ship your PWA to app stores field on the PWABuilder homepage. Enter the URL to your PWA.":::

1. Select **Package For Stores** to navigate to the **Package Selection** page.
1. Select **Generate Package** underneath **Windows** in the upper left.

    :::image type="content" source="../media/package-selection-pane.png" alt-text="Screenshot of PWABuilder that shows the Package Selection page.  A Windows option is on the left side and an Android option is on the right side.  A Generate Package button is listed for each option.":::

1. A **Package Options** prompt displays. Enter the three product identity values you saved when you reserved your app name.

    :::image type="content" source="../media/enter-3-product-identity-values.png" alt-text="Screenshot of PWABuilder that shows the Windows App Options dialog box.  Within the dialog box, there are three values about your app that you must enter. The Package ID, Publisher ID, and Publisher Display Name.":::

1. Select **Download Package**.

## Submit request to publish PWA

The final step to make your application accessible to users via the Microsoft Store is to submit your PWA through the Partner Center. This process involves uploading your packaged PWA and providing the necessary details about your app. Once you submit your PWA and it's approved, it's available for users to download and install directly from the Store to  increase your application's visibility and reach.

Refer to the following steps to submit your PWA through Partner Center:

1. Navigate to the **Apps and Games** section in the Partner Center Dashboard.
1. Select the listing you created earlier from your app list.

    :::image type="content" source="../media/select-app-name.png" alt-text="Screenshot of the Partner Center Dashboard that shows the apps list.  A sample app named My Cool PWA is highlighted.":::

1. Select the **Start your Submission** button on the next page.
1. You have to complete each section to publish your PWA to the store, but for now, select the **Packages** section.

    :::image type="content" source="../media/submission-options-list.png" alt-text="Screenshot of the Partner Center Dashboard that shows the submission options list.  The Packages option is highlighted.":::

1. Incorporate the .msixbundle and .classic.appxbundle packages that you downloaded from PWABuilder into your submission. Either drag and drop them or use the file browser option to insert them into the Packages section.
1. Select **Save**.
1. After the packages are successfully associated with your submission, you need to add more details about your app. For example, the app's title, description, category, keywords, and screenshots, which appear on the Microsoft Store.
1. After you review and add the details, select **Submit to the Store** to initiate the review process for your PWA.

## PWA review and publishing

After you submit your PWA, it's reviewed for functionality, performance, and policy compliance. The review process usually takes 24 to 48 hours. Once approved, your app is available on the Microsoft Store.

If your app doesn't pass, you receive feedback on the issues to address before resubmission.  
