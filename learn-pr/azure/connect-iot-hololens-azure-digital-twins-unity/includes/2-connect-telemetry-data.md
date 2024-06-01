Bringing your digital twin to life in your immersive experience wouldn't be possible without attribute data to support the experience. Telemetry is the in-place collection, transmission, and receipt of data from remote points to a collection point for further use. Examples of data use include storage, analysis, and modeling.

Each of the wind turbines in your wind farm can be connected to a simulated data stream to represent real-world connectivity to supervisory control and data acquisition (SCADA) and IoT data feeds. When you connect your 3D assets to simulated telemetry data, your experience becomes more meaningful. You provide a glimpse into real world wind farm operations.

Data can be connected to your digital twin in different ways. This module uses Azure services, including Azure Digital Twins, to make your 3D assets more intelligent.

Your Azure Digital Twins app makes use of a `ScriptableObject`-based event system that sends messages between systems that don't have direct knowledge of each other, such as the UI panels and turbines in the Unity *scene*. Multiple events have been created as `ScriptableObject` assets in the Unity project that a script can use to raise an event. The assets can be added to a *prefab* to listen for an event and react correctly. For example, when a user selects a turbine asset in the scene, the `OnWindTurbineSelected` event is raised. There might be multiple listeners in the scene that can react to this event:

* The turbine UI panel reacts to the event to display operational information of the selected turbine.
* The map reacts by focusing and centering on the turbine location.
* This turbine model is highlighted to show that it has been selected.

By using this event-driven scriptable object architecture, you can create an integrated object-based experience without requiring each system, for example, UI or 3D Scene, to explicitly know about one another.
