<!-- can use this article for screenshots as well /organizations/how-to-manage-cloud-alerts -->
Your sensor is now fine tuned and almost fully operational. The final stage is to create a baseline of alerts so that Microsoft Defender for IoT understands the normal type of traffic flow through your system. Then, Defender for IoT is able to identify which traffic is most dangerous or suspicious and produces accurate alerts. This *learning* process can take a week or two as you define correct alerts for Defender for IoT to flag.

Once the learning stage is complete, Defender for IoT moves to the <!-- what is the next stage called? --> stage and creates an accurate baseline of alerts to work from and protect your devices. It's still possible that you have to add new alerts but this occurs on a less regular basis than in the initial period.

## OT sensor learning mode

The following diagram shows the complete OT deployment path, with the team responsible for each phase:

:::image type="content" source="../media/5-ot-deploy.png" alt-text="Diagram of the complete OT deployment process" border="false":::

This Learn Module is divided into two sections.

Section 1: units 3 and 4 dealing with calibrating and fine-tuning your sensor.
Section 2: units 6 and 7 dealing with triaging the alerts.

Units 6 and 7 describes the sixth and final phase in the deployment: *Baseline learning ends*. In a real-life scenario, the deployment and connectivity teams ensure that the sensor is already activated, sending data to Defender for IoT, and is fine-tuned.

The sensor baseline learning is the phase where Defender for IoT identifies suspicious or harmful traffic and creates a list of alerts for each of them. When this traffic is identified in the future, alerts are sent to Defender for IoT, and you're able to contain and protect your devices. You must monitor these alerts and in some cases adjust them to be more accurate. This process can take anywhere from a few days to several weeks, depending on the complexity and size of your network.
Over a period of weeks Defender for IoT reaches a mature stage and doesn't need regular assessment, and then ends the *Learning* mode and moves to the *operational* mode.  

## In this phase

### Triage alerts

Once the sensor is set up and sends data, Defender for IoT starts to identify normal and irregular traffic flow within the network. This state is called the learning mode, where Defender for IoT identifies regular activity, such as regular file transfers or data flows between devices. This regular activity is logged and won't trigger an alert in the future. Any traffic in the network that doesn't match these triggers an alert.

The new alerts that are sent to Defender for IoT must be checked and in some cases you need to adjust their status. This way Defender for IoT learns which alerts are real cases of harmful traffic and which are unsuspicious and can be added to the baseline. The learning process can take several weeks to complete.

### End the learning mode

The learning mode will turn off when the sensor detects a decrease in the number of new alerts produced, which is typically 2-6 weeks after deployment. You can also turn off the learning mode manually when you feel that the alerts accurately reflect your network activity.

As new alerts are detected in the future, they can be set, individually, to learning mode, and then included in a new baseline once the sensor correctly identifies them. This ensures that your baseline of alerts is up to date, doesn't miss new types of suspicious traffic and keeps your network and devices safe.

## Copied from unit 3 - should be mixed in here

<!-->
## OT sensor deployment path

The following diagram shows the complete OT deployment path, with the team responsible for each phase:

:::image type="content" source="../media/2-ot-deploy.png" alt-text="Diagram of the complete OT deployment process" border="false":::

This module describes the sixth phase in the deployment: *Baseline learning ends*. In a real-life scenario, the deployment and connectivity teams ensure that the sensor is already onboarded, activated and sending data to Defender for IoT.

The OT baseline learning is the phase where Defender for IoT enters the Learning mode. Defender for IoT learns which types of alerts are important and critical, and which are lower level alerts that can be filtered out. You review the alerts after Defender for IoT generates them and adjust their status when needed. After a limited period Defender for IoT moves from *Learning* mode and into *operational* mode.  

During this time Defender for IoT analyzes the flow of data and generates different types of alerts to warn of security problems. You must look over these alerts and confirm or dismiss them appropriately. As Defender for IoT processes more alerts and applies your inputs, it learns which are proper alerts and which are either less important or aren't actually alerts at all. Over a period of weeks Defender for IoT reaches a mature stage and doesn't need regular assessment, and then ends the *Learning* mode and moves to the *operational* mode.  
-->
## The Learning mode

The *learning* mode is the important, initial stage for Defender for IoT to understand which activities are normal and regular and which aren't. During this period, your OT sensor learns to identify normal network activity, including the devices and protocols in your network and the regular file transfers that occur between specific devices. At the same time the sensor is producing a set of alerts for suspicious traffic. These alerts form the baseline of OT alerts for tracking activity when the system moves to the *operation* mode.

As alerts arrive, you check that they're correctly assigned. In some cases during this phase, the alerts will be incorrect and you'll need to change the automatic settings so that the sensor learns that future traffic like this is safe.

In the early stages, you need to spend more time checking the alerts. Depending on the size and complexity of the system the learning mode could last from 2-6 weeks, and automatically turn offs when the sensor detects a decrease in newly detected alerts. However, you can also manually turn off the learning mode if you think that alerts produced accurately represent the network activity.

Even in the *operation* mode, new inaccurate alerts might be generated, and you can assign these alerts to a learning status to teach the sensor that they need to be added to the existing baseline alerts.

## Creating the alerts baseline

The best way to create the alert baseline is following the triage process. <!-- not sure about this, is there a better way to describe this? I think that the following is the triage process, even though I am not sure it is properly spelt out as a process in the article "how to view alerts" I suggest listing the steps of triage, and then numbering the heading to make the process clear to the reader -->

The process is:

1. Filter the alerts - by time, severity or other parameter.
1. Group alerts - a different filter option based on the groups created in the device map or inventory sections. (Although we haven't mentioned this properly)
1. Choose an alert, open the alert details pane, analyze the displayed information to decide if this alert needs to be adjusted.
1. You might also want to check the raw data files, called PCAP files. These can be downloaded and assessed and then changes to the alerts made accordingly.
1. Add comments to alerts to communicate between team members and make decisions.
1. save any changes you have made, such as authorizing an alert.

<!-- rewrite above in sentences or leave as is? -->
<!--at num3  https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/how-to-view-alerts#view-details-and-remediate-a-specific-alert this starts with 1. sign into the OT sensor. I suggest removing this line, we are already there, as mentioned above. Why would we add this here?  -->
<!-- at end! https://learn.microsoft.com/en-us/azure/defender-for-iot/organizations/how-to-view-alerts#manage-alert-status-and-triage-alerts the first sentence is confusing. Does this mean save any changes i have made to the alert? Or something else. If it does then I would put it near the end of the entire section of article. but not at the beginning, or it is it at the beginning that it is clear it relates to actions for when you have finished your work-->
Could list alert status options - but I think they're better to be added to the exercise stage.

## Outcome of this process

When you complete the triage process and the operational mode is enabled, your deployment of the OT sensor to Defender for IoT is complete. The sensor now has a verified baseline of alerts and understands the types of traffic that is considered safe and secure. In the future any network traffic that doesn't match this triggers a new alert. You're able to set these to be learnt by the sensor as well, and are added to create a new and improved baseline.  

## Managing OT alerts in a hybrid environment

Your organization might also have access to the OT sensor from a virtual machine, <!-- from the sensor itself (Im not sure about this , this could be on prem) --> or through Defender for IoT. This multi access set up is called a hybrid environment. In this set up, changes made on one system synchronize across the other systems, so that updates or changes made only on one system aren't lost. When you return to the other system you see the changes already displayed in the relevant information.

<!--> So in the second link above, managing OT hybrid, do we need to mention the different status names? differences across platforms? Dont mention On Prem and the associated name issues. -->
