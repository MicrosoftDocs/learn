module.exports = function (context, req) {

    var bookmark = context.bindings.bookmark

    if(bookmark){
            context.res = {
            body: { "url": bookmark[0].url },
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
