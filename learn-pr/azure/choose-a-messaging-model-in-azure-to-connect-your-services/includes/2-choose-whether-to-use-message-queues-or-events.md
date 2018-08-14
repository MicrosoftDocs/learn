## Motivation

Suppose you are planning the architecture of a distributed music-sharing application. You want to ensure that the application is as reliable and scalable as possible and you intend to use Azure technologies to build a robust communication infrastructure.

Before you can choose the right Azure technology, you must understand each individual communication that the components of the application exchange. For each communication you can choose a different Azure technology.

The first thing to understand about a communication is whether it sends messages or events. Some Azure technologies target events and other target messages so this is a fundamental choice.

## What is a message?

In the terminology of distributed applications, **messages** have the following characteristics:

- A message contains raw data, produced by one component, that will be consumed by another component.
- A message contains the data itself, not just a reference to that data.
- The sending component expects the message content to be processed in a certain way by the destination component. 

For example, suppose a user uploads a new song by using the mobile music-sharing app. The mobile app must send that song to the web API that runs in Azure. The song media file itself must be sent, not just a alert that indicates that a new song has been added. The mobile app expects that the web API will store the new song in the database and make it available to other users. This is an example of a message.

## What is an event?

**Events** are a little different to messages. They have the following characteristics:

- An event is a lightweight notification that indicates that something happened.
- The event does not include the data that triggered the event, although it might include the location of that data.
- The publisher of the event has no expectation about the action the receiving component takes. 
- Some events are discrete units and unrelated to other events. 
- Some events are part of a related and ordered series.  

For example, suppose the music file upload has been completed and the new song has been added to the database. In order to inform users of the new file, the web API must inform the web front-end and mobile app users of the new file. Note that users can choose whether to listen to the new song, so the initial notification does not include the music file but only notifies users that the song exists. This is an example of a discrete event.

## How to choose messages or events

A single application is likely to use events for some purposes and messages for others. Before you choose, you must analyze your application architecture and all its use cases to identify all the different purposes its components have to communicate with each other. 

For each those purposes consider the following questions:

1. Does the sending component expect the communication to be processed in a particular way by the destination component?
1. Does the communication include the data or payload that provoked it?

If the answer to either of these questions is yes, choose to use a message. If the answer to both of these questions is no, choose to use an event.

## Summary

The components of a distributed application communicate with each other for many different purposes. For each of these purposes, you must choose whether to use events or messages so that you can choose an Azure technology that is designed for that purpose. 

Having understood why your components communicate and whether they use events or messages, you can proceed to choose from Azure Storage queues, Event Hubs, Event Grids, or Service Bus to exchange the information.