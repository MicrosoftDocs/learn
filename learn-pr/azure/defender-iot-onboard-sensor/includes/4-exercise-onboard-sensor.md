This unit describes how to onboard an OT sensor to Defender for IoT in the Azure portal. You onboard a cloud-connected sensor for your car manufacturer's sales floor in the Paris office.

Once the sensor is onboarded, an activation file and a list of endpoints file are available for download. These files are stored and used in the deployment phase to activate your sensor.

## Onboard your cloud-connected OT sensor

1. In the Azure portal, go to **Defender for IoT > Getting Started** and select **Set up OT/ICS Security**.

    The Set up OT/ICS Security screen appears.

1. In **Step 3: Register this sensor with Microsoft Defender for IoT**, add the following values for your sensor:

    - **Sensor name**: You're onboarding a sensor for your Sales department in your Paris office. Make it easy to identify your sensor later and type **paris-sales** as the sensor name.

    - **Subscription**: Select your Azure subscription.

    - **Cloud-connected**: Toggle on this option to ensure that your sensors send data to the Azure portal.

    - **Automatic Threat Intelligence updates**: Toggle on this option to ensure that security updates automatically push threat intelligence packages to your OT sensor.

    - **Site**: Type the following information:
        - **Resource name**: Select **Create site** to create a new site for your Paris office.
        - In the **New site** field, type **paris**, and select the checkmark button.
        - From the **Site size** menu, select your site's size. The sizes listed in this menu are the sizes that you're licensed for, based on the licenses you'd purchased in the Microsoft 365 admin center. If you're working with a trial license, you have the **Large** site listed.

    - **Display name**: Enter **Paris** again as a meaningful name for your site to display across Defender for IoT.

    - **Zone**: Select **Create zone** to create a new zone for your sales floor.
        - In the **New site** field, type **Floor 1 Sales**, and select the checkmark button.
    - For this exercise, leave the **Tags** value blank. Tags are extra, customizable values that you can add to help you identify your sensor.

An example, completed OT set up form:

:::image type="content" source="../media/4-operational-technology-onboarding-complete-form.png" alt-text="screenshot of a completed OT onboarding form." border="false":::

In a real-life scenario, you might use the links and options on this page to add a new subscription, or to select a site or zone that was added previously, when onboarding an earlier sensor. You'd clear options for **Cloud connected** and **Automatic Threat Intelligence updates** to retain more on-premises control of your sensor.

1. Select **Register** to complete the onboarding.

    A new page opens, with a succeess message and additional information. The activation file automatically downloads.

1. In the **Add outbound allow rules** area, select the **Download** link to download a JSON list of the endpoints you must configure as secure endpoints from your sensor. Save the downloaded file locally.

:::image type="content" source="../media/4-download-endpoint-file.png" alt-text="Screenshot of the Set Up OT sensor success page for downloading endpoint list." lightbox="../media/4-download-endpoint-file.png":::

- Select **Finish** and your sensor is now shown in Defender for IoT's **Sites and sensors** page.

## Check your work

The sensor is now onboarded to Defender for IoT and displays in your **Sites and sensors** page with a status of **Pending Activation**.

In a later stage, you'll need the activation and endpoints file, so ensure they're available for the deployment team to use when activating the sensor.
