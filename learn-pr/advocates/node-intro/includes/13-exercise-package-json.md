As a Node.js developer on Tailwind Traders, learning how to set up a new Node.js project becomes an important skill to have. Setup includes generating a manifest file but also be able to create some common scripts that you are likely to use throughout the project lifecycle to manage it.

## Setup a new Node.js project

Open up a terminal window. Create a directory `app` and subdirectory `src` and a file `index.js` in the subdirectory. Your project should now look like this:

```bash
--| app/
----| src/
------| index.js
```

Type the following command while placed in the `app` directory:

```bash
node init -y
```

This will generate a `package.json` file. It should look something like this:

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

Ensure to fill out the following values like so:

- `name`, give it the value `Tailwind trader API`
- `description`, fill in the following description `An HTTP API that will items from Tailwind Traders database`
- `main`, fill in `index.js`.
- `keywords`, fill in the following `api`, `database`
- `author`, fill in `Sam`

Your `package.json` should now look like this:

```json
{
  "name": "Tailwind trader API",
  "version": "1.0.0",
  "description": "An HTTP API that will items from Tailwind Traders database",
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

### Setup and run scripts

Now that you have a manifest file you can move on to set up some scripts that you will use throughout the lifetime of the project.

Before you go on to setup the scripts you need a test library.

1. Type the following command:

    ```bash
    npm install jest --save-dev
    ```

    This will install the test library Jest and an entry will be added in the `devDependencies` section of the `package.json` file.

1. Create the directory `lib` and under it the sub directory `__tests__`. In the directory `lib/` create a file `example.js`. Finally in the `__tests__` directory create a file `example.js`. Your directory structure should now look like so:

    ```bash
    --| app/
    ----| src/
    ------| index.js
    ------| lib/
    --------| example.js
    --------| __tests__/
    ----------| example.js
    ```

1. In `package.json` locate the `scripts` section and give it the following content:

    ```json
    "scripts": {
      "start": "node ./src/index.js",
      "test": "jest",
      "test:watch": "jest --watchAll"
    }
    ```

    You've now setup the our Node.js project with the actions `start`, `test` and `test:watch`.

1. Add the following code to `example.js`:

    ```javascript
    module.exports = (lhs, rhs) => lhs + rhs;
    ```

1. Add the following code to `__tests__/example.js`:

    ```javascript
    const calculator = require('../example');

    describe('a test suite', () => {
      test('should calculate correctly', () => {
        expect(calculator(1,2)).toBe(3);
      })
    })
    ```

1. Type the following command in the terminal

    ```bash
    npm test
    ```

    It should give you the following output:

    ```output
     PASS  src/lib/__tests__/example.js
      a test suite
        ✓ should calculate correctly (2ms)

    Test Suites: 1 passed, 1 total
    Tests:       1 passed, 1 total
    Snapshots:   0 total
    Time:        5.813s
    Ran all test suites.
    ```

    This executed all tests successfully.

1. Type the following command to invoke the `test:watch` task:

    ```bash
    npm run test:watch
    ```

    You should see the following output:

    ```output
    PASS  src/lib/__tests__/example.js
    a test suite
    ✓ should calculate correctly (3ms)

    Test Suites: 1 passed, 1 total
    Tests:       1 passed, 1 total
    Snapshots:   0 total
    Time:        1.53s, estimated 2s
    Ran all test suites.

    Watch Usage
     › Press f to run only failed tests.
     › Press o to only run tests related to changed files.
     › Press p to filter by a filename regex pattern.
     › Press t to filter by a test name regex pattern.
     › Press q to quit watch mode.
     › Press Enter to trigger a test run.
    ```

    Jest is still running at this point and is watching for changes made to any file.

All of our actions are working fine. You have a good file structure that you can build upon as your project grows larger. You also have an infrastructure in place for authoring and running tests.