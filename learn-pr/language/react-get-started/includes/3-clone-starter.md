We'll use a starter project so we can begin writing code quickly. The starter contains the minimum structure we need to start developing a React application by using Snowpack: 
* Two files
* Two empty directories

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

Let's explore the folders and files in the starter project:

- **package.json** contains the list of packages and scripts:
  - Packages:
    - **React** for React
    - **ReactDOM** to mount our application inside the browser
  - Scripts:
    - **dev** to run the development server from Snowpack: 
      - It virtually builds all JavaScript and HTML files.
      - It hosts and automatically restarts the server as files are changed.
    - **build** to generate production files for deployment
- **snowpack.config.json** contains the core configuration for Snowpack.
  - **mount** creates two virtual directories for our Snowpack server.
    - **public** contains all static files (such as HTML, CSS, and images). It's hosted as `/`.
    - **src** contains all JSX files and associated React files. It's hosted as `dist`.
- **public** contains all static files.
- **src** contains all React files.
