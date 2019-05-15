// Include packages
var express = require('express'), http = require('http');
var bodyParser = require('body-parser')
var mongoose = require('mongoose');
var app = express();

// Start node app listening
var server = http.createServer(app);
server.listen(8000);
server.on('error', function (err) {
  console.log(err);
})

app.use(express.static(__dirname));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}))

// Create the message model for to store messages
var Message = mongoose.model('Message',{
  name : String,
  message : String
})

// Cosmos DB MongoDB connection string
var dbUrl = '<add connection string here>';

// Set networking timeouts
dbUrl = dbUrl + '&ServerSelectionTimeoutMS=5000'; 

// Set options
const options = {
  dbName: 'chat-app',
  useNewUrlParser: true,
  reconnectTries: Number.MAX_VALUE, // Never stop trying to reconnect
  reconnectInterval: 500, // Reconnect every 500ms
  connectTimeoutMS: 5000, // Give up initial connection after 5 seconds
  socketTimeoutMS: 5000 // Close sockets after 5 seconds of inactivity
}

// Connect to MongoDB 
mongoose.connect( dbUrl, options )
  .then(() => console.log('Connection to MongoDB successful'));

// Get all messages from the database
app.get('/messages', (req, res) => {
  Message.find({})
    .then(messages => {
      res.send(messages);
      console.log('Messages Refreshed');
    });
  });

// Save a message
app.post('/messages', (req, res) => {
  var message = new Message(req.body);
  message.save()
    .then( () => {
      res.sendStatus(200);
      console.log('Message Posted');
    });
});

// Delete all messages from the database
app.post('/deleteall', (req, res) => {
  Message.deleteMany({})
    .then( () => {
      res.sendStatus(200);
      console.log('Messages Deleted');
    });
});

// Build with: npm build
// Execute the app in shell with: npm start

// Transient errors to handle
//
//   MongoError
//   MongoNetworkError