Typically, back-end apps enable device administrators and operators to update and interact with IoT devices in bulk and at a scheduled time. Jobs execute device twin updates and direct methods against a set of devices at a scheduled time. For example, an operator would use a back-end app that initiates and tracks a job to reboot a set of devices in building 43 and floor 3 at a time that would not be disruptive to the operations of the building.

Consider using jobs when you need to schedule and track progress any of the following activities on a set of devices:

- Update desired properties
- Update tags
- Invoke direct methods

## Job lifecycle

Jobs are initiated by the solution back end and maintained by IoT Hub. You can initiate a job through a service-facing URI (`PUT https://<iot hub>/jobs/v2/<jobID>?api-version=2021-04-12`) and query for progress on an executing job through a service-facing URI (`GET https://<iot hub>/jobs/v2/<jobID?api-version=2021-04-12`). To refresh the status of running jobs once a job is initiated, run a job query. There is no explicit purge of job history, but jobs have a Time to live (TTL) of 30 days.

> [!NOTE]
> When you initiate a job, property names and values can only contain US-ASCII printable alphanumeric, except any in the following set: `$ ( ) < > @ , ; : \ " / [ ] ? = { } SP HT`

## Jobs to execute direct methods

The following snippet shows the HTTPS 1.1 request details for executing a direct method on a set of devices using a job:

```http
PUT /jobs/v2/<jobId>?api-version=2021-04-12

Authorization: <config.sharedAccessSignature>
Content-Type: application/json; charset=utf-8

{
    "jobId": "<jobId>",
    "type": "scheduleDeviceMethod",
    "cloudToDeviceMethod": {
        "methodName": "<methodName>",
        "payload": <payload>,
        "responseTimeoutInSeconds": methodTimeoutInSeconds
    },
    "queryCondition": "<queryOrDevices>", // query condition
    "startTime": <jobStartTime>,          // as an ISO-8601 date string
    "maxExecutionTimeInSeconds": <maxExecutionTimeInSeconds>
}
```

The query condition can also be on a single device ID or on a list of device IDs as shown in the following examples:

```http
"queryCondition" = "deviceId = 'MyDevice1'"
"queryCondition" = "deviceId IN ['MyDevice1','MyDevice2']"
"queryCondition" = "deviceId IN ['MyDevice1']"

```

See IoT Hub Query Language: [IoT Hub query language for device and module twins, jobs, and message routing](/azure/iot-hub/iot-hub-devguide-query-language) for more information.

The following snippet shows the request and response for a job scheduled to call a direct method named testMethod on all devices on contoso-hub-1:

```http
PUT https://contoso-hub-1.azure-devices.net/jobs/v2/job01?api-version=2021-04-12 HTTP/1.1
Authorization: SharedAccessSignature sr=contoso-hub-1.azure-devices.net&sig=68iv------------------------------------v8Hxalg%3D&se=1556849884&skn=iothubowner
Content-Type: application/json; charset=utf-8
Host: contoso-hub-1.azure-devices.net
Content-Length: 317

{
    "jobId": "job01",
    "type": "scheduleDeviceMethod",
    "cloudToDeviceMethod": {
        "methodName": "testMethod",
        "payload": {},
        "responseTimeoutInSeconds": 30
    },
    "queryCondition": "*",
    "startTime": "2022-05-04T15:53:00.077Z",
    "maxExecutionTimeInSeconds": 20
}

HTTP/1.1 200 OK
Content-Length: 65
Content-Type: application/json; charset=utf-8
Vary: Origin
Server: Microsoft-HTTPAPI/2.0
Date: Fri, 03 May 2022 01:46:18 GMT

{"jobId":"job01","type":"scheduleDeviceMethod","status":"queued"}
```

## Jobs to update device twin properties

The following snippet shows the HTTPS 1.1 request details for updating device twin properties using a job:

