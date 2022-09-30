## Overview

Welcome to networking and Azure RTOS NetX Duo (from now on, NetX). In this module, you'll be introduced to NetX Duo, which is a high-performance real-time implementation of the TCP/IP stack (or protocol suite) designed exclusively for embedded ThreadX-based applications.  

When you complete this series of modules, you'll have acquired a solid foundation of NetX Duo concepts and techniques. You'll be prepared to apply what you have learned, and you'll be ready to expand your knowledge about the wonderful world of networking.

## Learning objectives

In this module, you will:

- Learn the basic components of NetX Duo 
- Learn about the purpose of the protocols 
- Learn about the four layers of the TCP/IP model

## Prerequisites

Completion of the [Azure RTOS ThreadX learning path](https://docs.microsoft.com/learn/paths/azure-rtos-threadx/).

## TCP/IP Stack

The TCP/IP stack is where everything happens. Do you want to send a message? Do you want to send a photo? If so, the TCP/IP stack is where these activities happen. The TCP/IP stack uses a four-layer model as illustrated in the following image. 

[Diagram, schematic]

This is an overview of the TCP/IP model, and we’ll get into more detail later. This four-layer model consists of a series of protocols, each performing a specific operation. Requests originate at the application layer and are processed through each successive layer until they reach the link layer. Responses to requests originate at the link layer and proceed through the successive layers until they reach the application layer. A request can take many different forms, such as sending an email, transmitting a photo, or requesting a web page.

## Protocols 

There are millions of computers, phones, tablets, and other devices that use the Internet to communicate and share information. For these devices to use the Internet, they must observe a set of established rules and procedures that are called protocols. You'll use many different protocols as we study the TCP/IP model, which is actually a protocol suite.

## Application layer

The application layer establishes the connection between data and the application. Following is a table describing several typical protocols.

[List of app layer protocols]

## Transport layer

The transport layer is responsible for managing the flow of data between hosts on the network. The data is divided into numbered segments and ensures that all segments are received correctly. Following is a table describing the more commonly used protocols.

[List of transport layer]

## Network layer 

The network layer is sometimes called the Internet layer and it is responsible for sending and receiving simple packets across the network. Following is a table describing the more commonly used protocols.

## Link layer 

The link level is handled by the network driver. This level is typically targeted towards Ethernet, but it could also be fiber, serial, or virtually any physical media.

## Reference documentation

We cover the basics of NetX Duo in this learning path, but detailed information can be found in the [NetX Duo user guide](https://docs.microsoft.com/azure/rtos/netx-duo/).

