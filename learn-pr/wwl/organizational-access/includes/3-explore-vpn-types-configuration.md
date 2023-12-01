

Virtual private networks (VPNs) are point-to-point connections across a private or public network, such as the internet. A VPN client uses special TCP/IP or UDP-based protocols, called tunneling protocols, to make a virtual call to a virtual port on a VPN server. In a typical VPN deployment, a client initiates a virtual point-to-point connection to a remote access server over the internet. The remote access server answers the call, authenticates the caller, and transfers data between the VPN client and the organization’s private network.

There are many options for VPN clients. In Windows, the built-in plug-in and the Universal Windows Platform (UWP) VPN plug-in platform are built on top of the Windows VPN platform.

:::image type="content" source="../media/windows-vpn-platform-ffcf080a.png" alt-text="Diagram of VPN connection types.":::


### Built-in VPN client

Windows provides a built-in VPN client software that you can configure to establish various types of VPN connections. VPN connections can use different tunneling protocols. You should configure same tunneling protocol on both VPN server and VPN client side. In Windows, following tunneling protocols are supported:

 -  Internet Key Exchange version 2 (IKEv2) - Configure the IPsec/IKE tunnel cryptographic properties using the Cryptography Suite setting in the VPNv2 Configuration Service Provider (CSP).
 -  L2TP - L2TP with pre-shared key (PSK) authentication can be configured using the L2tpPsk setting in the VPNv2 CSP.
 -  PPTP - Point-to-Point Tunneling Protocol.
 -  SSTP - SSTP is supported for Windows desktop editions only. SSTP can't be configured using mobile device management (MDM), but it’s one of the protocols attempted in the Automatic option.

If you don’t know which tunneling protocol to use, you can also choose automatic configuration of VPN client. The Automatic option means that the device will try each of the built-in tunneling protocols until one succeeds. It will attempt from most secure to least secure.

### Universal Windows Platform VPN plug-in

The Universal Windows Platform (UWP) VPN plug-ins were introduced in Windows 10, although there were originally separate versions available for the Windows 8.1 Mobile and Windows 8.1 PC platforms. Using the UWP platform, third-party VPN providers can create app-containerized plug-ins using WinRT APIs, eliminating the complexity and problems often associated with writing to system-level drivers.

There are many Universal Windows Platform VPN applications, such as Pulse Secure, Cisco AnyConnect, F5 Access, SonicWall Mobile Connect, and Check Point Capsule. If you want to use a UWP VPN plug-in, work with your vendor for any custom settings needed to configure your VPN solution.
