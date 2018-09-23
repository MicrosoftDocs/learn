module.exports = function (context, req) {

    if (req.query.key || (req.body && req.body.key)) {

        // The SQL query we defined with this input binding will return a collection
        // of zero or more documents.
        var bookmarks = context.bindings.bookmarks;

        // Let's see how many documents we get back. 
        var totalBookmarks = bookmarks.length;
        context.log('Found '+ totalBookmarks +' bookmarks');

        if(totalBookmarks === 0){
            context.res = {
                status: 404,
                body : "No bookmarks found",
                headers: {
                'Content-Type': 'application/json'
                }
            };
        }
        else {
            context.res = {
                body: bookmarks,
                headers: {
                'Content-Type': 'application/json'
                }
            };
        }
    }
    else {
        context.res = {
            status: 400,
            body: "Please pass a key on the query string or in the request body"
        };
    }

    context.done();
};