Network infrastructure services are an essential foundation of many other server-based services. Therefore, you should correctly configure them and ensure that they run optimally. Your organization can benefit in several ways by gathering performance-related data on your network infrastructure services.

- Optimizing network-infrastructure server performance. Providing a performance baseline and trend data enables you to help your organization optimize your network infrastructure servers' performance.

- Troubleshooting servers. When server performance degrades, either over time or during periods of peak activity, you can help identify possible causes and take corrective action. This can help you quickly bring a service back within the limits of your service level agreement.

There are two critical on-premises network services that are especially important to monitor. These are Domain Name System (DNS) and the Dynamic Host Configuration Protocol (DHCP) service.

## Monitor DNS

DNS provides name-resolution services on a network. You can monitor the Windows Server DNS Server role to determine the following aspects of your DNS infrastructure, including the:

- General DNS server statistics, including the number of overall queries and responses that a DNS server is processing.

- UDP or TCP counters, which measure DNS queries and responses that the DNS server processes by using either of these transport protocols.

- Dynamic update and secure dynamic-update counters for measuring registration and update activity that dynamic clients generate.

- Memory-usage counter for measuring a system's memory usage and memory-allocation patterns that are created by operating the server computer as a DNS server.

- Recursive lookup counters for measuring queries and responses when the DNS Server service uses recursion to look up and fully resolve DNS names on behalf of requesting clients.

- Zone transfer counters, including specific counters for measuring all zone transfer (AXFR), incremental zone transfer (IXFR), and DNS zone-update notification activity.

> [!TIP]
> You can also perform basic DNS monitoring by using the DNS console.
## Monitoring DHCP

DHCP provides dynamic IP configuration services for your network, and it provides data on a DHCP server, including the:

- The Average Queue Length counter indicates the current length of a DHCP server's internal message queue. This number represents the number of unprocessed messages that the server receives. A large number might indicate heavy server traffic.

- The Milliseconds per packet counter is the average time that a DHCP server uses to process each packet that it receives. This number varies depending on the server hardware and its I/O subsystem. A spike indicates a problem with the I/O subsystem becoming slower or because of intrinsic processing overhead on the server.

> [!TIP]
> You can also perform basic DHCP monitoring by using the DHCP Manager console.
