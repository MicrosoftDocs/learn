So far, you've connected your coffee machine to the Azure IoT Central application, enabling the exchange of data that allows you to monitor and manage your coffee machine. In this unit, you create rules that trigger actions when the water temperature of the coffee machine is outside the normal range. 

## Create rules in IoT Central with email as the action

Azure IoT Central has its native email capabilities to send notifications. In this scenario, if the coffee machine is outside the optimal temperature range and is not protected by the warranty, an email is sent by IoT Central to the client’s maintenance department.

1. Navigate to the **Rules** page for the exercises in this unit and enter edit mode by selecting **Edit Template** on the right. 
1. Select **+ New Rule** and then **Telemetry**. 

1. Enter the name `Coffee Maker Water Too Cold (Expired)`

1. Add the following conditions to the rule by selecting the plus (**+**) sign to the right of **Conditions**, and then click **Save**:      
    - Water Temperature is less than Coffee Maker's Min Temperature
    - Device Warranty Expired equals 1

    ![Screenshot showing the rules page of the connected coffee maker device template with a new rule added in the Configure Telemetry Rule blade.](../media/5-flow-a.png)

1. Scroll down on the **Configure Telemetry Rule** panel and choose **+** next to **Actions**, and then choose **Email**.

1. Enter the email address that you used to sign in to the IoT Central application and add the note `Coffee maker's water is too cold. Maintenance is required.  Warranty has expired.`

1. Choose **Save**. Your rule is listed on the **Rules** page.

Now let's repeat these steps for the case when the water is too hot. 

1. Select **+ New Rule** and then **Telemetry**.

1. Add a new rule and give it the name `Coffee Maker Water Too Hot (Expired)`

1. Add the following conditions to the rule by selecting the plus (**+**) sign to the right of **Conditions**, and then click **Save**:      
    - Water Temperature is greater than Coffee Makers Max Temperature
    - Device Warranty Expired equals 1

1. Scroll down on the **Configure Telemetry Rule** panel and choose **+** next to **Actions**, and then choose **Email**.

1. Enter the email address that you used to sign in to the IoT Central application and add the note `Coffee maker's water is too cold. Maintenance is required.  Warranty has expired.`

1. Choose **Save**. Your rule is listed on the **Rules** page.

To trigger the rule, set the optimal temperature in **Settings** outside the range that you specified under **Properties**. Once you are done with the validation, turn off the rules to avoid flooding your inbox with emails.