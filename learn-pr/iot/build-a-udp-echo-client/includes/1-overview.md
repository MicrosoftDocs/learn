## Learning objectives

In this module, you'll learn about building and running a UDP echo client. You'll learn about the user datagram protocol (UDP), ports, sockets, and packet transmission. You'll also use codespace to build and run your project.

## Prerequisites

- Completion of the Azure RTOS NetX Duo first project module (from now on, NetX).
- If you haven't done so already, set up [GitHub Codespaces](https://github.com/features/codespaces) so that you can build and run your projects in this learning path.

## Introduction

This module builds on the NetX first project module. It uses many of the concepts in the previous modules and adds several more features. This module is the first of a series of four related modules as follows:

1. Building and running a UDP echo client
1. Building and running a UDP echo server
1. Building and running a TCP echo client
1. Building and running a TCP echo server

Before starting with this module, we'll need to study the following concepts:

- User datagram protocol (UDP)
- UDP client
- UDP ports and sockets
- UDP packet send
- UDP packet receive

The UDP echo client is similar to the ping application in the Hello World module. The main difference is with the transport layer. In this project, UDP is used rather than ICMP. For UDP, you'll need to create a UDP socket, and bind it to a unique port in the system. Then it can start to send and receive data. For the typical UDP client, the local port isn't important because it will send packets to the server first. But for the typical UDP server, it should bind to a port and let the client know. A UDP socket can send data to multiple servers, and a UDP server can also receive data from multiple clients. A UDP client isn't bound to a server, which is one of the main differences from TCP. When we use the word client, we're typically referring to an end user device.

## User datagram protocol (UDP)

The User Datagram Protocol (UDP) provides the simplest form of data transfer between network devices. UDP data packets are sent from one network device to another in a best effort fashion, namely, there's no built-in mechanism for acknowledgment by the packet recipient. In addition, sending a UDP packet doesn't require any connection to be established in advance. Because of this, UDP packet transmission is efficient.

## UDP services used

We'll use various UDP services in this project. Here's a summary of these services and brief definitions.

| **Service**           | **Description**                  |
| --------------------- | -------------------------------- |
| nx_udp_enable         | Enable UDP component of NetX     |
| nx_udp_socket_bind    | Bind UDP socket to UDP port      |
| nx_udp_socket_create  | Create UDP socket                |
| nx_udp_socket_delete  | Delete UDP socket                |
| nx_udp_socket_receive | Receive datagram from UDP socket |
| nx_udp_socket_send    | Send a UDP Datagram              |
| nx_udp_socket_unbind  | Unbind UDP socket from UDP port  |

## UDP client

NetX provides many services to handle all the UDP traffic. We'll first create a client side of the UDP communication. We also need the UDP server, but we'll explore it in the next module. We'll focus on the UDP client side in this module.

## UDP ports and sockets

A UDP port is a logical endpoint in the UDP protocol. There are 65,535 valid ports in the UDP component of NetX, ranging from 1 through 0xFFFF. To send or receive UDP data, the application must first create a UDP socket, then bind it to a desired port. After binding a UDP socket to a port, the application may send and receive data on that socket. A socket is made up of an IP Address and a port number. A socket generally looks like this: 192.168.245.129:8080.

## UDP packet send

Sending UDP data is easily accomplished by calling the **nxd_udp_socket_send** function. The caller must set the IP version in the **nx_ip_version** field of the **NXD_ADDRESS** pointer parameter. NetX will determine the best source address for transmitted UDP packets based on the destination address. This service places a UDP header in front of the packet data and sends it out onto the network using an internal IP send routine.

## UDP packet receive

Receiving UDP packets from a particular socket is done by calling **nx_udp_socket_receive**. The socket receive function delivers the oldest packet on the socket’s receive queue.
