Finally, you get to work on a simple Hello World project that will provide you with hands-on experience with NetX Duo. The project will introduce you to some basic concepts including the fundamental structure of a NetX Duo project, the creation of packet pools, the use of address resolution protocol (ARP), internet control message protocol (ICMP), and ping requests.

To get started, let’s look at the code in the Hello World project, and understand the purpose of each section. We'll investigate the code based on the general template. In this project, we won't have a section containing functions, but we'll in subsequent modules.

## Section 1—Includes and definitions

As you may recall from the NetX Duo general template, the first section comprises the include directives and the definitions.

Required C header files for ThreadX and NetX Duo containing system equates, data structures, and service prototypes are specified here.

```c
#include   "tx_api.h"
#include   "nx_api.h"
```

Sample IP address and subnet mask that we'll use in this project are defined here.

```c
/* Define sample IP address.  */
#define SAMPLE_IPV4_ADDRESS          IP_ADDRESS(192, 168, 1, 2)
#define SAMPLE_IPV4_MASK             0xFFFFFF00UL
```

Packet pool is defined here

```c
/* Define packet pool.  */
#define PACKET_SIZE         1536
#define PACKET_COUNT        30
#define PACKET_POOL_SIZE    (PACKET_SIZE + sizeof(NX_PACKET)) * PACKET_COUNT)
```

IP stack size defined here

```c
/* Define IP stack size.   */
#define IP_STACK_SIZE        2048
```

IP thread priority defined here

```c
/* Define IP thread priority.  */
#define IP_THREAD_PRIORITY   1
```

ARP pool defined here

```c
/* Define ARP pool.  */
#define ARP_POOL_SIZE        1024
```

ThreadX and NetX Duo object control blocks defined here

```c
/* Define the ThreadX and NetX object control blocks. */
NX_PACKET_POOL          default_pool;
NX_IP                   default_ip;
```

Memory buffers defined here

```c
/* Define memory buffers.  */
ULONG                   pool_area[PACKET_POOL_SIZE >> 2];
ULONG                   ip_stack[IP_STACK_SIZE >> 2];
ULONG                   arp_area[ARP_POOL_SIZE >> 2];
```

> [!NOTE]
> The purpose of the shift right operator (>>) in the three examples above is for byte alignment.

Error counter defined here

```c
/* Define the counter used in the demo application...  */
ULONG                   error_counter;

/***** Substitute your ethernet driver entry function here *********/
extern  VOID _nx_linux_network_driver(NX_IP_DRIVER*);
```

## Section 2—Main

The second part of the general template is the **main**, which is often the same in most projects.

```c
/* Define main entry point.  */
int main()
{
    /* Enter the ThreadX kernel.  */
    tx_kernel_enter();
}
```

Any code following `tx_kernel_enter()` is unreachable.

## Section 3—`tx_application_define`

The `tx_application_define` is devoted to NetX Duo initialization, creating packet pools, IP instance creation, enabling ARP and ICMP, and displaying output information.

```c
/* Define what the initial system looks like.  */
void    tx_application_define(void *first_unused_memory)
{

UINT    status;

NX_PARAMETER_NOT_USED(first_unused_memory);
```

This is a macro to avoid a compiler warning concerning a parameter that isn't used. It isn't executed during runtime.

```c
    /* Initialize the NetX system.  */
    nx_system_initialize();

    /* Create a packet pool.  */
    status = nx_packet_pool_create(&default_pool, "NetX Main Packet Pool",
                                   PACKET_SIZE, pool_area,
                                   sizeof(pool_area));

    /* Check for packet pool create errors.  */
    if (status)
        error_counter++;

    /* Create an IP instance.  */
    status = nx_ip_create(&default_ip, "NetX IP Instance 0",
                          SAMPLE_IPV4_ADDRESS, SAMPLE_IPV4_MASK,
                          &default_pool, _nx_linux_network_driver,
                          (void *)ip_stack, sizeof(ip_stack),
                          IP_THREAD_PRIORITY);

    /* Check for IP create errors.  */
    if (status)
        error_counter++;

    /* Enable ARP and supply ARP cache memory for IP Instance 0.  */
    status =  nx_arp_enable(&default_ip, (void *)arp_area, sizeof(arp_area));

    /* Check for ARP enable errors.  */
    if (status)
        error_counter++;

    /* Enable ICMP */
    status = nx_icmp_enable(&default_ip);

    /* Check for ICMP enable errors.  */
    if(status)
        error_counter++;

    /* Output IP address and network mask.  */
    printf("NetXDuo is running now...\r\n");
    printf("IP address: %lu.%lu.%lu.%lu\r\n",
           (SAMPLE_IPV4_ADDRESS >> 24),
           (SAMPLE_IPV4_ADDRESS >> 16 & 0xFF),
           (SAMPLE_IPV4_ADDRESS >> 8 & 0xFF),
           (SAMPLE_IPV4_ADDRESS & 0xFF));
    printf("Mask: %lu.%lu.%lu.%lu\r\n",
           (SAMPLE_IPV4_MASK >> 24),
           (SAMPLE_IPV4_MASK >> 16 & 0xFF),
           (SAMPLE_IPV4_MASK >> 8 & 0xFF),
           (SAMPLE_IPV4_MASK & 0xFF));
}
```

We won't use the fourth component of the general template because we don't have any functions in the Hello World project.
