Real-time analytics is the practice of processing, analyzing, and acting on data as it's generated, typically within seconds to minutes of when events occur. Unlike traditional analytics that works with static snapshots of historical data stored in databases, real-time analytics operates on data that's actively flowing through your systems, enabling immediate insights and rapid responses to changing conditions. This approach is also known as *near* real-time analytics, since there's always some degree of processing and network latency involved.

## Understand events and streams

**Events** are records of things that happen in a system. They capture moments when something occurs, changes, or is completed. Examples include website clicks, stock price changes, customer purchases, patient vital sign changes, or equipment sensor readings. Think of them as digital records or log entries that document activity across your systems.  

A **stream** is essentially a sequence of events, typically ordered by the time an event occurred. Each event in the stream represents something that happened at a specific moment. Events flow through streams continuously as they occur. For example, a stream of equipment temperature sensor readings contains temperature readings over many points of time. This continuous flow of event information allows you to detect patterns over time, identify opportunities or risks, and take action immediately after something happens, or in *real-time*.

Streams are the delivery mechanism that carries events from where they happen to where they need to be processed, analyzed, or acted upon.

## Components of real-time analytics solutions

To build real-time analytics solutions, you need several integrated capabilities working together:

**Real-time data ingestion:** Collect data from multiple sources simultaneously, as information is generated. For example: database changes from change data capture, sensors, applications, system logs, and APIs.

**Stream processing:** Transform and analyze data while it flows from sources to destinations. This includes filtering, aggregating, joining with other data sources, and detecting patterns with minimal latency.

**Low-latency storage:** Use specialized databases and storage systems designed to handle high-velocity data writes and provide fast query responses.

**Interactive dashboards:** Create visualizations that update automatically as new data arrives, show current state and trends in real-time.

**Automated decision making:** Set up event-driven rules and triggers that can initiate actions, send alerts, or start workflows based on real-time conditions.

## Use real-time analytics

To use real-time data effectively, information has to be ingested, processed, stored, analyzed, and presented to be actionable. Real-time analytics enables you to:

- **Respond immediately** to opportunities or problems as they emerge
- **Optimize operations** by adjusting resources and configurations based on current conditions  
- **Enhance customer experiences** through personalized, contextual interactions
- **Prevent issues** by detecting anomalies before they become critical problems

Real-Time Intelligence in Microsoft Fabric brings all these capabilities together in a single platform. Through components like Eventstreams for data ingestion and transformation, Eventhouses for analytics-optimized storage, the Real-Time hub for data discovery, Real-Time Dashboards for visualization, and Activator for automated alerts and actions, Real-Time Intelligence enables you to monitor critical events, trigger automated responses, track business processes, and analyze patterns in real-time, turning what happens in your systems into actionable insights.
