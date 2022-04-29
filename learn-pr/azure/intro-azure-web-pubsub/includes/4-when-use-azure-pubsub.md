Any scenario that requires real-time publish-subscribe messaging between server and clients or among clients can use Azure Web PubSub service. Traditional real-time features that often require polling from server or submitting HTTP requests can also use Web PubSub service.

Azure Web PubSub service can be used in any application type that requires real-time content updates.

## When to use Azure Web PubSub

Azure Web PubSub has a variety of applications, including but not limited to:

|          |              |                  |                    |                          |                                |
| -------- | ------------ | ---------------- | ------------------ | ------------------------ | ------------------------------ |
| Email    | GPS app      | Live chat room   | Logistic tracking  | Events broadcasting      | Team meeting software          |
| Voting   | Dashboard    | Social network   | Location tracking  | Social meeting apps      | On-line customer support       |
| Polling  | Travel apps  | Live captioning  | Whiteboard apps    | Instant sales update     | Real-time shopping assistant   |
| Auction  | Messenger    | IoT monitoring   | Video broadcasting | Real-time IoT metrics    | Live stock market dashboard    |
| Gaming   | Translating  | Remote control   | Audio broadcasting | Financial market data    | Transportation status updates  |
| Chat bot | In-game chat | Real-time status | News broadcasting  | Delivery status tracking | Multi-player game leader board |

A few more scenarios where Azure Web PubSub is very useful:

- **Build serverless real-time applications**: Use Azure Functions' integration with Azure Web PubSub service to build serverless real-time applications in languages such as JavaScript, C#, Java and Python.

- **Use WebSocket sub-protocol to do client-side only Pub/Sub**: Azure Web PubSub service provides WebSocket subprotocols to empower authorized clients to publish to other clients in a convenience manner.

- **Use provided SDKs to manage the WebSocket connections in self-host app servers**: Azure Web PubSub service provides SDKs in C#, JavaScript, Java and Python to manage the WebSocket connections easily, including broadcast messages to the connections, add connections to some groups, or close the connections, etc.

- **Send messages from server to clients via REST API**: Azure Web PubSub service provides REST API to enable applications to post messages to clients connected, in any REST capable programming languages.
