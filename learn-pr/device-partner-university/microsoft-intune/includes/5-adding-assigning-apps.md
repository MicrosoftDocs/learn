Ensure that you have access to the apps you need to work. With Intune, you can [add and assign an app](/mem/intune/apps/quickstart-add-assign-app) to your devices. Before assigning an app, you must [create a user](/mem/intune/fundamentals/quickstart-create-user#create-a-user), [create a group](/mem/intune/fundamentals/quickstart-create-group), and [enroll a device](/mem/intune/enrollment/quickstart-enroll-windows-device).

![A photograph of two employees working together on a laptop while seated at a desk in an office environment.](../media/access-management.png)

## Assign apps to a group

After you add an app to Intune, you can assign the app to other groups of users or devices. Use these steps to assign an app to a group:

1. In Intune, **select Apps > All apps**.

2. **Select the app** that you want to assign a group to.

3. **Choose Properties**. Next to Assignments, **choose Edit**.

4. **Select Add group** under the Required, Available for enrolled devices, or Available with or without enrollment section depending on assignment intent.

5. **Find the group** that you need to add to and **choose Select** at the bottom of the pane.

6. **Choose Review + save > Save** to assign the group.

## Add apps to Intune

Use these steps to add an app to Intune:

1. **Sign in** to Microsoft Endpoint Manager admin center, **select Apps > All apps > Add**.

2. **Choose the type of app you need** in the Intune 'Select app type' pane.

3. **Choose Select**. The Add app steps are displayed.

4. **Complete the configuration steps** specific to the app type chosen.

6. **Select the group assignments** for the app.

7. **Choose Next** to display the Review + create page. **Review** the values and settings, then **choose Create** to add the app to Intune.

## Install apps on enrolled devices

Your customers should use the Company Portal app to install apps that are assigned as 'available' (optional). The Company Portal app itself can be installed manually from the Microsoft Store on Windows devices or set as 'required' in Intune, so it installs automatically on assigned devices.

To verify the app is accessible on your customers' enrolled devices, follow these steps:

1. **Log in** to your enrolled Windows 11 Desktop device.

2. **Open** the Microsoft Store from the Start menu, find the Company Portal app, and install it.

3. **Launch** the Company Portal app.

4. **Select** the app you added via Intune.

5. **Select** Install.