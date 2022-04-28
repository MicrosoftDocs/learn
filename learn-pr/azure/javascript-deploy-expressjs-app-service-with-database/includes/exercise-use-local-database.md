Run a local MongoDB server to develop your data application. 

## Start a local database 

Select a process based on your operating system.

# [Windows - Cosmos DB emulator](#tab/windows)

1. [Download](https://aka.ms/cosmosdb-emulator) and install the Cosmos DB emulator. You may need to restart your computer.
1. Find the **Azure Cosmos DB Emulator** and start it. When it is started, it appears in the System tray. 
1. In the System tray, open the emulator and select **Open Data Explorer**.
1. In the emulator, select the **Quickstart** tab and copy the **Primary Connection String**. 
1. Paste this into the `.env` file for the **MONGODB_URI_CONNECTION_STRING** variable.

# [macOS/Linux - MongoDB dev container](#tab/macos-linux)

1. In Visual Studio Code, select <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> to open the command palette.
1. Search for **Remote-Containers: Reopen in Container**. 
1. Wait until the web and database containers are started and the integrated terminal shows the container's prompt.
1. 

---

## Check your work