You're a Node.js developer at Tailwind Traders. Knowing how to set up a new Node.js project is an important skill to have. Setup includes generating a manifest file and creating some common scripts that you're likely to use throughout the project lifecycle.

## Set up a new Node.js project

1. Open a terminal window.

2. Clone the `https://github.com/MicrosoftDocs/node-essentials/` repo by running this command:

   ```bash
   git clone https://github.com/MicrosoftDocs/node-essentials/
   ```

3. Change to the folder that has the cloned files for this exercise:

   ```bash
   cd node-essentials/node-dependencies/3-exercise-package-json
   ```

   In this folder, you should see a **src** subfolder with an **index.js** file:

   ```output
   -| src/
   ---| index.js
   ```

4. Run the following command to initialize a Node.js project:

    ```bash
    npm init -y
    ```

   This command generates a **package.json** file that looks similar to this example:

    ```json
    {
      "name": "<your project>",
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

5. Edit the package.json file and modify these property values:

    - `name`: "tailwind-trader-api"
    - `description`: "HTTP API to manage items from the Tailwind Traders database"
    - `main`: "index.js"
    - `keywords`: ["api", "database"]
    - `author`: "Sam"

   Your package.json file should now look like this code:

    ```json
    {
      "name": "tailwind-trader-api",
      "version": "1.0.0",
      "description": "HTTP API to manage items from the Tailwind Traders database",
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

6. In the `scripts` section, add this definition for the `start` action before the definition for the `test` action:

   ```json
   "start": "node ./src/index.js",
   ```

   Save your changes and close the package.json file.

7. Start your project with the `start` action by entering this command:

   ```bash
   npm start
   ```

   You should see this output:

   ```output
   Welcome to this application
   ```

You now have a good file structure that you can build upon as your project grows.
