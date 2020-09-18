So far, you've connected your coffee machine to the Azure IoT Central application, enabling the exchange of data that allows you to monitor and manage your coffee machine. In this unit, you create rules that trigger actions when the water temperature of the coffee machine is outside the normal range.

## Create rules in IoT Central with email as the action

Azure IoT Central has its native email capabilities to send notifications. In this scenario, if the coffee machine is outside the optimal temperature range, an email is sent by IoT Central to the client's maintenance department.

1. Navigate to the **Rules** page of your Azure IoT Central application in Azure IoT Central and select **+ New**.

1. Enter the rule name `Coffee Maker Water Temperature too low`.

1. Select the **Connected Coffee Machine** device template.

1. Add the condition **Water Temperature** is less than **Coffee Maker Min Temperature** to the rule. Then click **Save**.

    ![Screenshot showing the rules page of the connected coffee machine device template with a new rule added in the Configure Telemetry Rule pane.](../media/5-flow-a.png)

1. Scroll down on the **Coffee Maker Water Temperature out of range** rule page and choose **+ Email** in the **Actions** section.

1. Enter _Temperature too low_ as the display name.

1. Enter the email address that you used to sign in to the IoT Central application and add the note _Coffee maker's water temperature is too low. Maintenance is required._

1. Choose **Done**. Your rule is listed on the **Rules** page.

1. Add another similar rule to notify you when the water temperature is higher than **Coffee Maker Max Temperature**.

To trigger the first rule, set the optimal temperature on the **Properties** page for your device to _92_. Once you're done with the validation, turn off the rules to avoid flooding your inbox with emails.
