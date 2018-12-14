module.exports = function (context, req) {
    
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

    context.done();
};