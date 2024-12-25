In this module, you learned about three types of jobs: local jobs, Windows PowerShell remote jobs, and Common Information Model (CIM)/Windows Management Instrumentation (WMI) jobs. These three job types form the basis of the Windows PowerShell job system. The following are the key takeaways:

- Local jobs run their commands on the local computer and typically access only local resources. However, you can create local jobs that target a remote computer. 

- Remote jobs use Windows PowerShell remote to transmit commands to one or more remote computers. 

- CIM and WMI jobs use the Common Information Model (CIM) and Windows Management Instrumentation (WMI) repository of management information. 

- You start each of the three type of jobs, namely local, remote, and Common Information Model (CIM)/Windows Management Instrumentation (WMI), in a different way. 

- Each job consists of at least two job objects. The parent job is the top-level object and represents the entire job, regardless of the number of computers to which the job connects. The parent job contains one or more child jobs. Each child job represents a single computer. 
