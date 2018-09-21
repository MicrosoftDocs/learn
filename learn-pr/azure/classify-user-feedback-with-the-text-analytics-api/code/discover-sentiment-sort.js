module.exports = function (context, myQueueItem) {
    context.log('Processing queue message', myQueueItem);

    let https = require ('https');

    // Replace the accessKey string value with your valid access key.
    let accessKey = '<YOUR ACCESS KEY HERE>';

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