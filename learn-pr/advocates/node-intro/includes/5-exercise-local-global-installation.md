As a Node.js developer on Tailwind Traders, learning how to install and uninstall dependencies is an essential skill to have to extend your application with additional capabilities.

## Global installation

Global installations are for installing libraries that have executable files that you want to use often.

1. Type the following to install the library `http-server`.

   ```bash
   npm install -g http-server
   ```

   > [!NOTE]
   > You might need to elevated permissions to run the above command. Therefore run it with `sudo npm install -g http-server`, if you are on Linux or Mac.

1. Verify the installation has succeeded by typing:

   ```bash
   http-server -p 5000
   ```

    You should get an output like so:

    ```output
    Starting up http-server, serving ./
    Available on:
      http://127.0.0.1:5000
      http://192.168.1.102:5000
      http://10.10.106.76:5000
    Hit CTRL-C to stop the server
    ```

1. Remove installation with the following command:

    ```bash
    npm uninstall -g http-server
    ```

    > [!NOTE]
    > You might need to elevated permissions to run the above command. Therefore run it with `sudo npm uninstall -g http-server`, if you are on Linux or Mac.

## NPX

You will execute the same library `http-server` but this time you will use NPX. 

1. Type the following command:

    ```bash
    npx http-server -p 5000
    ```

   You should get an output like so:

    ```bash
    npx: installed 23 in 1.98s
    Starting up http-server, serving ./
    Available on:
      http://127.0.0.1:5000
      http://192.168.1.102:5000
      http://10.10.106.76:5000
    Hit CTRL-C to stop the server
    ```

   Quit the above program execution.

1. Verify that `http-server` has not been persisted on your system by typing:

   ```bash
   http-server
   ```

   You should get an output like so:

   ```output
   command not found: http-server
   ```

Congrats, you've learned how to install a library globally but also to use tool NPX.