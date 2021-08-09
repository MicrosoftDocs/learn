Hybrid systems are the result of conflicting goals. However, having different goals isn't necessarily a bad thing. This unit describes the hybrid nature of the IoT lambda architecture.

## Data paths

The conflict in IoT applications is as follows. Telemetry data is coming in hot, there's lots of it, and it needs to be analyzed quickly. A failing refrigeration unit, conveyor belt, humidifier, or any critical piece of machinery, needs to be fixed _before_ it fails. Preventive maintenance is the goal of this analysis. Also, all the data should be stored, both to archive it, and to run some deeper analysis over longer time periods. The deeper analysis is to try to detect longer term trends, or failure patterns, that might be difficult to detect with a shorter real-time sample.

IoT analysis is all about getting insights from raw telemetry data. Another reason to store telemetry data is to enable the training of machine learning models. Typically, these models require a vast amount of data to work on, before meaningful insights are made.

One of the easiest ways of handling this duality at the device sensor end of things, is to send two messages at different frequencies. The first message contains only the telemetry data that needs analyzed in real time. The second message, sent at a lower frequency, contains a batch of the telemetry data, and the other meta data that might be needed, for deeper analysis or archiving. The IoT Hub routes these two messages to different resources.

It's common to use the familiar terms _hot_, _warm_, _cool_, and _cold_ in data analysis. Hot clearly means a real-time approach is needed. Warm can have the same meaning, though perhaps the data is "near" real time, or at least, recent. Cool means the flow of data is slow. Cold means that the data is stored and not "flowing". The cooler the path, the more the data can be batched.

## Understand lambda architecture

The _Lambda architecture_ of Azure IoT enables multiple paths. However, for the sake of explanation, let's work with two paths, hot and cold. The hot path is the streaming telemetry routed into real-time analysis. This path is also the right path to trigger warnings and alerts.

The cold path is a batch processing path for telemetry data storage.

### The hot path

[![Graph illustration of vibration telemetry.](../media/lambda-hot-path.png)](../media/lambda-hot-path.png#lightbox)

The IoT remote device pumps out _specific_ telemetry. This telemetry is sent in its own message, routed by the IoT Hub for instant analysis and visualization. The analysis could be done by a human operator, say, using Azure Time Series Insights. This approach is described in this module.

Alternatively, the analysis could be handled by Azure Stream Analytics, which supports simple SQL language queries, and is extensible via C# or JavaScript UDFs (User-defined functions).

The hot path requires storage optimized for data availability. Data services that provide this speed of access are the more expensive services.

### The cold path

[![Graph illustration of vibration, temperature, and humidity telemetry.](../media/lambda-cold-path.png)](../media/lambda-cold-path.png#lightbox)

The IoT remote device also sends out all telemetry, and logging, data. The IoT Hub directs these messages down a route to an Azure storage account. The key point about cold path storage is that it's optimized for size (that is, it's compressed), long-term storage, and low cost. The cold path is _not_ optimized for availability.

There are various storage resources available in Azure, and the next units describe these options. Having an understanding of your own data is important. If it consists of files, images, recordings, and similar disparate items, then it's considered _unstructured_ storage. If your data neatly divides into similar database-like objects, then it's considered _structured_.

### Issues with lambda architecture

Similar to most hybrid systems, there are complexity issues. One of the main issues with IoT is the duplication of data and code. The more duplication there is, the greater the chance of an unwanted divergence between the duplicate copies. Developers of the IoT device sensor code need to ensure the telemetry data being sent in the two messages is identical, where it should be. Also, there may be code duplication in the analysis apps, if there are separate apps for the hot and cold paths. Duplication needs to be handled carefully, though is a near unavoidable consequence of a hybrid system.

Costs are always an issue. Fast services tend to be the more expensive, slower services cheaper. There's usually a compromise to be made.

## First steps

Given the goal of keeping a system with some complexity as simple as possible, let's start by looking at the simplest storage solution.
