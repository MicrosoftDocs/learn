Congratulations on making it to this section! Now we need to reflect on what we have done and understand how the concepts in this project will help you in the future.

1. The UDP server socket must be bound to a port that is known by the client.
1. When a packet is received from the UDP socket, the IP address and port of the peer are stored in **NX_PACKET**. They can be retrieved by **nxd_udp_source_extract**.
1. The NetX UDP socket can receive packets from all interfaces and IP addresses.
