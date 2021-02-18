We'll use a starter project to allow us to get to writing code as quickly as possible. The starter contains the minimum needed to start developing a React application using Snowpack: 2 files and 2 empty directories.

## Clone the repository and install packages

1. Open a terminal or command window and run the following commands:

    ```bash
    # Linux or macOS
    git clone https://github.com/MicrosoftDocs/mslearn-react
    cd mslearn-react/code/0-starter

    # Windows
    git clone https://github.com/MicrosoftDocs/mslearn-react
    cd mslearn-react\code\0-starter
    ```

1. Install the required packages by using the following command in the same terminal or command window:

    ```bash
    npm install
    ```

1. Open the directory in Visual Studio Code by running the following command:

    ```bash
    code .
    ```

## Explore the starter

As mentioned earlier, the starter has the minimum files and folders needed. Let's explore the different folders and files:

- **package.json** contains the list of packages and scripts
  - Packages:
    - **React** for React
    - **ReactDOM** to mount our application inside the browser
  - Scripts:
    - **dev** to run the development server from Snowpack
      - Virtually builds all JavaScript and HTML files
      - Hosts and automatically restarts our server as files are changed
    - **build** to generate production files for deployment
- **snowpack.config.json** contains the core configuration for Snowpack
  - **mount** creates two virtual directories for our Snowpack server
    - **public** contains all static files (HTML, CSS, images, etc.), and is hosted as **/**
    - **src** contains all **JSX** and associated React files, and is hosted as **dist**
- **public** to contain all static files
- **src** to contain all React files
