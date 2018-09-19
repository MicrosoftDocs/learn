module.exports = function (context, req) {

    if ((req.body && req.body.id) && (req.body && req.body.url)) {
        var bookmark = context.bindings.bookmark
        if(bookmark){
             context.res = {
                status: 422,
                body : "Bookmark already exists.",
                headers: {
                'Content-Type': 'application/json'
                }
            };
        }
        else {
           
           // Create a JSON string of our bookmark.
            var bookmarkString = JSON.stringify({ 
                id: req.body.id,
                URL: req.body.url
            });

            // Write this bookmark to our database.
            context.bindings.newbookmark = bookmarkString;

            // Push this bookmark onto our queue for further processing.
            context.bindings.newmessage = bookmarkString;

            // Tell the user all is well.
            context.res = {
                status: 200,
                body : "bookmark added!",
                headers: {
                'Content-Type': 'application/json'
                }
            };
        }
    }
    else {
        context.res = {
            status: 400,
            body: "Please pass id and url parameters in the request body",
            headers: {
            'Content-Type': 'application/json'
            }
        };
    }

    context.done();
};