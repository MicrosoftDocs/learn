Tailwind Traders loved your app on supporting the invoice department and digitizing their process. You got a feedback though that the department will need to upload a paper copy of an invoice. This is to complement the other form data a user will add via the web application. You need to build them a proof of concept that supports file uploads and find a way to store the uploaded files.

## Add file uploading capability to an Express app

In this exercise you will add code that supports uploading a file. You will download and configure the library `multer` to accomplish this goal.

1. Clone the repo at URL with the following command:

   ```bash
   git clone <REPO url>
   ```

   Now you have a good starter project. The project contains the product files and some starter application code. All you need to do is to fill in the missing parts.

1. Let's inspect the repo you just cloned. Type the following:

   ```bash
   cd <repo dir>
   ```

   The outline of the directory should look like so:

   ```bash
   -| app.js
   -| package.json
   -| test.txt
   ```

   The `package.json` file contains a dependency `express`. Type the following command in the terminal to install that:

   ```bash
   npm install
   ```

   `npm` reads from the `dependencies` section in our `package.json` and you should be ready to continue.

1. Time to inspect `app.js`. Open up said file. You should be seeing the following:

   ```javascript
   const express = require('express')
   const app = express()
   const port = 3000

   app.get('/', (req, res) => res.send('Hello World!'))
   app.post('/submit', function (req, res) {
     // handle file upload
   })

   app.get("/form", (req, res) => {
     res.type("html");
     res.send(`
       <html>
         <body>
           <form action="/submit" method="POST" enctype="multipart/form-data">
             <input type="text" name="name" />
             <input name="file" type="file">
             <button>Submit</button>
           </form>
         </body>
       </html>
     `);
   });

   app.listen(port, () => console.log(`Example app listening on port ${port}!`))
   ```

   Locate the code that starts with `app.get("/form")`. This route returns a form back to the user. Note how the `enctype` property is set to `multipart/form-data`. Additionally note how the form has an input element with type `file`. The form is set up to transfer files to backend.

1. Test out the application by typing the following command in the terminal:

   ```bash
   node app.js
   ```

   Open up a browser and navigate to `http://localhost:3000/form`. You should see the following being rendered:

   :::image type="content" source="../media/node-http-form-file.png" alt-text="Form withe a file input element":::

1. Install the library `multer` by typing the following in the terminal:

   ```bash
   npm install multer
   ```

1. Configure `multer` by adding the following code right after the row that states `const app = express()`:

   ```javascript
   let multer = require("multer");
   let upload = multer({ dest: "uploads/" });
   ```

   The above instructions will ensure that any uploaded files are written to the directory `uploads/` as seen from the root of the application.

   Next locate the part of the code that says:

   ```javascript
   app.post('/submit', function (req, res) {
     // implement
   })
   ```

   and replace it with:

   ```javascript
   app.post('/submit', upload.single('file'), function (req, res) {
    res.send(`Uploaded file: ${req.file.filename}`)
   })
   ```

   The above code has the code `upload.single('file')` as the second argument to `app.post()`. This means `multer` will look for upload data from a file input control with the name `file`.

1. Restart the application with the following command:

   ```bash
   node app.js
   ```

1. In your browser navigate to `http://localhost:3000/submit`. Now fill in some random value as text input and select the file `test.txt` from the app root. Your Web page should now look like this:

   :::image type="content" source="../media/node-http-form-file-filled-in.png" alt-text="Form file upload filled in":::

   Now click the `Submit` button.

1. In the app directory note how the `uploads` directory have been created and you have something like this showing:

   :::image type="content" source="../media/node-http-uploads.png" alt-text="Uploads directory in app with file":::

   This shows the upload worked and it also show the standard behavior of `multer` which is to upload files to a specified directory and give the file a unique name.

1. You've managed to get file upload to work. That's great. However, you might want to configure things like what the uploaded file should be named. `multer` is a highly configurable library and let's you do that. To change how you name the uploaded file, locate the following part of your code:

   ```javascript
   let upload = multer({ dest: "uploads/" });
   ```

   Replace the above code with the following:

   ```javascript
   let storage = multer.diskStorage({
     destination: function (req, file, cb) {
       cb(null, "./uploads");
     },
     filename: function (req, file, cb) {
       cb(null, file.originalname + "-" + Date.now());
     },
   });
   let upload = multer({ storage });
   ```

   Above you have defined a variable `storage` that is assigned the result of calling `multer.diskStorage()`. The mentioned method configures two things. First it specifies the upload directory to `./uploads`. Secondly it lets you decide how the uploaded file should be named. Let's have a closer look at that portion of the code:

   ```javascript
   filename: function (req, file, cb) {
     cb(null, file.originalname + "-" + Date.now());
   }
   ```

   Above you can see that the uploaded file will now get a combination of its original file name plus a `-` and the current time in milliseconds. 

1. Let's run this example by starting the app:

   ```bash
   node app.jss
   ```

   Followed by navigating to `http://localhost:3000/submit`. Select `test.txt` as the file to upload and click `Submit`. Now, look at the `uploads` directory. You should have something like this showing:

   :::image type="content" source="../media/node-http-uploads-config.png" alt-text="multer configure file name when uploading":::

   Note how the second file in the upload directory is the file we just uploaded and how it's uploaded file name differs from the first uploaded file.