The REST API lets you programmatically manage jobs in your IoT Central application. Jobs let you do bulk updates to device and cloud properties and run device commands.

To simplify the job of a fleet manager, you've been asked to integrate IoT Central job capabilities into the existing fleet management application. Fleet managers want to use the existing fleet management application to manage the jobs that keep the refrigerated truck devices up to date.

Here, you'll learn how to use the REST API to create and run jobs, view job results, and rerun jobs on failed devices.

## Jobs

When you create a job, you use a *device group* to identify the devices the job should run on. IoT Central automatically creates a device group for each device template. You can also create device groups in the IoT Central UI that use filters to select devices. You can use the REST API to list the device groups in your application.

When you use the REST API to create a job, you specify whether the job updates a property, a cloud property, or runs a command. With the REST API, the job runs immediately. You can use the REST API to see the status of a job as it goes through the *pending*, *running*, and *completed* phases.

When the job completes, you can use the REST API to get the status of the job and the status of each device in the job. If the job fails on any devices, you can rerun the job to try again. When you rerun a job, it only tries to repeat the operation on devices that failed previously.

## Use the REST API to work with jobs

The IoT Central REST API for jobs lets you:

- List the jobs in your application
- Get the details of an individual job its devices
- Rerun a job against failed devices
- Stop and resume jobs
