Running scans in Microsoft Priva Tracker Scanning allows your organization to identify and analyze tracking technologies across registered websites. These scans help ensure compliance with privacy practices by detecting tracking technologies such as cookies, fingerprints, local storage objects, and web beacons. With customizable options, you can configure scans to meet your organization's specific requirements.

## Setting up a scan

Before running a scan, ensure that the website is registered and tracker categories are configured. Once these prerequisites are complete, follow these steps to configure a scan:

1. Navigate to the **Registered websites** page and select the website you wish to scan.
1. On the website's details page, select **New compliance scan**.
1. In the **Scan** flyout pane, provide the following details:
   - **Compliance scan name**: Enter a unique name for the scan. This name can't be changed after creation.
   - **Description**: Add a brief description of the scan's purpose.
   - **Scan region**: Select the region where the scan will be performed, such as East US, UK South, or West Europe. This option simulates how the website operates under the privacy requirements of the chosen region.
   - **Crawl definition**: Select one of the following options for the scan:
     - **Registered URL only**: Scans only the first page of the registered domain.
     - **Crawl (registered URL + two levels)**: Scans the registered domain and up to two levels of pages linked within the domain.
     - **Sitemap**: If your website has a sitemap, provide its URL. This option scans all pages identified in the sitemap (up to 3 MB in size).
   - **Limit scan to**: Define the maximum number of pages to scan. Increasing this limit can result in longer scan times and varying costs.

1. Select **Continue** to move forward with configuring more scan options.

## Configuring tracker technologies and compliance objects

In this step, define what the scan should detect:

:::image type="content" source="../media/run-tracker-scanner.png" alt-text="Screenshot showing the trackers and tags for tracker scanner to detect." lightbox="../media/run-tracker-scanner.png":::

- **Tracker technologies**: Select the types of trackers to scan for. Options include:
  - **Cookies**: First- and third-party cookies deployed when a webpage loads.
  - **Fingerprints**: Device and browser fingerprints used for configurations or profiling.
  - **Local storage**: Local storage objects stored on a visitor's device.
  - **Web beacons**: Invisible images or scripts used for tracking user behavior.
- **Tags and relationships**: Choose whether to capture associated tags and relationships for the selected trackers. This option helps map relationships between trackers and their deployment.

- **Compliance objects**: Select compliance elements to verify their presence on the website. Common compliance objects include:
  - **Consent banners**
  - **Privacy statements**

To add a compliance object, enter its location path manually or use the Microsoft Edge extension to generate and upload a JSON file. For more information, see [Collecting location paths](/privacy/priva/location-paths?azure-portal=true).

## Scheduling scans

You can set up scans to run either as a one-time event or on a recurring schedule. To schedule scans:

1. On the **Set a scan trigger** page, choose a frequency:
   - **Once**: Run the scan immediately after setup.
   - **Recurring**: Schedule the scan to run daily, weekly, or monthly. Specify start and end dates, and select specific days for weekly or monthly scans.
2. Select **Continue** to finalize the schedule.

## Reviewing and initiating scans

Before running the scan, review the scan settings on the **Review your scan** page:

1. Verify all configurations, including the scan name, region, tracker technologies, and compliance objects.
2. Select one of the following options:
   - **Save**: Save the scan without running it.
   - **Save and run**: Save the scan and initiate it immediately.

Once the scan is complete, results are available on the **Scan results** page, where you can analyze detected trackers, review compliance objects, and address potential issues.

Running scans in Microsoft Priva Tracker Scanning is a critical step for maintaining compliance with privacy regulations and ensuring transparency in your organization's tracking practices. By using features like regional scanning, customizable tracker detection, and recurring schedules, you can proactively manage compliance and support responsible data practices.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)
