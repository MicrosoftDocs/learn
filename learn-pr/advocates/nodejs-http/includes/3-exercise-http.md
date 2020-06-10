In this unit, you will create a Web application using the Node.js http module. You will also consume the application using a browser and through code.

## Create a Web app and consume it with a Web Browser

You will create a Web application that will serve requests at address `http://localhost:3000`. As part of handling the request, you will set a content header called `Content-Type` and return a static text string.

1. Create the file `app.js`.
1. Give the file the following content:

   ```javascript
   // app.js

   const http = require('http');
   const PORT = 3000;

   const server = http.createServer((req, res) => {
     res.writeHead(200, {'Content-Type': 'text/plain'});
     res.end('hello world');
   });

   server.listen(PORT, () => {
     console.log(`listening on port ${PORT}`)
   })
   ```

1. Next, start the server by opening up a terminal and type: 

    ```bash
    node app.js
    ```

1. The terminal should now output the following:

    ```output
    listening on port 3000
    ```

1. Open a browser and navigate to URL `http://localhost:3000`.

   The browser should now display the following:

   ```output
   hello world
   ```

## Consume a Web App with code

There are more ways to consume a web application than using a browser. You could use a client like cURL or code. You will for this exercise use the latter - through code. For this exercise, you will use the http module to make requests towards an endpoint and listen for the results. As part of handling the request you will need to listen to different events of the incoming stream `res`.

1. Create a file `client.js`.
1. Give the file the following content:

   ```javascript
   const options = {
     port: 3000,
     host: '127.0.0.1',
      method: 'GET'
   };

   http.request(options, (res) => {
     res.on('data', (chunk) => {
       console.log(`DATA: Chunk received: ${chunk}`)
     })

     res.on('end', () => console.log('END: no more data'));

     res.on('close', () => {
       console.log('CLOSE: Connection closed')
     })

     res.on('error', (err) => console.error(err.stack));
   });
   ```

1. Run the program by typing the following command in the terminal:

   ```bash
   node client.js
   ```

   You should get following results in the terminal:

   ```output
   DATA: Chunk received: Hello world
   END: no more data
   CLOSE: Connection closed
   ```

It's clear from the above output that event happens in the following order:

1. `data`, every time there is some new data to receive from the stream this event is raised.
1. `end`, this event is raised when the server has signaled that there is no more data
1. `close`, this event was raised finally when server and client closed their connection

## Summary

You've seen how you can build a web application that server requests. As part of that you have set a response header and sent back content. Furthermore you've written code to make web requests using code and the http module but also used a browser to do the same.
