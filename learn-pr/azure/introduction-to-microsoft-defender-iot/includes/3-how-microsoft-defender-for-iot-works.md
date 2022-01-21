Now that we know the basics of Defender for IoT, let's see how it works behind the scenes.
 
## Microsoft Defender for IoT sensors
 
Defender for IoT sensors are deployed on-premises as a virtual or physical appliance connected to a SPAN port or tap. Sensors discover, and continuously monitor network devices and collect ICS network traffic using passive (agentless) monitoring on IoT and OT devices.  Defender for IoT sensors connect to a SPAN port or network TAP and immediately begins performing DPI on IoT and OT network traffic.

Data collection, processing, analysis, and alerting takes place directly on the sensor. This process makes it ideally suited for locations with low bandwidth or high latency connectivity, because only metadata is transferred to the management console.

## Defender for IoT Engines

Self-learning analytics engines eliminate the need for updating signatures or defining rules. The engines use ICS-specific behavioral analytics and data science to continuously analyze OT network traffic for anomalies, malware, operational problems, protocol violations, and baseline network activity deviations.

The sensor includes five analytics detection engines that trigger alerts based on analysis of both real-time and pre-recorded traffic.  

### Policy violation detection engine

Using machine learning, this engine alerts users of deviations in baseline behavior, such as unauthorized use of specific function codes, access to specific objects, or changes to device configuration. For example: DeltaV software version changed, firmware changes, and Unauthorized PLC programming alerts. 

### Protocol violation detection engine

Identifies the use of packet structures and field values that violate ICS protocol specifications, for example: Modbus exception, and Initiation of an obsolete function code alerts.

### Malware detection engine

The industrial malware detection engine identifies behaviors that indicate the presence of known malware, such as Conficker, Black Energy, Havex, WannaCry, NotPetya, and Triton. 

### Anomaly detection engine

The anomaly engine detects unusual machine-to-machine (M2M) communications and behaviors, for example Excessive SMB sign in attempts and PLC scans.

### Operational incident detection engine

Detects operational issues such as intermittent connectivity that can indicate early signs of equipment failure. For example, the device is thought to be disconnected (unresponsive): A Siemens S7 stop PLC command was sent alerts. 