module.exports = function (context, myQueueItem) {
    context.log('Processing queue message', myQueueItem);

    let https = require ('https');

    // Replace the accessKey string value with your valid access key.
    let accessKey = '<YOUR ACCESS CODE HERE>';

    // Replace [region], including square brackets, in the uri variable below. 
    // You must use the same region in your REST API call as you used to obtain your access keys.
    // For example, if you obtained your access keys from the northeurope region, replace 
    // "westus" in the URI below with "northeurope".
    let uri = '[region].api.cognitive.microsoft.com';
    let path = '/text/analytics/v2.0/sentiment';

    let response_handler = function (response) {
        let body = '';

        response.on ('data', function (chunk) {
            body += chunk;
        });

        response.on ('end', function () {
            let body_ = JSON.parse (body);

            // Even though we send and receive a documents array from the Text Analytics API, 
            // we only ever pass one document in the array.
            if (body_.documents && body_.documents.length == 1) {
                let score = body_.documents[0].score;
                
                // Create a message that contains the original message we received and 
                // the sentiment score returned by Text Analytics API.
                let messageWithScore = JSON.stringify({ 
                    originalMessage: myQueueItem,
                    score: score
                });

                // Place message into appropriate output queue based on sentiment score.
                if (score > 0.8) {
                    context.log ("Positive message arrived");
                    context.bindings.positiveFeedbackQueueItem = messageWithScore;
                } else if (score < 0.3) {
                    context.log ("Negative message arrived");
                    context.bindings.negativeFeedbackQueueItem = messageWithScore;
                } else {
                    context.log ("Neutral message arrived");
                    context.bindings.neutralFeedbackQueueItem = messageWithScore;
                }
            } 
            let body__ = JSON.stringify (body_, null, '  ');
            context.log (body__);
            context.done();
            return;
        });

        response.on ('error', function (e) {
            context.log ('Error: ' + e.message);
            context.done();
            return;
        });    
    };

    let get_sentiments = function (documents) {
        let body = JSON.stringify (documents);

        let request_params = {
            method : 'POST',
            hostname : uri,
            path : path,
            headers : {
                'Ocp-Apim-Subscription-Key' : accessKey,
            }
        };

        let req = https.request (request_params, response_handler);
        req.write (body);
        req.end ();
        
    }

    // Create a documents array with one entry. 
    let documents = { 'documents': [
        { 
            'id': '1', 
            'language': 'en', 
            'text': myQueueItem 
        },
    ]};

    get_sentiments (documents);
        
};