```http
PUT /jobs/v2/<jobId>?api-version=2021-04-12

Authorization: <config.sharedAccessSignature>
Content-Type: application/json; charset=utf-8

{
    "jobId": "<jobId>",
    "type": "scheduleUpdateTwin",
    "updateTwin": <patch>                // Valid JSON object
    "queryCondition": "<queryOrDevices>", // query condition
    "startTime": <jobStartTime>,          // as an ISO-8601 date string
    "maxExecutionTimeInSeconds": <maxExecutionTimeInSeconds>
}
```

> [!NOTE]
> The `updateTwin` property requires a valid etag match; for example, `etag="*"`.

The following snippet shows the request and response for a job scheduled to update device twin properties for test-device on contoso-hub-1:

```http
PUT https://contoso-hub-1.azure-devices.net/jobs/v2/job02?api-version=2021-04-12 HTTP/1.1
Authorization: SharedAccessSignature sr=contoso-hub-1.azure-devices.net&sig=BN0U-------------------------------------RuA%3D&se=1556925787&skn=iothubowner
Content-Type: application/json; charset=utf-8
Host: contoso-hub-1.azure-devices.net
Content-Length: 339

{
    "jobId": "job02",
    "type": "scheduleUpdateTwin",
    "updateTwin": {
      "properties": {
        "desired": {
          "test1": "value1"
        }
      },
    "etag": "*"
    },
    "queryCondition": "deviceId = 'test-device'",
    "startTime": "2022-05-08T12:19:56.868Z",
    "maxExecutionTimeInSeconds": 20
}

HTTP/1.1 200 OK
Content-Length: 63
Content-Type: application/json; charset=utf-8
Vary: Origin
Server: Microsoft-HTTPAPI/2.0
Date: Fri, 03 May 2022 22:45:13 GMT

{"jobId":"job02","type":"scheduleUpdateTwin","status":"queued"}

```

## Querying for progress on jobs

The following snippet shows the HTTPS 1.1 request details for querying for jobs:

```http
GET /jobs/v2/query?api-version=2021-04-12[&jobType=<jobType>][&jobStatus=<jobStatus>][&pageSize=<pageSize>][&continuationToken=<continuationToken>]

Authorization: <config.sharedAccessSignature>
Content-Type: application/json; charset=utf-8

```

The continuationToken is provided from the response.

You can query for the job execution status on each device using the IoT Hub query language for device twins, jobs, and message routing.

## Jobs properties

The following list shows the properties and corresponding descriptions, which can be used when querying for jobs or job results.

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    jobId
  :::column-end:::
  :::column:::
    Application provided ID for the job.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    startTime
  :::column-end:::
  :::column:::
    Application provided start time (ISO-8601) for the job.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    endTime
  :::column-end:::
  :::column:::
    IoT Hub provided date (ISO-8601) for when the job completed. Valid only after the job reaches the 'completed' state.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    type
  :::column-end:::
  :::column:::
    Types of jobs:

- **scheduleUpdateTwin**: A job used to update a set of desired properties or tags.
- **scheduleDeviceMethod**: A job used to invoke a device method on a set of device twins.

  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    status
  :::column-end:::
  :::column:::
    Current state of the job. Possible values for status:

- **pending**: Scheduled and waiting to be picked up by the job service.
- **scheduled**: Scheduled for a time in the future.
- **running**: Currently active job.
- **canceled**: Job has been canceled.
- **failed**: Job failed.
- **completed**: Job has completed.

  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    deviceJobStatistics
  :::column-end:::
  :::column:::
    Statistics about the job's execution.deviceJobStatistics properties:
- **deviceJobStatistics.deviceCount**: Number of devices in the job.
- **deviceJobStatistics.failedCount**: Number of devices where the job failed.
- **deviceJobStatistics.succeededCount**: Number of devices where the job succeeded.
- **deviceJobStatistics.runningCount**: Number of devices that are currently running the job.
- **deviceJobStatistics.pendingCount**: Number of devices that are pending to run the job.

  :::column-end:::
:::row-end:::
