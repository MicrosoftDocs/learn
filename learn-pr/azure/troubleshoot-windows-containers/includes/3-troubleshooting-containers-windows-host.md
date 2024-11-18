To get started, we look at tools that are provided by Microsoft to help you troubleshoot Windows containers.

## Application and container logs

When it comes to standards, application and container logs are based on Standard Output (STDOUT/STDERR). It's not the case for some Windows applications, nor the Windows OS. Traditionally, Windows apps and OS logs go to other places, such as EventLogs, EventTraces, and custom log files. Because of this discrepancy, tools that look for container and application logs on STDOUT aren't able to see the logs from Windows apps on containers. To resolve, Microsoft created a tool called LogMonitor to bridge this gap and aggregate all logs inside the Windows container to STDOUT.

To use LogMonitor, you need to add it to your container image via the Dockerfile. Recall that a Dockerfile is the recipe for building a container. In a Dockerfile, there are multiple directives including FROM, ADD, ENTRYPOINT, etc. ENTRYPOINT is PID 1 of the container, and the container exits when the ENTRYPOINT process terminates. To capture the STDOUT/STDERR of the container, the LogMonitor works as a wrapper around your application. Therefore the ENTRYPOINT looks like this:

```powershell
ENTRYPOINT ["C:\\LogMonitor\\LogMonitor.exe", "C:\\MyApp.exe", "myparameter"]
```

When using LogMonitor, you can treat Windows Containers just like Linux ones by using the **docker logs** command to fetch the output. Other logging solutions, such as Azure Monitor, are also able to catch the logs from the container.

LogMonitor also needs a configuration file so that it knows which events/files to aggregate when running inside your container.

In the following, you can find an example JSON config and a Dockerfile for an IIS instance:

```json
    "LogConfig": {
      "sources": [
        {
          "type": "EventLog",
          "startAtOldestRecord": true,
          "eventFormatMultiLine": false,
          "channels": [
            {
              "name": "application",
              "level": "Warning"
            },
            {
              "name": "application",
              "level": "Error"
            }
          ]
        },
        {
          "type": "File",
          "directory": "c:\\inetpub\\logs",
          "filter": "*.log",
          "includeSubdirectories": true
        },
        {
          "type": "ETW",
          "eventFormatMultiLine": false,
          "providers": [
            {
              "providerName": "IIS: WWW Server",
              "providerGuid": "3A2A4E84-4C21-4981-AE10-3FDA0D9B0F83",
              "level": "Information"
            },
            {
              "providerName": "Microsoft-Windows-IIS-Logging",
              "providerGuid": "7E8AD27F-B271-4EA2-A783-A47BDE29143B",
              "level": "Information"
            }
          ]
        }
      ]
    }
  }
```

This JSON example collects the application logs from EventLog that are tagged as Warning or Errors. It also captures the logs from the `C:\inetpu\logs folder` (which is the default log for IIS). Finally, it captures the ETW (Event Tracing for Windows) logs coming from the IIS providers.

Here's a Dockerfile example to monitor a web application running on IIS:

```powershell
FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022
WORKDIR /LogMonitor
COPY LogMonitorConfig.json .
RUN powershell.exe -command wget -uri https://github.com/microsoft/windows-container-tools/releases/download/v1.1/LogMonitor.exe -outfile LogMonitor.exe
# Change the startup type of the IIS service from Automatic to Manual
RUN sc config w3svc start=demand
# Enable ETW logging for Default Web Site on IIS
RUN c:\windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/sites /"[name='Default Web Site'].logFile.logTargetW3C:"File,ETW"" /commit:apphost
EXPOSE 80
# Start "C:\LogMonitor\LogMonitor.exe C:\ServiceMonitor.exe w3svc"
ENTRYPOINT ["C:\\LogMonitor\\LogMonitor.exe", "C:\\ServiceMonitor.exe", "w3svc"]
```

