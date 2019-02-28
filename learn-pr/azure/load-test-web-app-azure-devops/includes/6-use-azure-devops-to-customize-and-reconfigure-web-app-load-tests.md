Finally, you'll use the Azure DevOps environment to follow up the results from the quick load test in Azure portal. In your role as the lead Web developer for the costume rental company, for example, you'll use the DevOps tools to see if the extra functionality in the DevOps environment can help identify any causes of the slow graphics performance. You also want to see how your app performs when more "real world" elements are incorporated into the tests, including testing more than one URL, and testing the URL query strings that your app uses to show product details; you'll do this by using HAR files to see how your app performs against a typical user session.

### Performance testing using HAR files
In the real world, website users rarely stay on one page, so for more realistic test scenarios, your tests need to include multiple URLs and, if applicable, other options such as using query strings. You can use the Azure DevOps Portal to configure performance tests that include these options, but it can be time-consuming to configure such tests, and you may still end up with a set of tests that do not correlate closely with how users actually use your site.

In this step, you're going to record a sample user session, using browser developer tools, then save this session as a HAR file. The HAR file includes all the pages, links, URLs, and queries from the session. After you have recorded the session, you'll start a new test, which will use this HAR file as a test script.

1. In Chrome, open a new tab, click the three dots, and then click **More tools**, and then click **Developer Tools**; if you are using Microsoft Edge, open a new tab, click the three dots, then click **Developer Tools**, and then click the **Network** tab.
1. Check that the recording button is **on** (shows red), and select the **Preserve log** checkbox (Chrome only).
1. Keep the developer tools window open, and go to **https&#58;//contosorentalsapp\<_your-number\ >.azurewebsites.net**.
1. Click through the following scenario (wait for each page to load completely before continuing):
   - When the home page has loaded, click the **Services** link.
   - On the **Services** page, click the first item.
   - On the Service details page, click the **Go back** link.
   - Repeat the previous steps for the second and third items.
   - Click the **Home** link.
1. To save the recording in Chrome, in the developer tools window, set the recording button to **off** (shows black), then right-click in the URL list, and in the shortcut menu, click **Save as HAR with content**, and save the file to your computer; to save the recording in Microsoft Edge, in the developer tools window, set the recording button to **off** (shows green), then click **Export as HAR**, and save the file to your computer.
1. You can now close the developer tools.
1. Switch to the Azure DevOps Portal and, in the **Load test** page, click **+ New**, and then click **HTTP Archive-based test**.
1. In the **Import HTTP Archive file** dialog box, click **Choose File**, browse to where you saved your HAR file, select the file, click **Open**, and then click **OK**.
1. In the name box, type **DevOpsPerfTest02**, and then note the URLs, Headers, and QueryString Parameters that were saved to the HAR file.
1. Click **Settings**, and change the **Run duration** to 1 minute, and the geo-location to the one you used in Unit 2.
1. Click **Save**, and then click **Run test**.
1. When the test has completed, note the average response time; how does this compare to the previous results? Do the HAR test results  show the app to be better or worse than the single URL tests?
