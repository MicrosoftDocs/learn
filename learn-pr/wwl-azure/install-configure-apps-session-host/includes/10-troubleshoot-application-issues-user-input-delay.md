One of the most difficult problems to diagnose is poor application performance—the applications are running slow or don't respond.

You start your diagnosis by collecting CPU, memory, disk input/output, and other metrics and then use tools to figure out what's causing the problem. Unfortunately, in most situations this data doesn't help you identify the root cause because resource consumption counters have frequent and large variations.

The User Input Delay counter can help you quickly identify the root cause for bad end-user RDP experiences. This counter measures how long any user input (such as mouse or keyboard usage) stays in the queue before it is picked up by a process, and the counter works in both local and remote sessions.

The image below shows a user input flow from client to application.

:::image type="content" source="../media/user-input-delay-image-1-ec61075c.png" alt-text="Diagram showing the input flow from client to application.":::


The User Input Delay counter measures the max delta (within an interval of time) between the input being queued and when it's picked up by the app in a traditional message loop, as shown in the following flow chart:

:::image type="content" source="../media/user-input-delay-image-2-ed937a93.png" alt-text="Diagram showing the input being queued and when it's picked up by the app in a traditional message loop.":::


One important detail of this counter is that it reports the maximum user input delay within a configurable interval. This is the longest time it takes for an input to reach the application, which can impact the speed of important and visible actions like typing.

For example, in the following table, the user input delay would be reported as 1,000 ms within this interval. The counter reports the slowest user input delay in the interval because the user's perception of "slow" is determined by the slowest input time (the maximum) they experience, not the average speed of all total inputs.

| **Number** | **0** | **1** | **2**    |
| ---------- | ----- | ----- | -------- |
| Delay      | 16 ms | 20 ms | 1,000 ms |

## Enable and use the new performance counters

To use these new performance counters, you must first enable a registry key by running this command:

```
reg add "HKLM\System\CurrentControlSet\Control\Terminal Server" /v "EnableLagCounter" /t REG_DWORD /d 0x1 /f

```

Next, restart the server. Then, open the Performance Monitor, and select the plus sign `(+)`, as shown in the following graphic.

:::image type="content" source="../media/user-input-delay-image-3-228088cd.png" alt-text="Screenshot showing how to add the User Input Delay performance counter.":::


After doing that, you should see the Add Counters dialog, where you can select **User Input Delay per Process** or **User Input Delay per Session**.

:::image type="content" source="../media/user-input-delay-image-4-187685b7.png" alt-text="Screenshot showing how to select User Input Delay per Session.":::


:::image type="content" source="../media/user-input-delay-image-5-8b11f995.png" alt-text="Screenshot showing how to select User Input Delay per Process or User Input Delay per Session.":::


If you select **User Input Delay per Process**, you'll see the **Instances of the selected object** (in other words, the processes) in `SessionID:ProcessID <Process Image>` format.

For example, if the Calculator app is running in a Session ID 1, you'll see `1:4232 <Calculator.exe>`.

The counter starts reporting user input delay as soon as you add it. The maximum scale is set to 100 (ms) by default.

:::image type="content" source="../media/user-input-delay-image-6-181d503a.png" alt-text="Screenshot showing the counter reporting user input delay.":::


## User Input Delay per Session

There are instances for each session ID, and their counters show the user input delay of any process within the specified session. In addition, there are two instances called "Max" (the maximum user input delay across all sessions) and "Average" (the average across all sessions).

This table shows a visual example of these instances. (You can get the same information in Perfmon by switching to the Report graph type.)

| **Type of counter**          | **Instance name**                                | **Reported delay (ms)** |  |
| ---------------------------- | ------------------------------------------------ | ----------------------- |  |
| User Input Delay per process | 1:4232 &lt;Calculator.exe&gt; | 200                     |  |
| User Input Delay per process | 2:1000 &lt;Calculator.exe&gt; | 16                      |  |
| User Input Delay per process | 1:2000 &lt;Calculator.exe&gt; | 32                      |  |
| User Input Delay per session | 1                                                | 200                     |  |
| User Input Delay per session | 2                                                | 16                      |  |
| User Input Delay per session | Average                                          | 108                     |  |
| User Input Delay per session | Max                                              | 200                     |  |

## Counters used in an overloaded system

Now let's look at what you'll see in the report if performance for an app is degraded. The following graph shows readings for users working remotely in Microsoft Word. In this case, the RDSH server performance degrades over time as more users log in.

:::image type="content" source="../media/user-input-delay-image-7-f0f9ff26.png" alt-text="Screenshot showing the performance for an app has degraded.":::


Here's how to read the graph's lines:

 -  The pink line shows the number of sessions signed in on the server.
 -  The red line is the CPU usage.
 -  The green line is the maximum user input delay across all sessions.
 -  The blue line (displayed as black in this graph) represents average user input delay across all sessions.

Notice there's a correlation between CPU spikes and user input delay—as the CPU gets more usage, the user input delay increases. Also, as more users get added to the system, CPU usage gets closer to 100%, leading to more frequent user input delay spikes. While this counter is useful in cases where the server runs out of resources, you can also use it to track user input delay related to a specific application.
