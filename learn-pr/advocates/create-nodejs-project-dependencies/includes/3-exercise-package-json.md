As a Node.js developer on Tailwind Traders, learning how to set up a new Node.js project becomes an important skill to have. Setup includes generating a manifest file but also be able to create some common scripts that you are likely to use throughout the project lifecycle to manage it.

## Set up a new Node.js project

Open up a terminal window.

1. Clone the following repo `https://github.com/MicrosoftDocs/node-essentials/` by typing the command:

   ```bash
   git clone https://github.com/MicrosoftDocs/node-essentials/
   ```

1. Navigate to your files by typing the following command:

   ```bash
   cd node-essentials/node-dependencies/3-exercise-package-json
   ```

1. You should now have access to the following files:

   ```bash
   -| src/
   ---| index.js
   ```

1. Type the following command to initialize a Node.js project:

    ```bash
    npm init -y
    ```

   This command will generate a `package.json` file. It should look something like this:

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

1. Fill out the following values like so:

    - `name`, give it the value `tailwind-trader-api`
    - `description`, fill in the following description `An HTTP API that will manage items from Tailwind Traders database`
    - `main`, fill in `index.js`.
    - `keywords`, fill in the following `api`, `database`
    - `author`, fill in `Sam`

   Your `package.json` should now look like this:

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

1. Open up `src/index.js` and place the following code inside of it:

   ```javascript
   console.log('Welcome to this application');
   ```

   The above entry will define how the project is started up. You can now start it up by typing the following command:

   ```bash
   npm start
   ```

   You should see the following output:

   ```output
   Welcome to this application
   ```

Your `start` action is working fine. You have a good file structure that you can build upon as your project grows larger. 
