## Learning objectives

In this module, you will learn about building and running a UDP echo server. You will build on the UDP echo client in the previous module, and you will again use Codespaces to build and run your project.

## Prerequisites

- Completion of the Azure RTOS NetX Duo first project module (from now on, NetX).
- If you haven't done so already, set up [GitHub Codespaces](https://github.com/features/codespaces) so that you can build and run your projects in this learning path.

## Overview

This module builds on the UDP echo client project module. It uses many of the concepts in the previous modules and adds several more features.

This module is the second of a series of four related modules as follows:

1. Building and running a UDP echo client
1. Building and running a UDP echo server
1. Building and running a TCP echo client
1. Building and running a TCP echo server

The UDP echo client is similar to the ping application in the Hello World module. The main difference is with the transport layer. In this project, UDP is used rather than ICMP. For UDP, you'll need to create a UDP socket, and bind it to a unique port in the system. Then it can start to send and receive data. For the typical UDP client, the local port is not important because it will send packets to the server first. But for the typical UDP server, it should bind to a port and let the client know. A UDP socket can send data to multiple servers, and a UDP server can also receive data from multiple clients. A UDP client is not bound to a server, which is one of the main differences from TCP. Note that when we use the word client, we are typically referring to an end user device or program. By contrast, a server is a program or device that provides service to clients. A single server can serve multiple clients, and a single client can use multiple servers.
