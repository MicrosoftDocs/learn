A validated list of standard VPN devices that work well with the VPN gateway is available for developers. The list was created in partnership with device manufacturers like Cisco, Juniper, Ubiquiti, and Barracuda Networks. 

### Things to know about configuring your VPN device

Let's explore how to complete the on-premises configuration of your VPN device.

- Check the list of validated devices to find your device. To view the list, see [Validated VPN devices and device configuration guides](/azure/vpn-gateway/vpn-gateway-about-vpn-devices#devicetable).

   > [!Note]
   > If your device isn't represented in the list of validated VPN devices, your device might still work. Contact your device manufacturer for support and configuration instructions.

- To configure your VPN device, you need the following information:

   - **A shared key**. This key is the same shared key that you specify when you create the VPN connection.

   - **The public IP address of your VPN gateway**. The IP address can be new or existing.

- **Configuration scripts** are available for some devices. Review the [Download VPN device configuration scripts for S2S VPN connections](/azure/vpn-gateway/vpn-gateway-download-vpndevicescript) to find a downloadable script for your VPN device.