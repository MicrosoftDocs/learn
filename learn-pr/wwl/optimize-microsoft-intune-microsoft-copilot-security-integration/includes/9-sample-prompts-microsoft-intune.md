You can create custom prompts in Microsoft Copilot for Security to access specific information about your Intune data. Be clear and specific with your prompts, including details like device IDs, app names, or policy names for better results. For example, use prompts like “According to Intune, how many devices were enrolled this week?” or “Tell me about Intune devices for [user name].” Experiment with different variations to see what works best, and save effective prompts in a promptbook for future use. This section lists some ideas and examples.

### Before you begin

- Be clear and specific with your prompts. You might get better results if you include specific device IDs or names, app names, or policy names in your prompts.

  It might also help to add **Intune** to your prompt, like:

  - **According to Intune, how many devices were enrolled this week**?
  - **Tell me about Intune devices for (user name)**.

- Experiment with different prompts and variations to see what works best for your use case. Chat AI models vary, so iterate and refine your prompts based on the results you receive.  

  You can also save your prompts in a promptbook for future use. For more information, go to:

  - [Prompting in Microsoft Copilot for Security](/security-copilot/prompting-security-copilot)
  - [Using promptbooks in Microsoft Copilot for Security](/security-copilot/using-promptbooks)

### General information about your Intune data

Get **general information** about your Intune data, like the number of devices, apps deployed, platform versions of your devices, and more.

**Sample prompts**:

- What apps are added to Intune?
- What Intune apps are assigned the most?
- How many devices were enrolled in Intune in the last 24 hours?
- Tell me about Intune devices for Jon Smith.

### Policy targets

Get details on **policy targets**, like the groups that have a specific app assigned or how many users have a specific app assigned.

**Sample prompts**:

- How many users is ContosoApp assigned to?
- Which groups are ContosoApp assigned to?
- How many apps are assigned to the device ID *Enter the device ID* in Intune?
- Why is the "Allow Microsoft Store App to auto update" policy applying to DeviceA?
- Tell me about Intune devices for user UserA.
- Why is PolicyA applying on DeviceB?

### Specific devices

Get information about a **specific device**, like its group memberships and the apps assigned to it.

**Sample prompts**:

- What devices are used by UserA@contoso.com?
- What groups is DeviceA in?
- Tell me about DeviceA.
- Who is the primary user for DeviceA?
- Is ContosoApp installed on DeviceA?
- Show me discovered apps on DeviceA.

### Similarities and differences

Get the **similarities and differences** between two devices, like the compliance policies, hardware, and device configurations assigned to both devices.

**Sample prompts**:

- What is the hardware configuration difference between the DeviceA and DeviceB devices?
- What are the similarities in compliance policies between the DeviceA and DeviceB devices?
- What is the difference in device configuration profile between the DeviceA and DeviceB devices?
- Compare installed applications on DeviceA and DeviceB.
