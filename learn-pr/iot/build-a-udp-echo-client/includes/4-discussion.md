Congratulations on making it to this section! Now we need to reflect on what we've done and understand how the concepts in this project will help you in the future.

1. To keep the minimal code size, the transport layer protocols aren't enabled automatically in NetX. We need to call **nx_udp_enable** to enable UDP functionalities.
1. Each UDP socket must bind to a port. In this project, the UDP socket is bound to any port and NetX will pick a random port.
1. Data are filled into **NX_PACKET**, which ensures zero copy in NetX. In each round, a new packet is allocated and filled with data.
1. After a packet is sent by **nxd_udp_socket_send**, the ownership of this packet is transferred to NetX. The user application must not reference this packet again.
1. A packet can be received from **nx_udp_socket_receive**. The ownership is transferred to the user application, and it's responsible to release it at the end. The wait option can be specified in **nx_udp_socket_receive**.
1. All the wait options are measured by timer ticks in Azure RTOS rather than milliseconds or seconds.
