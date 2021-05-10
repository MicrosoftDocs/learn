Bringing your Digital Twin to life in your immersive experience would not be possible without attribute data to support the experience.  Telemetry is the in situ collection, transmission, and receipt of data from remote points to a collection point for further use (e.g., storage, analysis, modelling, etc.).  Each of the wind turbines in your wind farm can be connected to a simulated data stream to represent real-world connectivity to Supervisory Control And Data Acquisition (SCADA) and IoT data feeds.  By connecting your 3D assets to simulated telemetry data, your experience becomes more meaningful and you provide a glimpse into real world wind farm operations.  

Data can be connected to your Digital Twin in a variety of ways and in this module, we will use a series of Azure services, including ADT, to make your 3D assets more intelligent.  

Your Digital Twin app makes use of a **ScriptableObject** based event system that sends messages between systems that do not have direct knowledge of each other, such as the UI panels and turbines in the Unity **Scene**. Multiple events have been created as ScriptableObject assets in the Unity Project that can be referenced in a script to raise an event or can be added to a **Prefab** to listen for an event and react accordingly.  For example, when a user selects a turbine asset in the Scene the **OnWindTurbineSelected** event is raised. There may be multiple listeners in the Scene that can react to this event:

- The turbine UI panel will react to the event to display operational information of the selected turbine;
- The map will react by focusing / centering on the turbine location; and,
- This turbine model will highlight to show that it has been selected. 

By using this event-driven ScriptableObject architecture, you can create an integrated object-based experience without requiring each system (e.g., UI or 3D Scene) to explicitly know about one another. 
