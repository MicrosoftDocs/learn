The first thing we need to create our model is data! We are going to use a the Bing Search service to scrape an image dataset to train our model. Then we are going to use a NodeJS app to create folders and save the scarped images to labeled folders.

We are going to look at the top 10 most endangered bird species for this project. However if you want to build a model to identify species in your backyard I recommend checking out the [NA Birds Dataset From Cornell](https://dl.allaboutbirds.org/nabirds)

## TODO ADD SANDBOX WIDGET HERE!

## Create Bing Search Api Azure Resource

- Go to [portal.azure.com](https://portal.azure.com/)
- Select "Create Resource"
- Select "AI + Machine Learning"
- Select "Bing Search v7"
- Complete the required fields
- Select "Create"
- When the deployment succeeds you will get a notification in the top right corner.
- Select "Go to resource"
- Select "Keys" from the left hand navigation for the resource.
- We will come back to the `Keys` when we are ready to call it from our App.

## Create App

We are now going to create a simple Node App to scrape our images.

- Install Node [here](https://nodejs.org/en/download/)
- Install VS Code [here](https://code.visualstudio.com/download)
- Open the terminal and run the following commands

```bash
mkdir ImageScraperApp
cd ImageScraperApp
npm init
```

- Hit enter and leave all the default settings for setting up the node app

- Install the packages needed and add '--save' to update the package.json file

```bash
npm install azure-cognitiveservices-imagesearch --save
npm install image-downloader --save
npm install ms-rest-azure --save
```

Lets open the app we created in vs code with the `code .` command in the terminal

- Create an 'index.js' file and add `console.log("hello world");` so we can test it
- Open the integrated terminal in VS Code `Terminal -> New Terminals`
- Run the below command to test the app

```bash
node index.js
```

## Add Logic to App

```javascript
"use strict";

var https = require("https");
var fs = require("fs");
var download = require("image-downloader");
// Replace the subscriptionKey string value with your valid subscription key.
const subscriptionKey = "addyourkeyhere";
// Verify the endpoint URI.  At this writing, only one endpoint is used for Bing
// search APIs.  In the future, regional endpoints may be available.  If you
// encounter unexpected authorization errors, double-check this host against
// the endpoint for your Bing Search instance in your Azure dashboard.
const host = "api.cognitive.microsoft.com";
const path = "/bing/v7.0/images/search";
```

```javascript
var searchAndSaveImages = (search) => {
  console.log("Searching images for: " + search);
  //set global to current search term

  let request_params = {
    method: "GET",
    hostname: host,
    path: path + "?q=" + encodeURIComponent(`yoga ${search} pose`),
    headers: {
      "Ocp-Apim-Subscription-Key": subscriptionKey,
    },
  };
  var req = https.request(request_params, (response) => {
    console.log("statusCode:", response.statusCode);
    let body = "";
    response.on("data", (d) => {
      body += d;
    });
    response.on("end", () => {
      let imageResults = JSON.parse(body);
      console.log(`Image result count: ${imageResults.value.length}`);
      if (imageResults.value.length > 0) {
        //create directory folder for current search term
        let rootDir = `./poses`;
        let searchDir = `${rootDir}/${search}`;
        let testDir = `${searchDir}/test`;
        let trainDir = `${searchDir}/train`;

        if (!fs.existsSync(rootDir)) {
          fs.mkdirSync(rootDir);
        }
        if (!fs.existsSync(searchDir)) {
          fs.mkdirSync(searchDir);
          fs.mkdirSync(testDir);
          fs.mkdirSync(trainDir);
        }
        //create count so we can split the results between test and train folder
        let count = 0;

        //save image results
        imageResults.value.forEach((imageResult) => {
          let destDir = count % 3 == 0 ? testDir : trainDir;
          let options = {
            url: imageResult.contentUrl,
            dest: `./${destDir}/${imageResult.imageId}.png`,
          };

          download
            .image(options)
            .then(({ filename, image }) => {
              console.log("File saved to", filename);
            })
            .catch((err) => {
              console.error(err);
            });
          count++;
        });
      } else {
        console.log("Couldn't find image results!");
      }
    });
    response.on("error", function (e) {
      console.log("Error: " + e.message);
    });
  });
  req.end();
};
```

```javascript
let main = () => {
  //yoga pose search term list
  var searchTermList = ["childs", "tree"];
  //loop search terms
  searchTermList.forEach((term) => {
    searchAndSaveImages(term);
  });
};

//check to make sure the subscription key was updated and kick off main func
if (subscriptionKey.length === 32) {
  main();
} else {
  console.log("Invalid Bing Search API subscription key!");
  console.log("Please paste yours into the source code.");
}
```

## Get Data
