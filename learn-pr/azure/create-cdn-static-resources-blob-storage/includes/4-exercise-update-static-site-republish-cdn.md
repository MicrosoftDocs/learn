With your delivery network configured, let's verify that your site content is being delivered through the CDN.

In this unit, you'll review how CDNs update content and the delay that you typically see when updating the source files.

## Review both the Origin Server and CDN Versions

Here you'll open the URLs for the origin server and the link to the CDN-published version in different browser windows. You'll then update the origin server with new files and notice how long it takes for that change to propagate.

1. Open a web browser.

1. In the address bar, enter the URL to your origin website in the form **storageaccountnameXXXX.Z22.web.core.windows.net** from the previous exercise. **XXXX** is the random number assigned to your site. Your original website should appear.

1. Open another browser tab.

1. Enter the URL of your Endpoint Hostname from the CDN endpoint in the form **endpointname.azureedge.net**. Again, the replicated copy of your source website should appear. You may see a _Page not Found_ if the content hasn't propagated. Propagation can take a few minutes to complete and you may need to refresh the page.

1. Place both windows side by side on your screen. Both URLs can be found in the Azure portal, on the overview tab for the Endpoint you created in the previous exercise.

## Change the Origin Files

1. Navigate to the website source code in Cloud Shell if you're not there already:
```azurecli
cd source/website-files
```

1. Open the index.html file in the code editor.
```azurecli
code index.html
```

1. Change the ```H1``` tag to a message of your choice. (try "Hello CDN!")

1. Save and close the editor.

1. Upload the changed index.html to the $web blob storage container.

```azurecli
    az storage blob upload-batch -s . -d \$web --account-name $STORAGE_ACCOUNT_NAME
```

## Verify site changes

1. Switch to the browser connecting to the source URL (web.core.windows.net) and press F5 to refresh the page. The changes to the image and text should appear immediately.

1. Switch to the **storageaccountnameXXXX.azureedge.net** browser window and press F5 until the change appears. This operation should take less than 10 minutes to complete.

1. You may continue to the next unit while you wait for the CDN to update.
