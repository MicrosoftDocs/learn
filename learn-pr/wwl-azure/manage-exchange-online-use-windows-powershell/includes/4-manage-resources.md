Room and equipment mailboxes are known as *resource mailboxes*. The primary purpose of resource mailboxes is to allow bookings and ensure that the resource isn't scheduled for multiple events or users simultaneously. You configure the scheduling process for resource mailboxes by using the **Set-CalendarProcessing** cmdlet. You can use the **Get-CalendarProcessing** cmdlet to review the current configuration.

## Delegates

One of the options for managing resource scheduling is delegates. *Delegates* are users that can accept or reject booking attempts for the resource. For example, if a room resource is included in a meeting request, the delegate receives a message asking to allow or deny the request. The following example depicts a user being configured as a delegate for a room mailbox:

```powershell
Set-CalendarProcessing -Identity BoardRoom -ResourceDelegates AbbieP@adatum.com
```

## Automated booking

Most organizations want to automate the resource booking process so that delegates only need to mediate conflicts. The *-AutomateProcessing* parameter set to **AutoAccept** is used to indicate that booking should be automated. However, there are other parameters that you can use to define when automated booking is allowed. The following table lists parameters that you can use to control automated resource booking.

*Table 1: Parameters to control automated booking of resources*

| Parameter                      | Description                                                  |
| ------------------------------ | ------------------------------------------------------------ |
| -AllBookInPolicy             | When set to `$true`, requests that meet booking rules are automatically accepted. |
| -AllowConflicts              | When a resource is booked for a recurring meeting request, you can define whether the entire recurring series is declined whenever there are conflicts. You use this parameter with the -ConflictPercentageAllowed or -MaximumConflictInstances parameters. |
| -AllRequestInPolicy          | When set to `$true`, all users are allowed to submit requests that meet the rules. The default configuration is `$false`. |
| -AllRequestOutOfPolicy       | When set to `$true`, all users are allowed to submit requests that don't meet the rules. The default configuration is `$false`. |
| -AutomateProcessing          | The default value of **AutoAccept** allows requests to be accepted automatically. A value of **AutoUpdate** marks requests as tentative and require a delegate to approve them. A value of **None** means no action is taken until a delegate approves or denies the request. |
| -BookInPolicy                | Specifies users or groups for which bookings that meet the rules are automatically accepted. |
| -EnforceCapacity             | When enabled, the capacity configured for the room is enforced. |
| -MaximumDurationInMinutes    | Specifies the maximum allowed duration for meetings.           |
| -RequestInPolicy             | Specifies users or group that can submit requests that meet the booking rules. |
| -RequestOutOfPolicy          | Specifies users or group that can submit requests that don't meet the booking rules. |
| -ScheduleOnlyDuringWorkHours | When enabled, requests outside of work hours don't meet the booking rules. |
