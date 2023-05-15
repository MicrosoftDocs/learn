You can use Azure IoT Central to manage your connected devices at scale through jobs. Jobs let you do bulk updates to device and cloud properties, and run commands. You can also use CSV files to import and export devices in bulk.

## Create and run a job

1. On the left pane, select **Jobs**.
1. Select **+ New** job.
1. On the **Configure your job** page, enter a name and description to identify the job you're creating.
1. If your application uses organizations, select the organization to associate the job to. Only users in the organization can view or modify the job. The user's role determines the permissions the user has.
1. Select the target device group that you want your job to apply to. You can see how many devices your job configuration applies to below your **Device group** selection.
1. Select **Cloud property**, **Property**, **Command**, **Change device template**, or **Change edge deployment manifest** as the **Job type**. To configure a property job, select a property and set its new value. To configure a command job, choose the command to run. A property job can set multiple properties. Select **Save** and exit to add the job to the list of saved jobs on the **Jobs** page. You can later return to a job from the list of saved jobs.
1. Select **Next** to move to the **Delivery options** page. The *Delivery options* page lets you configure the batch and cancellation threshold values for this job. Batches let you stagger jobs for large numbers of devices. The job is divided into multiple batches and each batch contains a subset of the devices. The batches are queued and run in sequence. The cancellation threshold lets you automatically cancel a job if the number of errors exceeds your set limit. The threshold can apply to all the devices in the job, or to individual batches.
1. Select **Next** to move to the **Schedule** page. The **Schedule** page lets you enable a schedule to run the job in the future. Choose a recurrence option for the schedule. You can set up a job to run: one-time; daily; weekly; monthly. Set a start date and time for a scheduled job. The date and time is specific to your time zone, and not to the device's local time. To end a recurring schedule, choose: **On this day** to set an end date for the schedule; **After** to set the number of times to run the job. Scheduled jobs always run on the devices in a device group, even if the device group membership changes over time.
1. Select **Next** to move to the **Review** page. The **Review** page shows the job configuration details. Select **Schedule** to schedule the job.
1. The job details page shows information about scheduled jobs. When the scheduled job runs, you will see a list of the job instances. The scheduled job run will also be shown on the **Last 30-day** job list. On this page, you can unschedule the job or edit the scheduled job. You can return to a scheduled job from the list of scheduled jobs.
1. In the job wizard, you can choose to not schedule a job, and run it immediately. For a job with no schedule, select **Run** to run the job.
1. A job goes through pending, running, and completed phases. The job execution details contain result metrics, duration details, and a device list grid. When the job is complete, you can select **Results log** to download a CSV file of your job details, including the devices and their status values. This information can be useful for troubleshooting.
1. The job now appears in **Last 30 days** list on the **Jobs** page. This page shows currently running jobs and the history of any previously run or saved jobs.

## Review job information

To see an overview of your jobs, select a job from the list on your **Jobs** page. This overview contains the job details, devices, and device status values.

### View the job status

After a job is created, the Status column updates with the latest status message of the job. The following table lists the possible status values:

:::row:::
  :::column:::
    **Status message**
  :::column-end:::
  :::column:::
    **Status meaning**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Completed
  :::column-end:::
  :::column:::
    This job has been executed on all devices.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Failed
  :::column-end:::
  :::column:::
    This job has failed and not fully executed on devices.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Pending
  :::column-end:::
  :::column:::
    This job hasn't yet begun executing on devices.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Running
  :::column-end:::
  :::column:::
    This job is currently executing on devices.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Stopped
  :::column-end:::
  :::column:::
    This job has been manually stopped by a user.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Canceled
  :::column-end:::
  :::column:::
    This job was canceled because the threshold set on the **Delivery options** page was exceeded.
  :::column-end:::
:::row-end:::

The status message is followed by an overview of the devices in the job. The following table lists the possible device status values:

:::row:::
  :::column:::
    **Status message**
  :::column-end:::
  :::column:::
    **Status meaning**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Succeeded
  :::column-end:::
  :::column:::
    The number of devices that the job successfully executed on.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Failed
  :::column-end:::
  :::column:::
    The number of devices that the job has failed to execute on.
  :::column-end:::
:::row-end:::

### View the device status

To view the status of the job and all the affected devices, select the job. To download a CSV file that includes the job details, including the list of devices and their status values, select **Download job details**. Next to each device name, you see one of the following status messages:

:::row:::
  :::column:::
    **Status message**
  :::column-end:::
  :::column:::
    **Status meaning**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Completed
  :::column-end:::
  :::column:::
    The job ran on this device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Failed
  :::column-end:::
  :::column:::
    The job has failed to run on this device. The error message shows more information.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Pending
  :::column-end:::
  :::column:::
    The job hasn't yet run on this device.
  :::column-end:::
:::row-end:::

> [!NOTE]
> If a device has been deleted, you can't select the device and it displays as deleted with the device ID.

To download a CSV file that includes the job details and the list of devices and their status values, select **Results log**.

## Running and stopping jobs

To stop a running job, select it and choose **Stop** on the panel. The job status changes to reflect the job is stopped.

To run a job that's currently stopped, select the stopped job. Choose **Run** on the panel. The job status changes to reflect the job is now running again.

## Copy a job

To copy an existing job you've created, select it from the main jobs page and select **Copy**. A new copy of the job configuration opens for you to edit. You can save or run the new job. If any changes have been made to your selected device set, they're reflected in this copied job for you to edit.
