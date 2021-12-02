Slow and failed responses are one of the biggest frustrations for website users, as you know from your own experience. So, it's essential to address the issues.

## Triage

 -  First, does it matter? If a page is always slow to load, but only 1% of your site's users ever have to look at it, maybe you have more important things to think about. On the other hand, if only 1% of users open it, but it throws exceptions every time, that might be worth investigating. Use the impact statement (affected users or % of traffic) as a general guide but be aware that it isn't the whole story. Gather other evidence to confirm. Consider the parameters of the issue. If it's geography-dependent, set up [availability tests](/azure/application-insights/app-insights-monitor-web-app-availability) including that region: there might be network issues in that area.

## Diagnose slow page loads

 -  Where is the problem? Is the server slow to respond, is the page long, or does the browser have to do much work to display it? Open the Browsers metric blade. The segmented display of browser page load time shows where the time is going.
    
     -  If Send Request Time is high, the server responds slowly, or the request is a post with much data. Look at the [performance metrics](/azure/azure-monitor/azure-monitor-app-hub) to investigate response times.
     -  Set up [dependency tracking](/azure/azure-monitor/app/asp-net-dependencies) to see whether the slowness is because of external services or your database.
     -  If Receiving Response is predominant, your page and its dependent parts - JavaScript, CSS, images, and so on (but not asynchronously loaded data) are long. Set up an [availability test](/azure/application-insights/app-insights-monitor-web-app-availability) and be sure to set the option to load dependent parts. When you get some results, open the detail of a result, and expand it to see the load times of different files.
     -  High Client Processing time suggests scripts are running slowly. If the reason isn't clear, consider adding some timing code and sending the times in track metrics calls.

## Improve slow pages

 -  There's a web full of advice on improving your server responses and page load times, so we won't try to repeat it all here. Here are a few tips that you probably already know about to get you thinking:
    
     -  Slow loading because of large files: Load the scripts and other parts asynchronously. Use script bundling. Break the main page into widgets that load their data separately. Don't send plain old HTML for long tables: use a script to request the data as JSON or another compact format, then fill the table in place. There are remarkable frameworks to help with all of it. (They also involve great scripts)
     -  Slow server dependencies: Consider the geographical locations of your components. For example, if you use Azure, ensure the web server and the database are in the same region. Do queries retrieve more information than they need? Would caching or batching help?
     -  Capacity issues: Look at the server metrics of response times and request counts. If response times peak disproportionately with peaks in request counts, your servers are likely stretched.
