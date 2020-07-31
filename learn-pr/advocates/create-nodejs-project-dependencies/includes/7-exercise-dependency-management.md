Tailwind Traders has tasked you with working on an app with some outdated dependencies. The app is fairly small and only has a couple of dependencies. Updating it should be straightforward. See if you can update the app to take advantage of the latest features and if you find any vulnerabilities fix them while you are at it.

## Upgrading the app dependencies

1. Clone the following `https://github.com/MicrosoftDocs/node-essentials/` by typing the following command:

   ```bash
   git clone `https://github.com/MicrosoftDocs/node-essentials/`
   ```

1. Navigate to your files by typing the following command:

   ```bash
   cd node-essentials/node-dependencies/7-exercise-dependency-management
   ```

1. Install the dependencies with the following command:

   ```bash
   npm install
   ```

1. Open up the `index.js` file. It should look like so:

   ```javascript
   const fetch = require('node-fetch')
   const _ = require('lodash');
   const path = require('path');
   const fs = require('fs');

   async function run() {
     const response = await fetch("https://dev.to/api/articles?state=rising");
     const json = await response.json();
     const sorted = _.sortBy(json, ["public_reactions_count"], ['desc']);
     const top5 = _.take(sorted, 3);

     const filePrefix = new Date().toISOString().split('T')[0];
     fs.writeFileSync(path.join(__dirname, `${filePrefix}-feed.json`), JSON.stringify(top5, null, 2));
    }

    run();
   ```

   The above code is pulling some data from a REST API using the `node-fetch` library. Then it goes on to process the response by sorting it and taking the top three results using the library `lodash`. The result is stored in a file.

1. Have a look at the `package.json` file and locate the `dependencies` section. It should look like so:

   ```json
   "lodash": "^1.1.0",
   "node-fetch": "^1.0.2"
   ```

   Type the following command to see what dependencies are outdated:

   ```bash
   npm outdated
   ```

   The output should look something like this. There might be a slight variation on what number is listed as the `Latest` depending on when this module is taken.

   ```output
   Package       Current    Wanted    Latest    Location
   lodash        1.1.0      1.3.1     4.17.19   lock-test
   node-fetch    1.0.2      1.7.3     2.6.0     lock-test
   ```

   The above tells you what version you are currently on `Current`. It also tells you what the latest minor version is in the `Wanted` column. Thirdly it states the latest version there is in the `Latest` column. This may differ depending on when you take this module. Finally it tells you the location of the dependency.

1. You can, with a decent level of confidence, update to the `Wanted` version, it will ensure the dependencies get the latest features and patches in that major version. Type the following command:

   ```bash
   npm update
   ```

   You should get an output looking something like this:

   ```output
   + lodash@1.3.1
   + node-fetch@1.7.3
   added 1 package from 1 contributor, updated 2 packages and audited 6 packages in 0.514s
   found 4 vulnerabilities (2 low, 2 high)
   ```

   Above it states that your project dependencies have been updated.

1. At this point, you have upgraded the dependencies as far as the patterns in your `package.json` allows you. You can either install the latest version by specifically type `npm install <name of package>@<known latest version>` or use the *latest* keyword like so `npm install <name of package>@latest`.

1. In the terminal type the following command:

   ```bash
   npm install node-fetch@latest lodash@latest
   ```

   You should have gotten an output looking something like this:

   ```output
   + node-fetch@2.6.0
   + lodash@4.17.19
   ```

   Results may vary above depending on when this module is taken. The point is though that the listed versions above should correspond to the latest available versions of these two packages.

Congratulations you've managed to upgrade the two dependencies in your app. Well done!
