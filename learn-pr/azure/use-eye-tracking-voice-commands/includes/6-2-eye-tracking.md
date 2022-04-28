MRTK is highly considerate about the way humans communicate and express themselves. HoloLens 2 offers an exciting and powerful new input: Eye-tracking! Eye-tracking enables you to quickly and effortlessly engage with holograms across their view and make your system smarter by better identifying your intention. There are many use cases of Eye-tracking like user intent, implicit actions, attention tracking, gaming, text entry, and so on.

## Eye-tracking requirements checklist

For eye tracking to work correctly, the following requirements must be met. If you're new to eye tracking on HoloLens 2 and to how eye tracking is set up in MRTK, don't worry! We will go into detail on how to address each of them further below.

* An 'Eye Gaze Data Provider' must be added to the input system. This provides eye tracking data from the platform.
* The 'GazeInput' capability must be enabled in the application manifest. **This capability can be set in Unity 2019, but in Unity 2018 and earlier this capability is only available in Visual Studio and through the MRTK build tool**
* The HoloLens must be eye calibrated for the current user. Check out our [sample for detecting whether a user is eye calibrated or not](/windows/mixed-reality/mrtk-unity/features/input/eye-tracking/eye-tracking-is-user-calibrated).