This example creates a container image based on the IIS container image, copies the JSON file created in the previous example, and downloads the latest version of LogMonitor. It then configures IIS and sets LogMonitor as the Entrypoint, monitoring the IIS service.

Now that the application and IIS logs are going to STDOUT, you can get the logs with:

```bash
docker logs <container_name>
```

## Connect to Windows container via HCSDiag.exe

Getting a PowerShell session inside the container can be a powerful debugging tool to identify an issue. You can use `hcsdiag.exe` (Host Compute Service Diagnostic) to interact with the HCS. Recall that HCS is a low-level API to manage the containers. `Hcsdiag.exe` is a tool to interact with the API directly. With it you can run commands to list, exec, read, write, open a console, and more.

To get a console inside the container:

```powershell
hcsdiag.exe list
hcsdiag.exe console -uvm <id>
```

The command lists the containers (and VMs) available in the system. You can then specify the ID of the container you want to open a PowerShell session to.

## Checking container runtime logs

Sometimes there might be issues with the runtime setup. To check the logs of the runtime you can do the following:

- **Docker Daemon**

   To get the logs from the Docker Daemon, you can check the Event Viewer. You can accomplish from PowerShell:

   ```powershell
   Get-EventLog -LogName Application -Source Docker -After (Get-Date).AddMinutes(-5) | Sort-Object Time
   ```

   The command returns the logs from the Docker Daemon. If you want to enable debug log level, you need first to modify the dockerd service parameters:

   ```powershell
   sc.exe config docker binpath= "\"C:\Program Files\Docker\dockerd.exe\" --run-service -D"
   sc.exe stop docker
   sc.exe start docker
   ```

   Make sure to remove `-D` flag after you finished debugging as it pollutes the logs.

- **Containerd logs**

   Usually, containerd logs to `C:/logs/containerd.log`. You can also enable debug level by configuring the service with `–log-level debug` in `sc.exe`. Make sure you only add the log level and don't change any other flags. Keep in mind that containerd startup parameters might differ due to active development on the project.

   ```powershell
   sc.exe config containerd binpath= "C:\containerd\bin\containerd.exe --log-level=debug --log-file=C:/logs/containerd.log"
   sc.exe stop containerd
   sc.exe start containerd
   ```

- **Host Compute Service logs**

   Both Docker Daemon and containerd depend on the HCS. When troubleshooting, you can retrieve HCS logs with PowerShell:

   ```powershell
   Get-WinEvent -LogName Microsoft-Windows-Hyper-V-Compute-Admin
   Get-WinEvent -LogName Microsoft-Windows-Hyper-V-Compute-Operational
   ```

## Image version mismatch

When using Windows containers, you need to pay attention to the Windows version of container image and host. The Windows OS has four levels of versioning: major, minor, build, and revision. For example, version 10.0.14393.103 would have a major version of 10, a minor version of 0, a build number of 14393, and a revision number of 103.

Except for Windows Server 2022 and Windows 11, Windows containers are blocked from starting when the build number between the container host and the container image are different. For example, when the container host is version 10.0.14393.\* (Windows Server 2016) and you attempt to run a container with an image version 10.0.16299.\* (Windows Server version 1709) the OS compute service returns a version incompatibility error.

For Windows containers running with process isolation, the build number must exactly match the host. For Hyper-V containers, the build number of the container image can be lower than the container host. For example: You can run a Windows Server 2019 container image on a Windows Server 2022 host using Hyper-V isolation.

## PowerShell debug script

As you can gather from the previous sections, there are many moving pieces when running Windows containers requiring proper configuration. You now know how to look into the Windows components when something goes wrong. Microsoft created a PowerShell script to try to catch some basic misconfigurations to make things even easier. You can use that script with PowerShell:

```powershell
Invoke-WebRequest https://aka.ms/Debug-ContainerHost.ps1 -UseBasicParsing | Invoke-Expression
```

The script runs several tests on the system automatically. Any failures are in red, and there's a pass/fail summary at the end. You can use this information to further troubleshoot your system.
