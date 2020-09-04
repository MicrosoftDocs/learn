Here you will see the basic process of creating an Extended Events session using the New Session dialog from SQL Server Management Studio. You can get to this screen by expanding the Management node in SSMS, expanding the Extended Events node, right-clicking on Sessions and selecting New Session. 

:::image type="content" source="../media/module-66-automation-final-11.png" alt-text="Creating an Extended Events Session":::

The image above shows the first creation screen in the new Extended Events session. You must first name the session. SQL Server provides numerous templates which are grouped into the following categories:

- Locks and Blocks
- Profiler Equivalents
- Query Execution
- System Monitoring

These predefined templates can allow you to quickly get started with using Extended Events for monitoring. In this example, you will see events manually added to the session to walk through all of the options, but when you are getting started, using a template can be an easy way to create a basic session. You have a couple of check box options for when to start this session. You can choose to have your new session start whenever the server starts, and you can also choose to start the session as soon as it’s been created. Event sessions can be started and stopped by the administrator at any time through the Extended Events node in SQL Server Management Studio. You also have the option of enabling causality tracking, which adds a globally unique identifier (GUID) and sequence number to the output of each event, which allows you to easily step through the order that the events occurred.

:::image type="content" source="../media/module-66-automation-final-12.png" alt-text="Event Selection in SQL Server Management Studio":::

The image above shows the screen where you add the events to your session. An event represents a point of interest within the database engine code — these can represent purely internal system operations, or they can be associated with user actions like query execution. In the above example, you can see that three events `(sp_statement_completed, sql_batch_completed, sql_statement_completed)` have been added to this event session. By default, this session would capture all instances of these events taking place on your instance. You can limit collection by clicking the configure button.

:::image type="content" source="../media/module-66-automation-final-13.png" alt-text="Global Event Selection":::

The event configuration screen allows for defining what data you are collecting as it relates to your events. Global fields, allow you to choose the data you are collecting, when your event occurs. Global fields are also known as actions, as the action is to add additional data fields to the event. These fields represent the data that is collected when the extended event occurs, and are common across most extended events. The image below shows the Filter options for an extended event.

:::image type="content" source="../media/module-66-automation-final-14.png" alt-text="Event Filter in SQL Server Management Studio":::

Filters are a powerful feature of Extended Events that allow you to use granular control to capture only the specific occurrences of the event you want to capture. In this example, you can see that filter is being applied on the field `sqlserver.is_system` where it is equal to zero, which indicates that the query is not an internal operation. In other words, the session will not capture completion of statements that are submitted by system connections. We only want to capture statements submitted by users or user applications.

Filters apply to a single field on a single event. If you want to make sure that you aren't tracing system activities for any events, you'll need a separate filter for each: for the sql_statement_completed event (shown), for the sql_batch_completed event, and for the sp_statement_completed event (which is a statement run inside a stored procedure).

It is recommended that you configure a filter for each event that you are capturing. This helps improve the efficiency of data collection and allows you to narrow the focus of your search.

The image below shows the event fields that are collected. These are specific to the event being triggered and can include optional fields for collection. In the above event, you can see the optional collection options are statement and `parameterized_plan_handle`. In this example, on the statement field has been selected for collection.

:::image type="content" source="../media/module-66-automation-final-15.png" alt-text="Event Fields Selection":::

Once you have defined an event session, you will define a storage target, as shown in the image below.

:::image type="content" source="../media/module-66-automation-final-16.png" alt-text="Storage Target Selection for Extended Events":::

An extended event session has a target — a target can be simply thought of as a place for the engine to keep track of occurrences of an event. Two of the more common targets are *event file* which is a file on the file system that can store events (the size of the file and the number of files is configurable to control runaway growth), and in Azure SQL PaaS offerings this data is written to blob storage. Another common target is the *ring buffer* which is within SQL Server's memory. The *ring buffer* is most commonly used for live observation of an event session, as it’s a circular buffer and data is not persisted beyond a session. Most targets process data asynchronously, which means that the event data is written to memory before being persisted to disk. The exception is the Event Tracing for Windows target (ETW) and Event Counter targets which are processed synchronously.

The following table contains information and uses for each type of Extended Events target.

|**Target**|**Description**|**Processing** |
| - | - | - |
|**Event Counter**|Counts all events that occurred during an Extended Event session. This is used to obtain information about workload characteristics about a workload without the overhead of a full event collection.|Synchronous |
|**Event File**|Writes event session output from memory onto persistent file on disk.|Asynchronous |
|**Event Pairing**|Many events that generally occur in pairs (e.g. lock acquire, lock release), and this collection can be used to identity when those events do no occur in a matched set.|Asynchronous |
|**Event Tracing for Windows (ETW)**|Used to correlate SQL Server events with the Windows OS event data.|Synchronous |
|**Histogram**|This is similar to event counter, which counts the occurrences of an event. The difference is that the histogram can count based on a specific event column or action.|Asynchronous |
|**Ring Buffer**|Used to hold data in memory. Data is not persisted to disk and maybe frequently flushed from the buffer|Asynchronous |

## Creating extended events sessions with T-SQL

There are two options for creating an Extended Event session. You can create a session programmatically using T-SQL or you can use the GUI in SQL Server Management Studio. However, using T-SQL to deploy event sessions is more easily repeated and should be part of automation routines. The T-SQL for a sample event session is shown below.

```tsql
IF EXISTS (SELECT * FROM sys.server_event_sessions WHERE name='test_session')

 DROP EVENT session test_session ON SERVER;

GO

CREATE EVENT SESSION test_session

ON SERVER

 ADD EVENT sqlos.async_io_requested,

 ADD EVENT sqlserver.lock_acquired

 ADD TARGET package0.etw_classic_sync_target

 (SET default_etw_session_logfile_path = N'C:\demo\traces\sqletw.etl' )

 WITH (MAX_MEMORY=4MB, MAX_EVENT_SIZE=4MB);

GO
```

Event sessions can be scoped to a server or a database. In the example shown above, you are adding two events and using the Event Tracing for Windows (ETW) path, with a file location. After you create the session, you’ll have to start it. You can do this using T-SQL and ALTER the session using the STATE option, or you can use the Extended Events | Session node in SQL Server Management Studio. You can also have the session start at server startup, which is common for lightweight event sessions that monitor over time.
