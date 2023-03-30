Congratulations on making it this far! Now we need to reflect on what we have done and understand how the concepts in this project will help you in the future.

- As with the UDP project, in order to keep the code size at a minimum, the transport layer protocols are not enabled automatically in NetX Duo. We need to call nx_tcp_enable to enable TCP functionalities.
- Each TCP socket must bind to a port. In this project, the TCP socket is bound to any port and NetX Duo will pick a random port.
- The TCP client socket must connect to a TCP server socket before it can start transmitting data.
- The `nxd_tcp_client_socket_connect` service can only be used by the TCP client socket. This service supports both IPv4 and IPv6.
- Data are filled into NX_PACKET which ensures zero copy in NetX Duo. In each round, a new packet is allocated and filled with data.
- After a packet is sent by nx_tcp_socket_send, the ownership of this packet is transferred to NetX Duo. The user application must not reference this packet again.
- A packet can be received from nx_tcp_socket_receive. The ownership is transferred to the user application and it's responsible to release it at the end. The wait option can be specified in nx_tcp_socket_receive.
- All the wait options are measured by timer ticks in Azure RTOS rather than milliseconds or seconds.
- 