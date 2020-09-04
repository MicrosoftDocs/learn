You're a Node.js developer at Tailwind Traders. Knowing how to set up a new Node.js project is an important skill to have. Setup includes generating a manifest file and creating some common scripts that you're likely to use throughout the project lifecycle.

## Set up a new Node.js project

1. Open a terminal window.

1. Clone the `https://github.com/MicrosoftDocs/node-essentials/` repo by running this command:

   ```bash
   git clone https://github.com/MicrosoftDocs/node-essentials/
   ```

1. Go to your files by running this command:

   ```bash
   cd node-essentials/node-dependencies/3-exercise-package-json
   ```

   You should now have access to these files:

   ```bash
   -| src/
   ---| index.js
   ```

1. Run the following command to initialize a Node.js project:

    ```bash
    npm init -y
    ```

   This command will generate a package.json file. It should look something like this one:

    ```json
    {
      "name": "",
      "version": "1.0.0",
      "description": "",
      "main": "script.js",
      "dependencies": {},
      "devDependencies": {},
      "scripts": {
        "test": "echo \"Error: no test specified\" && exit 1"
      },
      "keywords": [],
      "author": "",
      "license": "ISC"
    }
    ```

1. Add these values:

    - `name`. Enter `tailwind-trader-api`.
    - `description`. Enter `An HTTP API that will manage items from Tailwind Traders database`.
    - `main`. Enter `index.js`.
    - `keywords`. Enter `api, database`.
    - `author`. Enter `Sam`.

   Your package.json should now look like this code:

    ```json
    {
      "name": "Tailwind-trader-API",
      "version": "1.0.0",
      "description": "An HTTP API that will fetch items from Tailwind Traders database",
      "main": "index.js",
      "dependencies": {},
      "devDependencies": {},
      "scripts": {
        "test": "echo \"Error: no test specified\" && exit 1"
      },
      "keywords": ["api", "database"],
      "author": "Sam",
      "license": "ISC"
    }
    ```

1. Add the following entry to the `scripts` section:

   ```json
   "start": "node ./src/index.js",
   ```

1. Open src/index.js and add the following code to it:

   ```javascript
   console.log('Welcome to this application');
   ```

1. The previous entry will define how the project starts. You can now start it by running this command:

   ```bash
   npm start
   ```

   You should see this output:

   ```output
   Welcome to this application
   ```

Your `start` action is working fine. You have a good file structure that you can build upon as your project grows larger. 
