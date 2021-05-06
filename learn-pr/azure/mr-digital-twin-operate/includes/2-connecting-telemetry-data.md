Bringing your Digital Twin to life in your immersive experience couldn’t happen without having data to support what is happening in the experience.  Telemetry is the in situ collection, transmission, and receipt of data from remote points to a collection point for further use (for example, storage, analysis, modeling, and so on).  Each of the wind turbines in your wind farm can be connected to a simulated data stream to represent real-world connectivity to SCADA and IoT data feeds.  By connecting your 3D assets to simulated telemetry data, your experience becomes more meaningful and you provide a glimpse into wind farm operations.

Data can be connected in various ways to your Digital Twin and in this module, we will use a series of Azure services, including ADT, to make your 3D assets more intelligent.  

Your Digital Twin app makes use of a ScriptableObject based event system that sends messages between systems that don't have direct knowledge of each other, such as the UI panels and turbines in the Scene.  Multiple events have been created as ScriptableObject assets in the Unity Project that can be referenced in a script to raise the event or be added to a Prefab to listen and react to an event.  For example, when a user selects a turbine asset in the Scene the OnWindTurbineSelected event is raised. There may be multiple listeners in the scene that can react to this event such as:

- Turbine UI panel will react to the event to display operational information of the selected turbine
- The map will react by focusing / centering on the turbines location
- This turbine model will highlight to show that it has been selected. 

By using this event-driven Scriptable Object architecture, we can create an integrated object-based experience without needing to have each system (for example, UI or 3D scene) to explicitly know about each other.