With attackers and defenders constantly fighting for advantage in the cybersecurity arms race, attackers are always finding ways to evade detection. Inevitably, though, attacks will still result in unusual behavior in the systems being attacked. Microsoft Sentinel's customizable, machine learning-based anomalies can identify this behavior with analytics rule templates that can be put to work right out of the box. While anomalies don't necessarily indicate malicious or even suspicious behavior by themselves, they can be used to improve detections, investigations, and threat hunting:

- **Additional signals to improve detection:** Security analysts can use anomalies to detect new threats and make existing detections more effective. A single anomaly isn't a strong signal of malicious behavior, but when combined with several anomalies that occur at different points on the kill chain, their cumulative effect is much stronger. Security analysts can enhance existing detections as well by making the unusual behavior identified by anomalies a condition for alerts to be fired.

- **Evidence during investigations:** Security analysts also can use anomalies during investigations to help confirm a breach, find new paths for investigating it, and assess its potential impact. These efficiencies reduce the time security analysts spend on investigations.

- **The start of proactive threat hunts:** Threat hunters can use anomalies as context to help determine whether their queries have uncovered suspicious behavior. When the behavior is suspicious, the anomalies also point toward potential paths for further hunting. These clues provided by anomalies reduce both the time to detect a threat and its chance to cause harm.

Anomalies can be powerful tools, but they're notoriously noisy. They typically require much tedious tuning for specific environments or complex post-processing. Microsoft Sentinel customizable anomaly templates are tuned by our data science team to provide out-of-the box value, but should you need to tune them further, the process is simple and requires no knowledge of machine learning. The thresholds and parameters for many of the anomalies can be configured and fine-tuned through the already familiar analytics rule user interface. The performance of the original threshold and parameters can be compared to the new ones within the interface and further tuned as necessary during a testing, or flighting, phase. Once the anomaly meets the performance objectives, the anomaly with the new threshold or parameters can be promoted to production with the click of a button. Microsoft Sentinel customizable anomalies enable you to get the benefit of anomalies without the hard work.


## Work with anomaly detection analytics rules

Microsoft Sentinel’s customizable anomalies feature provides built-in anomaly templates for immediate value out-of-the-box. These anomaly templates were developed to be robust by using thousands of data sources and millions of events, but this feature also enables you to change thresholds and parameters for the anomalies easily within the user interface. Anomaly rules must be activated before they'll generate anomalies, which you can find in the Anomalies table in the Logs section.

1. From the Microsoft Sentinel navigation menu, select Analytics.

1. On the Analytics page, select the Rule templates tab.

1. Filter the list for Anomaly templates:

    - Select the Rule type filter, then the drop-down list that appears below.

    - Unmark Select all, then mark Anomaly.

    - If necessary, select the top of the drop-down list to retract it, then select OK.
    

## Activate anomaly rules
When you select one of the rule templates, you'll see the following information in the details pane, along with a Create rule button:

- **Description** explains how the anomaly works and the data it requires.

- **Data sources** indicates the type of logs that need to be ingested in order to be analyzed.

- **Tactics and techniques** are the MITRE ATT&CK framework tactics and techniques covered by the anomaly.

- **Parameters** are the configurable attributes for the anomaly.

- **Threshold** is a configurable value that indicates the degree to which an event must be unusual before an anomaly is created.

- **Rule frequency** is the time between log processing jobs that find the anomalies.

- **Anomaly version** shows the version of the template that is used by a rule. If you want to change the version used by a rule that is already active, you must recreate the rule.

- **Template last updated** is the date the anomaly version was changed.


Complete the following steps to activate a rule:

- Choose a rule template that isn't already labeled IN USE. Select the Create rule button to open the rule creation wizard.

    The wizard for each rule template will be slightly different, but it has three steps or tabs: General, Configuration, Review and create.

    You can't change any of the values in the wizard; you first have to create and activate the rule.


- Cycle through the tabs, wait for the "Validation passed" message on the Review and create tab, and select the Create button.

    You can only create one active rule from each template. Once you complete the wizard, an active anomaly rule is created in the Active rules tab, and the template (in the Rule templates tab) will be marked IN USE.

Once the anomaly rule is activated, detected anomalies will be stored in the Anomalies table in the Logs section of your Microsoft Sentinel workspace.

Each anomaly rule has a training period, and anomalies won't appear in the table until after that training period. You can find the training period in the description of each anomaly rule.


### Assess the quality of anomalies
You can see how well an anomaly rule is performing by reviewing a sample of the anomalies created by a rule over the last 24-hour period.

- From the Microsoft Sentinel navigation menu, select Analytics.

- On the Analytics page, check that the Active rules tab is selected.

- Filter the list for Anomaly rules (as above).

- Select the rule you want to assess, and copy its name from the top of the details pane to the right.

- From the Microsoft Sentinel navigation menu, select Logs.

- If a Queries gallery pops up over the top, close it.

- Select the Tables tab on the left pane of the Logs page.

- Set the Time range filter to Last 24 hours.

- Copy the Kusto query below and paste it in the query window (where it says "Type your query here or..."):

```KQL
Anomalies 
| where AnomalyTemplateName contains "________________________________"
```

    Paste the rule name you copied above in place of the underscores between the quotation marks.

- Select Run.

When you have some results, you can start assessing the quality of the anomalies. If you don’t have results, try increasing the time range.

Expand the results for each anomaly and then expand the AnomalyReasons field. This will tell you why the anomaly fired.

The "reasonableness" or "usefulness" of an anomaly may depend on the conditions of your environment, but a common reason for an anomaly rule to produce too many anomalies is that the threshold is too low.



### Tune anomaly rules
While anomaly rules are engineered for maximum effectiveness out of the box, every situation is unique, and sometimes anomaly rules need to be tuned.

Since you can't edit an original active rule, you must first duplicate an active anomaly rule, and then customize the copy.

The original anomaly rule will keep running until you either disable or delete it.

This is by design, to give you the opportunity to compare the results generated by the original configuration and the new one. Duplicate rules are disabled by default. You can only make one customized copy of any given anomaly rule. Attempts to make a second copy will fail.

- To change the configuration of an anomaly rule, select the anomaly rule in the Active rules tab.

- Right-click anywhere on the row of the rule, or left-click the ellipsis (...) at the end of the row, then select Duplicate.

- The new copy of the rule will have the suffix " - Customized" in the rule name. To actually customize this rule, select this rule and select Edit.

- The rule opens in the Analytics rule wizard. Here you can change the parameters of the rule and its threshold. The parameters that can be changed vary with each anomaly type and algorithm.

- You can preview the results of your changes in the Results preview pane. Select an Anomaly ID in the results preview to see why the ML model identifies that anomaly.

- Enable the customized rule to generate results. Some of your changes may require the rule to run again, so you must wait for it to finish and come back to check the results on the logs page. The customized anomaly rule runs in Flighting (testing) mode by default. The original rule continues to run in Production mode by default.

- To compare the results, go back to the Anomalies table in Logs to assess the new rule as before, only look for rows with the original rule name and the duplicate rule name with " - Customized" appended to it in the AnomalyTemplateName column.

    If you're satisfied with the results for the customized rule, you can go back to the Active rules tab, select on the customized rule, select the Edit button and on the General tab switch it from Flighting to Production. The original rule will automatically change to Flighting since you can't have two versions of the same rule in production at the same time.


