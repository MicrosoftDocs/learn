Now that you understand how the PC Health Check app determines device eligibility, it’s time to apply what you’ve learned. 
 
In this hands-on exercise, you use PC Health Check to assess the Windows 11 readiness of a noncentrally managed device.

> [!IMPORTANT]
> This exercise is designed for unmanaged or standalone devices—those not connected to a centralized solution such as Microsoft Intune.  
> You need administrative access to install and run the PC Health Check app.

## Run the PC Health Check app

1. Open the **taskbar search** in Windows and type **PC Health Check**.
   - If the application isn’t installed, download it from [https://aka.ms/GetPCHealthCheckApp](https://aka.ms/GetPCHealthCheckApp) and follow the prompts to install.

1. Open the application. On the main page, select **Check now** to start the Windows 11 eligibility scan.
 
   :::image type="content" border="true" source="../media/pc-health-check.png" alt-text="Screenshot showing the Check now button in PC Health Check app." lightbox="../media/pc-health-check-expanded.png":::

1. Review the summary results. The app displays one of the following outcomes:

    | Screen | Status | Description |
    |------|---------|--------------|
    | :::image type="content" border="true" source="../media/pc-health-green.png" alt-text="Screenshot showing the This PC meets Windows 11 requirements screen in PC Health Check.":::| **This PC meets Windows 11 requirements** | The device is ready for upgrade. |
    | :::image type="content" border="true" source="../media/pc-health-yellow.png" alt-text="Screenshot showing the This PC doesn’t currently meet requirements screen in PC Health Check."::: | **This PC doesn’t currently meet requirements** | The device may need additional steps, such as enabling TPM 2.0 or Secure Boot. |
    | :::image type="content" border="true" source="../media/pc-health-red.png" alt-text="Screenshot showing the the This PC can’t run Windows 11 screen in PC Health Check."::: | **This PC can’t run Windows 11** | The device doesn’t meet minimum requirements and must be replaced. |

> [!NOTE]
> If a device doesn’t meet the requirements, expand the details in the PC Health Check results to learn which hardware components failed and what actions might resolve them.

## Review your results

After running the check:

- Record the number of devices that meet requirements.  
- Identify which failed components appear most frequently (for example, TPM 2.0 or Secure Boot).  
- Decide which devices might be upgradable versus those that need replacement.

> [!TIP]
> Saving your results now can help accelerate later phases of your Windows 11 upgrade planning.

## Taking action on noneligible devices

When devices don’t meet Windows 11 requirements, you have two main options:

- **Upgrade hardware:** Identify components that can be updated, such as enabling TPM 2.0, turning on Secure Boot, or increasing RAM. These upgrades can often extend the lifespan of otherwise capable devices.  

- **Replace devices:** For older or incompatible systems, plan early replacements to maintain compliance and avoid downtime. Coordinate with your procurement or device partner to ensure new devices meet Windows 11 standards.

Use this assessment phase to create a phased replacement plan—not to react when devices fail. Proactive planning ensures every endpoint remains secure and aligned with your organization’s modernization goals.

By completing this exercise, you’ve learned how to use the PC Health Check app to evaluate unmanaged devices for Windows 11 readiness and to interpret the results effectively. Next, you learn how to assess centrally managed devices using **Endpoint Analytics** in Microsoft Intune.