## Cloud Connected Environment Deployment

A Cloud Connected Deployment for HoloLens 2 can be likened to the deployment of managed mobile devices within a company. It involves deploying HoloLens 2 devices primarily in external environments, separate from the corporate network. The access to corporate resources may be limited or not available through a VPN connection. Initially, the deployment can start with a small-scale approach, where a single device is connected to the cloud to understand the basic deployment process. These devices are connected to cloud services and the public internet, forming a proof-of-concept model that can be expanded to various HoloLens 2 use cases within the organization.

The deployment relies on Wi-Fi networks that are typically opened to the internet and cloud services. It utilizes Azure AD Join with MDM Auto Enrollment, where the devices are managed through an MDM solution like Intune. Users are required to sign in using their own corporate accounts through Azure AD. The deployment supports both single and multiple users per device, accommodating different usage scenarios.

:::image type="content" source="../media/deployment-guides-cloud-connected.png" alt-text="A diagram that visualizes resources that a HoloLens could connect to if executing a cloud connected deployment. The device connects to open WiFi, which provides access to various cloud services. In addition, the device could possibly connect to a VPN client. If connected to a VPN client, access to on-premises resources is protected by a firewall." lightbox="../media/deployment-guides-cloud-connected.png":::

## Corporate Network Deployment

A Corporate Network Deployment for HoloLens 2 involves integrating the devices with an organization's own network when deploying at a large scale. The devices are connected to a "Corporate" Wi-Fi network, making it suitable for internal users or for use within the corporate environment. This type of deployment is ideal for both pilot projects and full-scale production deployments.

The deployment utilizes an internal corporate network Wi-Fi, providing access to internal resources while having limited access to the internet or cloud services. It incorporates Azure Active Directory (Azure AD) Join with MDM Auto Enrollment, allowing the devices to be managed through an MDM solution like Intune. Users are required to sign in using their own corporate accounts through Azure AD. The deployment supports both single and multiple users per device, accommodating various usage scenarios.

Depending on specific use cases, the deployment applies varying levels of device lockdown configurations, ranging from fully open access to a single app kiosk mode. This deployment scenario enables customization and control over the device functionality based on the organization's requirements.

:::image type="content" source="../media/deployment-guides-corporate-network.png" alt-text="A diagram that visualizes the resources that a HoloLens could connect to if executing a corporate network deployment. The device connects to open WiFi, which provides access to various cloud services. In addition, MDM policies and apps are downloaded through Microsoft Intune." lightbox="../media/deployment-guides-corporate-network.png":::

## Restricted Offline Deployment

A Restricted Offline Deployment for HoloLens 2 caters to scenarios where mission-critical processes or corporate policies necessitate the use of offline environments. In this deployment type, the devices are connected to a highly restrictive network or function as purely offline devices. It's suitable for highly secure environments or areas with limited internet connectivity, such as remote locations.

This deployment follows a strict set of guidelines for applying a sample Provisioning Package that ensures the lockdown of HoloLens 2 devices for use in secure environments. The package enforces the following restrictions:

- Disabling WiFi functionality.
- Disabling Bluetooth connectivity.
- Disabling microphone access.
- Preventing the addition or removal of provisioning packages.
- Prohibiting users from enabling any of the restricted components mentioned.

The Restricted Offline Deployment ensures a high level of security and control over the HoloLens 2 devices. This deployment scenario makes the devices suitable for environments where offline operation or stringent restrictions are essential.

:::image type="content" source="../media/deployment-guides-secure-offline.png" alt-text="A diagram that visualizes the restriction of resource access for HoloLens Users if a restricted offline deployment is executed. The diagram indicates that CSPs lock down the device and keep it secure. In addition, there's no cloud services access offline, local wifi is optional, and ethernet to USB connection is also optional." lightbox="../media/deployment-guides-secure-offline.png":::

## Near Offline or Isolated Environment Deployment

The Near Offline or Isolated Environment deployment for HoloLens 2 focuses on delivering an optimal user and administrator experience while accommodating mission-critical processes or corporate policies that require offline environments. The devices are connected to a highly restrictive network or function as purely offline devices. This deployment type is well-suited for highly secure environments or locations with limited internet connectivity, such as remote areas.

This scenario allows for the utilization of Azure AD, Intune, Windows updates, and supports multiple users with IRIS sign-in, catering to organizations that face more security or networking challenges. It enables the deployment of HoloLens 2 in areas where networking is restricted. This deployment scenario could encompass secure environments or locations where networking can't be guaranteed, such as power plants, ships, or other similar settings.

The Near Offline or Isolated Environment deployment strikes a balance between ensuring security and meeting the needs of organizations that operate in environments with restricted networking capabilities. It uses the capabilities of Azure AD, Intune, and other tools to provide an enhanced user experience while adhering to the unique requirements of such deployment scenarios.

:::image type="content" source="../media/deployment-guides-near-offline-isolated.png" alt-text="A diagram that visualizes the resources that a HoloLens could connect to if executing a near offline or isolated environment deployment. The device has no wider internet connectivity but can connect to a wireless corporate network. There's also the option of implementing a firewall. Once authenticated, the user can access various Microsoft services." lightbox="../media/deployment-guides-near-offline-isolated.png":::
