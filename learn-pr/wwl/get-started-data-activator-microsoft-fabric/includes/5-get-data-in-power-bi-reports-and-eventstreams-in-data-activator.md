

Data Activator offers the feature of triggering notifications when the observed data meets predetermined conditions. This unit guides you through the process of setting up these alerts in the context of Power BI reports and Azure Event Hubs.

## Power BI Reports

Using Data Activator, you can set up notifications that get triggered based on specific conditions met by the data in a Power BI report. Consider a scenario where you have a Power BI report that tracks the monthly website traffic. You can configure Data Activator to send an alert if the traffic falls below a certain threshold at any given time, enabling you to respond promptly.

### Prerequisites

Ensure you have a Power BI report published online to a Fabric workspace in a Premium capacity before you start. Data Activator currently supports Power BI visuals that have both an X-axis and Y-axis, excluding time dimension visuals on the X-axis.

### Steps

1. **Trigger Action Selection on Power BI Visual:** 
    * Open your Power BI report and select a visual that Data Activator will keep an eye on, ensuring it's a supported visual type. 
    * Select the ellipsis ("...") at the top right of the visual and select "Trigger Action".

2. **Creation of Data Activator Trigger:** 
    * Begin to define your trigger conditions. In the appearing "Create Alert" dialog, you need to complete the "What to monitor" section. This informs Data Activator about the measure it should keep track of and the frequency of checking its value. 
    * Fill out the "What to detect" section, defining your trigger condition. Data Activator will send a notification once this condition is met. 
    * Lastly, fill out the "Where to save" section, informing Power BI where to store your Data Activator trigger. You have the option to either select an existing reflex item or create a new one. Select "Continue" to proceed.

3. **Adding an Action to Your Trigger:** 
    * The last step is to determine the kind of notification that Data Activator will send when your trigger fires. Follow the steps in the “Adding an action to your trigger” section to add an email or Teams notification to your trigger.

## Azure Event Hubs

Data Activator can also send out notifications based on data streaming into Azure Event Hubs, making it a valuable tool for real-time monitoring.

### Prerequisites

To begin with, you need a reflex item and an Azure Event Hubs Instance. Ensure that every event in the instance is in the JSON dictionary format and that at least one of the keys in the dictionary uniquely identifies an object.

### Steps

1. **Retrieve the Connection String for Azure Event Hubs Instance:** 
    * Start by navigating to your Event Hubs instance in the Azure portal. Choose "Shared Access Policies" from the navigation menu in your instance. 
    * Select (or create) an access policy with at least "Listen" permission. Copy the primary connection string of the access policy.

2. **Connect Your Reflex Item to Azure Event Hubs Instance:** 
    * Within the "Data" tab of your reflex item, select "Get Data". In the appearing "Get data" dialog, paste the connection string you copied in the previous step. Assign a name to your event stream.
    * Provide a consumer group if you wish not to use the Default group, and select "Connect".

Shortly, the events from your Event Hubs are visible in your new event stream, enabling real-time monitoring and notifications based on your set conditions.