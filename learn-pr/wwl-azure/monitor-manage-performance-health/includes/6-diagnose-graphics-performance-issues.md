To diagnose experience quality issues with your remote sessions, counters have been provided under the RemoteFX Graphics section of Performance Monitor. This unit helps you pinpoint and fix graphics-related performance bottlenecks during Remote Desktop Protocol (RDP) sessions using these counters.

## Find your remote session name

You'll need your remote session name to identify the graphics performance counters. Follow the instructions in this section to identify your instance of each counter.

1.  Open the Windows command prompt from your remote session.
2.  Run the **qwinsta** command and find your session name.
    
     -  If your session is hosted in a multi-session virtual machine (VM): Your instance of each counter is suffixed by the same number that suffixes your session name, such as "rdp-tcp 37."
     -  If your session is hosted in a VM that supports virtual Graphics Processing Units (vGPU): Your instance of each counter is stored on the server instead of in your VM. Your counter instances include the VM name instead of the number in the session name, such as "Win8 Enterprise VM."

## Access performance counters

After you've determined your remote session name, follow these instructions to collect the RemoteFX Graphics performance counters for your remote session.

1.  Select **Start** &gt; **Administrative Tools** &gt; **Performance Monitor**.
2.  In the **Performance Monitor** dialog box, expand **Monitoring Tools**, select **Performance Monitor**, and then select **Add**.
3.  In the **Add Counters** dialog box, from the **Available Counters** list, expand the section for RemoteFX Graphics.
4.  Select the counters to be monitored.
5.  In the **Instances of selected object** list, select the specific instances to be monitored for the selected counters and then select **Add**. To select all available counter instances, select **All instances**.
6.  After adding the counters, select **OK**.

The selected performance counters will appear on the Performance Monitor screen.

## Diagnose issues

Graphics-related performance issues generally fall into four categories:

 -  Low frame rate
 -  Random stalls
 -  High input latency
 -  Poor frame quality

### Addressing low frame rate, random stalls, and high input latency

First check the Output Frames/Second counter. It measures the number of frames made available to the client. If this value is less than the Input Frames/Second counter, frames are being skipped. To identify the bottleneck, use the Frames Skipped/Second counters.

There are three types of Frames Skipped/Second counters:

 -  Frames Skipped/Second (Insufficient **Server** Resources)
 -  Frames Skipped/Second (Insufficient **Network** Resources)
 -  Frames Skipped/Second (Insufficient **Client** Resources)

A high value for any of the Frames Skipped/Second counters implies that the problem is related to the resource the counter tracks.

If the Output Frames/Second counter matches the Input Frames/Second counter, yet you still notice unusual lag or stalling, Average Encoding Time may be the culprit. Encoding is a synchronous process that occurs on the server in the single-session (vGPU) scenario and on the VM in the multi-session scenario. Average Encoding Time should be under 33 ms.

Because RDP supports an Average Encoding Time of 33 ms, it supports an input frame rate up to 30 frames/second. Note that 33 ms is the maximum supported frame rate. In many cases, the frame rate experienced by the user will be lower, depending on how often a frame is provided to RDP by the source.

### Addressing poor frame quality

Use the Frame Quality counter to diagnose frame quality issues. This counter expresses the quality of the output frame as a percentage of the quality of the source frame. The quality loss may be due to RemoteFX, or it may be inherent to the graphics source. If RemoteFX caused the quality loss, the issue may be a lack of network or server resources to send higher-fidelity content.
