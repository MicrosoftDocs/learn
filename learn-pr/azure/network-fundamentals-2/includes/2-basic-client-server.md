
In this unit, you'll learn 

**An introduction to IP/TCP Basics**

- What is TCP
  - One of the main protocols in the Internet protocol suite
- What is IP
  -  [IP](https://searchunifiedcommunications.techtarget.com/definition/Internet-Protocol) defines how to [address](https://searchnetworking.techtarget.com/definition/address) and [route](https://searchnetworking.techtarget.com/definition/routing-table) each packet to make sure it reaches the right destination.
- What is TCP/IP
  - TCP/IP, or the Transmission Control Protocol/Internet Protocol, is a suite of communication [protocols](https://searchnetworking.techtarget.com/definition/protocol) used to interconnect [network](https://searchnetworking.techtarget.com/definition/network) devices on the internet.
  - TCP/IP model layers
- Internet Protocol Address standards
      - IPv4
           - **Internet Protocol version 4** (**IPv4**) is the fourth version of the [Internet Protocol](https://en.wikipedia.org/wiki/Internet_Protocol) (IP). It is one of the core protocols of standards-based internetworking methods in the [Internet](https://en.wikipedia.org/wiki/Internet) and other [packet-switched](https://en.wikipedia.org/wiki/Packet-switched) networks.
           - Special Use addresses
      - IPv6
           - **Internet Protocol version 6** (**IPv6**) is the most recent version of the [Internet Protocol](https://en.wikipedia.org/wiki/Internet_Protocol) (IP), the [communications protocol](https://en.wikipedia.org/wiki/Communication_protocol) that provides an identification and location system for computers on networks and routes traffic across the [Internet](https://en.wikipedia.org/wiki/Internet).
           - Address Space Exhaustion
           - IPv6 Addressing
                - [IPv6 addresses](https://en.wikipedia.org/wiki/IPv6_address) have 128 bits. The design of the IPv6 address space implements a different design philosophy than in IPv4, in which subnetting was used to improve the efficiency of utilization of the small address space. 
  - Subnetting
        - A **subnetwork** or **subnet** is a logical subdivision of an [IP network](https://en.wikipedia.org/wiki/IP_network).[[1\]](https://en.wikipedia.org/wiki/Subnetwork#cite_note-rfc950-1):1.16 The practice of dividing a network into two or more networks is called **subnetting**.
  - Private IP Addressing
        - Of the approximately four billion addresses defined in IPv4, about 18 million addresses in three ranges are reserved for use in [private networks](https://en.wikipedia.org/wiki/Private_network). 
  - DNS
        - The **Domain Name System** (**DNS**) is a [hierarchical](https://en.wikipedia.org/wiki/Hierarchy) and [decentralized](https://en.wikipedia.org/wiki/Decentralised_system) naming system for computers, services, or other resources connected to the [Internet](https://en.wikipedia.org/wiki/Internet) or a private network.
        - Function of the DNS
  - Ports
        - In [computer networking](https://en.wikipedia.org/wiki/Computer_networking), a **port** is a communication endpoint. Physical as well as wireless connections are terminated at ports of hardware devices.
        - Port Numbers
              - A port number is a 16-bit unsigned integer, thus ranging from 0 to 65535.
              - Common Port Numbers
                    - The port numbers are divided into three ranges: the *well-known ports*, the *registered ports*, and the *dynamic* or *private ports*.

- How this relates to what will be done in Azure.
  - Azure Subnets
  - Azure DNS
  - Azure VNET
  - Azure Management Console
  
- Knowledge check
  - What is the structure of an IPv4 address?
    - It is comprised of four numbers, in the range 0-255, each separated by a decimal.
  - What is TCP/IP
    - It is a protocol used to interconnect network devices on the internet. 
  - What is a subnet?
    - It is the logical subdivision of an IP based network.
  - How would you access a private network from the internet?
    - It is not possible to access a private network from the internet.  A private network can access another private network using a Network address translation.
  - What is the DNS?
    - It is a hierarchical and decentralized naming system for computers, services, or other resources connected to the Internet or a private network.
  - What port number is associated with the FTP data transfer protocol?
    - 20