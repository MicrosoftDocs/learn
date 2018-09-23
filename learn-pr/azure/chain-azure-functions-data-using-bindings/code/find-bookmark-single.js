module.exports = function (context, req) {

    if (req.query.id || (req.body && req.body.id)) {
        
        var bookmark = context.bindings.bookmark
        if(bookmark){
             context.res = {
                body: { "URL": bookmark.URL },
                headers: {
                'Content-Type': 'application/json'
                }
            };
        }
        else {
           
            context.res = {
                status: 404,
                body : "No bookmarks found",
                headers: {
                'Content-Type': 'application/json'
                }
            };
        }
    }
    else {
        context.res = {
            status: 400,
            body: "Please pass a value for id on the query string or in the request body"
        };
    }

    context.done();
};