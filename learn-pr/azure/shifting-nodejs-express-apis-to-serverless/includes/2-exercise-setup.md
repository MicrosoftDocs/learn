Let's start by getting the code and setting up the development environment. Follow these steps to prepare the code.

1. Clone this repository
1. Install the npm packages
1. Build the Node Express and the Angular code

   ```bash
   git clone https://github.com/johnpapa/express-to-functions.git
   cd express-to-functions
   npm install
   npm run node-ng:build
   ```

1. Make a copy of the _env.example_ file named _.env_, in the root of the project. It should contain the following code.

_.env_

```
NODE_ENV=development
PORT=7070
WWW=./
```

> Environment Variables: Applications may have very important environment variables located in the root in _.env_ file. This file is not checked into GitHub because it may contain sensitive information.
