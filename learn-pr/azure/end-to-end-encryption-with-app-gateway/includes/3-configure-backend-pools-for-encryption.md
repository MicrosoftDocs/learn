In this unit, you will see how the backend pool is setup. The backend pool is needed to route traffic to your servers from the Application Gateway.

## Backend pool

A backend pool routes traffic to your servers from the Application Gateway. You can setup the backend pool with either one or many servers, and it will load balance between these servers that you setup.

Backend pools can be setup with:

- IP addresses (Public or Private)
- Virtual Machines
- App Services

## HTTP settings

The HTTP settings are applied to the backend pool and include the port, protocol and TLS certificate used for the traffic being sent to the backend pool servers.