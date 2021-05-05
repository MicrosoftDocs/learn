Azure SignalR Service simplifies the process of adding real-time web functionality to applications over HTTP. This real-time functionality allows the service to push content updates to connected clients, such as a single page web or mobile application. As a result, clients are updated without the need to poll the server, or submit new HTTP requests for updates.

Any scenario that requires pushing data from server to client in real time, can use Azure SignalR Service.

Traditional real-time features that often require polling from a server, can also use Azure SignalR Service.

Azure SignalR Service has been used in a wide variety of industries, for any application type that requires real-time content updates. We list some examples that are good to use Azure SignalR Service:

- **High frequency data updates:** gaming, voting, polling, auction.
- **Dashboards and monitoring:** company dashboard, financial market data, instant sales update, multi-player game leader board, and IoT monitoring.
- **Chat:** live chat room, chat bot, on-line customer support, real-time shopping assistant, messenger, in-game chat, and so on.
- **Real-time location on map:** logistic tracking, delivery status tracking, transportation status updates, GPS apps.
- **Real time targeted ads:** personalized real time push ads and offers, interactive ads.
- **Collaborative apps:** co-authoring, whiteboard apps and team meeting software.
- **Push notifications:** social network, email, game, travel alert.
- **Real-time broadcasting:** live audio/video broadcasting, live captioning, translating, events/news broadcasting.
- **IoT and connected devices:** real-time IoT metrics, remote control, real-time status, and location tracking.
- **Automation:** real-time trigger from upstream events.

For your wind turbine use case, the communication layer between the ADT wind turbine data and HoloLens 2 uses the Azure SignalR service and a SignalR client embedded in the HoloLens 2 app.