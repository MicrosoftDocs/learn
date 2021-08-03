We saw how the 3D warehousing scenario could be implemented using Azure private MEC and 5G. Azure private MEC and 5G help implement scenarios where ultra-low latency and high sensor density are needed. In addition, Azure private MEC enables access to other Azure services to help create an end-to-end service.  Here, we'll list criteria that help you decide whether Azure private MEC and 5G are the right choices to implement similar scenarios.

**Network latency and sensor density:** These are the primary criteria for enterprise 5G and IoT. If you have a requirement that needs low latency and you have a high density of sensors in a geographical area (such as a stadium), you need 5G. Note that even when implementing 5G, you may need to complement 5G coverage using other connectivity modes (such as Wi-Fi and LTE). 

**Choice of hardware for deployment:** The next consideration is the choice of hardware for deployment. Here, there are two possibilities. Typically, if you are deploying on edge devices, you would choose Azure Stack edge. However, you could also deploy as a virtual machine in your data center – in which case you could choose Azure Stack HCI.

**Designing your end-to-end service:** Next, you need to choose the components that comprise your end-to-end service. For example, you could implement such a service using Azure IoT Edge Runtime, Azure IoT Hub, Azure IoT Central, Azure Digital Twins, and others.

**Azure management services:** Having designed your service, you should now decide how to manage your service. You could choose tools like Azure Network Functions Manager (NFM) and Arc Enabled Kubernetes.

**Azure network functions offered as third party marketplace offerings:** Finally, if desired, you could choose additional components from the marketplace like 
Metaswitch Fusion Core.
