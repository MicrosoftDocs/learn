Finally, you'll use the Azure DevOps environment to follow up on the results from the quick load test in Azure portal. In your role as the lead web developer for the costume rental company, you'll check whether the extra functionality in the Azure DevOps environment can help you identify causes for the slow graphics performance. You also want to see how your app performs when more real-world elements are incorporated into the tests, including testing more than one URL and testing the URL query strings that your app uses to show product details. You'll perform these tests by using HAR files to see how your app performs against a typical user session.

### Performance testing with HAR files

In the real world, website users rarely stay on one page. To make your test scenarios more realistic, you need to include multiple URLs and, if applicable, other options like query string tests. You can use the Azure DevOps Portal to configure performance tests that include these options, but it can be time consuming to configure such tests, and you might still end up with a set of tests that don't correlate closely with how users actually use your site.

In this step, you'll record a sample user session by using browser developer tools and then save the session as a HAR file. The HAR file will include all the pages, links, URLs, and queries from the session. After you record the session, you'll start a new test that will use the HAR file as a test script.

1. In Chrome, open a new tab, select the ellipsis button (...), select **More tools**, and then select **Developer Tools**. If you're using Microsoft Edge, open a new tab, select the ellipsis button (...), select **Developer Tools**, and then select the **Network** tab.
1. Make sure the recording button is on (it should be red) and select the **Preserve log** check box. (Chrome only.)
1. With the developer tools window open, go to **https&#58;//contosorentalsapp\<your-number>.azurewebsites.net**.
1. Click through the following scenario. (Wait for each page to load completely before continuing.)
   1. When the home page is loaded, select the **Services** link.
   1. On the Services page, select the first item.
   1. On the Service details page, select the **Go back** link.
   1. Repeat the previous steps for the second and third items.
   1. Select the **Home** link.
1. To save the recording in Chrome, in the developer tools window, set the recording button to off (it should be black), right-click in the URL list and select **Save as HAR with content**, and then save the file to your computer. To save the recording in Microsoft Edge, in the developer tools window, set the recording button to off (it should be green), select **Export as HAR**, and then save the file to your computer.
1. You can now close the developer tools window.
1. Switch to the Azure DevOps Portal and, on the **Load test** page, select **New** and then select **HTTP Archive-based test**.
1. In the **Import HTTP Archive file** dialog box, select **Choose File**, browse to where you saved your HAR file, select the file, select **Open**, and then select **OK**.
1. In the name box, type **DevOpsPerfTest02**. Note the URLs, headers, and QueryString parameters that were saved to the HAR file.
1. Select **Settings** and change the **Run duration** to 1 minute. Change the geo-location to the one you used in unit 2.
1. Select **Save**, and then select **Run test**.
1. When the test is done, note the average response time. How does it compare to the previous results? Do the HAR test results show that the app is better or worse than the single-URL test results?
