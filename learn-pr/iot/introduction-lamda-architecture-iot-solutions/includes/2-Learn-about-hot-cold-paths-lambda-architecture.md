Hybrids are the result of conflicting goals. However, having conflicting goals is not necessarily a bad thing. This unit describes the hybrid nature of the IoT lambda architecture.

## Data paths

The conflict in Azure IoT is as follows. Telemetry data is coming in hot, there is lots of it, and you want to analyse it quickly. Preventive maintenance is probably the most common goal of an IoT system, and is the goal of your analysis. However, you also want to archive all the data, and run some deeper analysis on longer periods of data. The deeper analysis is to try to detect longer term trends, or failure patterns that might be difficult to detect with a shorter real-time sample.

One of the easiest ways of handling this duality at the device sensor end of things, is to send two messages. The first message contains only the telemetry data that needs analysed in real-time. The second message contains the telemetry, and all the other data that might be needed for deeper analysis or archiving.

The IoT Hub routes these two messages to different resources. It is common to use the familiar terms _hot_, _warm_, _cool_ and _cold_ in data analysis. Hot clearly means a real-time approach is needed. Warm can have the same meaning, though perhaps the data is "near" real-time, or at least, recent. Cool means the flow of data is slow. Cold means that the data is stored and not "flowing".

## Understand lambda architecure

The _Lambda architecure_ of Azure IoT defines two paths, hot and cold. The hot path is the streaming telemetry routed into real-time analysis. This is the right path to trigger warnings and alerts. The cold path is a batch processing path for telemetry data storage.

### The hot path

![Graph illustration of vibration telemetry](../media/lambda-hot-path.png)

The IoT remote device pumps out specific telemetry. This is sent in its own message, routed by the IoT Hub for instant analysis and visualization. The analysis could be done by a human operator, say, using Azure Time Series Insights. This is the scenario we discuss in this module.

Alternatively, the analysis could be handled by Azure ML models, via Azure Stream Analytics. This scenario is more complex, involves coding, and is described in other IoT Hub Learn modules.

### The cold path

![Graph illustration of vibration, temperature, and humidity telemetry](../media/lambda-cold-path.png)

The IoT remote device also sends out all telemetry, and logging, data that the IoT Hub directs down a route to an Azure storage account. There are various storage resources available in Azure, and the next units describe these options.

### Issues with lambda architecture

Similar to most hybrid systems, there are issues. One of the main ones with IoT is the duplication of data and code. The more duplication there is, the greater the chance of an unwanted divergence between the duplicate copies. Developers of the IoT device sensor code need to ensure that the telemetry data being sent in the two messages is identical, where it should be. There may be duplication in the analysis apps for the hot and cold paths. Duplication needs to be handled carefully, though is an unavoidable consequence of a hybrid system.

## First steps

Given the goal of keeping a system with some complexity as simple as possible, let's start by looking at the simplest storage solution.
