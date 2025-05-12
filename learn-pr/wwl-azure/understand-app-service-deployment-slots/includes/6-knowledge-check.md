

## Multiple Choice
By default, all client requests to the app's production URL (`http://<app_name>.azurewebsites.net`) are routed to the production slot. One can automatically route a portion of the traffic to another slot. What is the default routing rule applied to new deployment slots?
(x) 0% {{Correct. By default, new slots are given a routing rule of `0%`.}}
( ) 10% {{Incorrect. By default, new slots are given a routing rule of `0%`.}}
( ) 20% {{Incorrect. By default, new slots are given a routing rule of `0%`.}}

## Multiple Choice
Some configuration elements follow the content across a swap (not slot specific), whereas other configuration elements stay in the same slot after a swap (slot specific). Which of the following settings are swapped?
( ) Publishing endpoints {{Incorrect. Publishing endpoints aren't swapped.}}
(x) WebJobs content {{Correct. WebJobs content is swapped.}}
( ) WebJobs schedulers {{Incorrect. WebJobs schedulers aren't swapped.}}