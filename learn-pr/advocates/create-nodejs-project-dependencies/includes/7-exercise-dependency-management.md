Tailwind Traders has asked you to work on an app that has some outdated dependencies. The app is small and has only a couple of dependencies. Updating it should be straightforward. See if you can update the app to take advantage of the latest features. While you're at it, if you find any vulnerabilities, fix them.

## Upgrade app dependencies

1. Clone `https://github.com/MicrosoftDocs/node-essentials/` by running this command:

   ```bash
   git clone `https://github.com/MicrosoftDocs/node-essentials/`
   ```

1. Go to your files by running this command:

   ```bash
   cd node-essentials/node-dependencies/7-exercise-dependency-management
   ```

1. Install the dependencies by running this command:

   ```bash
   npm install
   ```

1. Open the index.js file. It should look like this file:

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

   This code pulls data from a REST API by using the `node-fetch` library. It then processes the response by sorting it and taking the top three results by using the `lodash` library. The result is stored in a file.

1. Look at the `dependencies` section in the package.json file. It should look like this code:

   ```json
   "lodash": "^1.1.0",
   "node-fetch": "^1.0.2"
   ```

1. Run this command to see what dependencies are outdated:

   ```bash
   npm outdated
   ```

   The output should look something like the following output. You might see different values in the `Latest` column.

   ```output
   Package       Current    Wanted    Latest    Location
   lodash        1.1.0      1.3.1     4.17.19   lock-test
   node-fetch    1.0.2      1.7.3     2.6.0     lock-test
   ```

   The `Current` column tells you what version you currently have. The `Wanted` column tells you the latest minor version. The `Latest` column tells you the most recent version. You might see a different value here. Finally, the `Location` column tells you the location of the dependency.

1. You can, with some level of confidence, update to the `Wanted` version. Doing so will ensure the dependencies get the latest features and patches in that major version. Run the following command:

   ```bash
   npm update
   ```

   Your output should look something like this output:

   ```output
   + lodash@1.3.1
   + node-fetch@1.7.3
   added 1 package from 1 contributor, updated 2 packages and audited 6 packages in 0.514s
   found 4 vulnerabilities (2 low, 2 high)
   ```

   The output states that your project dependencies have been updated.

   At this point, you've upgraded the dependencies as far as the patterns in your package.json will allow. You can either install the latest version by running `npm install <name of package>@<known latest version>` or use the `latest` keyword: `npm install <name of package>@latest`.

1. In the terminal, run this command:

   ```bash
   npm install node-fetch@latest lodash@latest
   ```

   Your output should look something like this output:

   ```output
   + node-fetch@2.6.0
   + lodash@4.17.19
   ```

   Your results might be slightly different. The versions listed should correspond to the latest available versions of the packages.

Congratulations. You've upgraded the two dependencies in your app. Well done!
