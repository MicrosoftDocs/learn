Most modern data analytics solutions enable two common patterns for data analysis:

- **Batch data analytics**, in which data is loaded into an analytical data store at periodic intervals as a batch operation; enabling historical analysis of data from past events.
- **Real-time data analytics**, in which data from events is ingested in real-time (or *near* real-time) as events occur in a *stream* of data that can be analyzed, visualized, and used to trigger automated responses.

Batch data analytics is generally well understood, and is commonly implemented using data warehouse or lakehouse architectures. Real-time analytics may be considered more specialist, but increasingly it's being incorporated into large-scale data analytics solutions in the form of a *lambda* architecture that combines the periodic loading of batch data for historical analysis with the ingestion of data streams for real-time analysis.

Microsoft Fabric provides capabilities for both batch and real-time analytics. In this module, we'll focus on the *Real-Time Intelligence* features of Microsoft Fabric to explore how you can build real-time data analytics solutions with minimal coding that scale to huge volumes of data from a diverse range of sources.

The topics covered in this module include:

- Understanding core concepts related to real-time data analytics.
- Understanding  Microsoft Fabric's Real-Time Intelligence capabilities.
- Exploring core components of Real-Time Intelligence in Microsoft Fabric.
- Ingesting real-time data by using an *eventstream*.
- Using an *eventhouse* and a KQL database for real-time data analysis in Microsoft Fabric.
- Visualizing data in *real-time dashboards*.
- Using *Activator* in Microsoft Fabric to define alerts that trigger automated actions.

By the end of this module, you'll be able to understand the capabilities of Microsoft Fabric's Real-Time Intelligence features. You'll also get hands-on experience through a practical exercise.
