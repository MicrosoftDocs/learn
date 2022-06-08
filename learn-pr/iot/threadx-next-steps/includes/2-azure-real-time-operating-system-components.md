## Introduction

The term *Azure RTOS* refers to an operating system kernel and a collection of multithreading facilities and middleware. Azure RTOS enables you to quickly build real-time applications for resource-constrained devices. The complete name for that kernel is Azure RTOS ThreadX, but we often shorten it to ThreadX.

## Azure RTOS components

Following are brief descriptions of ThreadX and each of the other facilities.

### Azure RTOS ThreadX

This advanced real-time operating system (RTOS) is designed specifically for deeply embedded applications. Among the multiple benefits it provides are real-time multithreading, inter-thread communication and synchronization, and memory management. Azure RTOS ThreadX has many advanced features, including picokernel architecture, preemption-threshold, event chaining, and a rich set of system services.

### Azure RTOS FileX

FileX is a high-performance, file allocation table (FAT)-compatible file system that’s fully integrated with Azure RTOS ThreadX and available for all supported processors. Like Azure RTOS ThreadX, Azure RTOS FileX is designed to have a small footprint and high performance, making it ideal for today’s deeply embedded applications that require file management operations.

### Azure RTOS GUIX Studio and GUIX

Azure RTOS GUIX Studio provides a complete, embedded graphical user interface (GUI) application design environment. It facilitates the creation and maintenance of all graphical elements in the application’s GUI. Azure RTOS GUIX Studio automatically generates C code that’s compatible with the Azure RTOS GUIX library, ready to be compiled and run on the target.

### Azure RTOS NetX

A high-performance implementation of TCP/IP protocol standards (IPv4 only), Azure RTOS NetX is fully integrated with Azure RTOS ThreadX and available for all supported processors. It has a unique piconet architecture. Combined with a zero-copy API, it makes it a perfect fit for today’s deeply embedded applications that require network connectivity.

### Azure RTOS NetX Duo

This advanced, industrial-grade TCP/IP network stack is designed specifically for deeply embedded real-time and IoT applications. Azure RTOS NetX Duo is a dual IPv4 and IPv6 network stack that provides a rich set of protocols, including security and cloud protocols.

### Azure RTOS TraceX

Azure RTOS TraceX is a Windows-based analysis tool. It provides embedded developers with a graphical view of real-time system events and enables them to visualize and better understand the behavior of their real-time systems. With TraceX, embedded developers can clearly see the occurrence of system events like interrupts and context switches that occur out of view of standard debugging tools.

### Azure RTOS USBX

A high-performance USB host and device embedded stack, Azure RTOS USBX is fully integrated with Azure RTOS ThreadX and available for all Azure RTOS ThreadX–supported processors. Like Azure RTOS ThreadX, Azure RTOS USBX is designed to have a small footprint and high performance, making it ideal for deeply embedded applications that require an interface with USB devices.

In the next unit, we'll investigate a valuable resource in furthering your knowledge of ThreadX. That resource is the ThreadX user guide.
