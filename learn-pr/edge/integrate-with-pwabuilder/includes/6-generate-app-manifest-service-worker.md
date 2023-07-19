In this exercise, you'll practice generating an app manifest and service worker for a demo website using PWABuilder. Follow the steps below:

## Generate app manifest

1. If your previous session on PWABuilder is still active, continue from where you left off. If not, navigate to PWABuilder and enter the URL for the website you're converting to a PWA. For this exercise, we'll use <https://webboard.app/>. Select **Start** to analyze the demo website's PWA readiness.
1. In the **Manifest** section, select **Edit Your Manifest** to generate and customize the App Manifest.

    :::image type="content" source="../media/select-edit-your-manifest-button.png" alt-text="Screenshot of PWABuilder's report card page that shows the Manifest section. The Edit Your Manifest button on the right side of the Manifest section is highlighted.":::

1. Complete the necessary fields, such as name, short name, theme color, and background color.

    :::image type="content" source="../media/manifest-editor-modal-info-pane.png" alt-text="Screenshot of PWABuilder's Manifest Editor modal with the Info pane open.":::

1. Select the **Icons** tab and upload an appropriate icon.

    :::image type="content" source="../media/manifest-editor-modal-icons-pane.png" alt-text="Screenshot of PWABuilder's Manifest Editor modal with the Icons pane open.":::

1. You can also edit other manifest sections through all the tab options.
1. Scroll down and select the **Download Manifest** button to save the generated manifest file.

    :::image type="content" source="../media/manifest-editor-modal-download-manifest-button.png" alt-text="Screenshot of PWABuilder's Manifest Editor modal with the bottom of the Icons pane showing. A Download Manifest button is located on the bottom right.":::

## Generate service worker

1. Go to the **Service Worker** section and select **Generate Service Worker**.

    :::image type="content" source="../media/generate-service-worker-button.png" alt-text="Screenshot of PWABuilder Service Worker page. Select the Generate Service Worker button located on the page.":::

1. Choose a service worker template based on your needs ("Offline page," "Offline copy with Backup offline page," or "Advanced caching").

    :::image type="content" source="../media/download-a-service-worker-page.png" alt-text="Screenshot of the Download a Service Worker page in PWABuilder that shows the three prebuilt Service Workers packages available to download. Select one of the packages.":::

1. Scroll down and select **Download Service Worker** to save the generated service worker file.

## Validate

Once you complete the exercise, verify that you successfully generated the following files:

- An App Manifest file (manifest.json) with the correct information and icon.
- A Service Worker file (sw.js) based on the selected template.
