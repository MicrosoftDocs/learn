In this unit, you'll do an exercise using the Azure portal. As your band is on tour next month, you're expecting a spike in traffic. During the tour, you want to make sure your website is accessible to fans. Now you'll create an alert based on CPU usage. If the CPU usage goes above the set threshold for one minute, you'll get an email notification. This notification will help to ensure important website services remain available to customers. If there are any issues, or CPU usage is too high, you'll be notified by email.

1. Create an alert based on CPU usage. If CPU usage goes above 3 percent for one minute, you get a notification. In the real world, the number would be around 70-80 percent. For this exercise, the number is low so you can easily trigger the alert:<!--CE:PLease look carefully at the following steps. Use of some bold here might make the content a little clearer. Also, the bullets need to be consistent.-->
      - Go to your virtual machine.
        - Find the metrics tab on the list.
        - Choose a new alert rule.
        - RESOURCE – select the virtual machine.
        - CONDITION – select Percentage. CPU (Platform).
          - Threshold – set to static.
          - Operator – greater than or equal to.<!--CE:Is there a figure missing here?-->
          - Threshold value = 3%.
          - Aggregation granularity = 1 min.
          - Frequency of evaluation = 1 min.

   ![The following picture shows how you can create the alert based on defined criteria.](../media/lab-alert-condition.png)

   - ACTION – create an action rule so, if the criteria are met, you get an email notification:

        - Under Action, select **add**.
        - Create action rule.
        - Define the scope = Action group.
        - Create new action group.
        - Add the details (rule name, and more).
        - Add your email address.

  ![The following picture shows how you can create action rule.](../media/lab-action-group.png)

When you select **ok**<!--CE:Is this correct - or should it be 'OK'?--> on the rule box, it might take up to 10 minutes for the rule to become active. You should get an email notification within a few seconds of creating the rule. The email will say you're in the email alert group. After the criteria are met, you'll get an alert email.

![The following picture shows how you can create action rule.](../media/lab-action-group.png)

### Plot the CPU usage metric

- Go to your virtual machine.
- Find the metrics tab on the list.
- Scroll down the "select metric", to select the CPU percentage metric.

You've created a rule that, if CPU usage goes above the set threshold for one minute, you'll get an email notification. You plotted the CPU usage metric on the graph. Now you need to activate the alert and trigger a notification.

### Activate the alert

- Go to the virtual machine.
- Select **connect** and choose SSH on the tab.
- Copy the information under the login, using the local VM account.
- Open cmd, paste the information, and select **yes** to the security message.

![The following picture shows how you can find the SSH information.](../media/ssh-cmd.png)

 - SSH onto your machine using the username **Azureuser<!--CE:Is this correct? Not two words?-->** and password **Demouser@123**.
 - When you're on the webserver, type in **Ping 8.8.8.8 -c 999999999** to activate the alert. When the criteria are met, you'll trigger the notification email.

![The following picture shows the ping to 8.8.8.8.](../media/ping-to-8-8-8-8.png)

In this exercise, you created an alert based on CPU usage and received an email notification.
