## Introduction

**Event Flags Groups** provide a powerful tool for thread synchronization. Any thread can *set*, *clear* or retrieve Event flags. Threads can suspend while waiting to retrieve or *get* some combination of event flags.

An event flags group consists of 32 single-bit event flags, as illustrated in the following image:

:::image type="content" alt-text="Diagram that illustrates event flags arranged in groups of 32 bits." source="../media/event-flag-groups.svg" loc-scope="Azure":::

Threads can operate on all 32 event flags in a group simultaneously. To set or clear event flags, we use the `tx_event_flags_set` service and we get or retrieve them with the `tx_event_flags_get` service.

Setting or clearing event flags is performed with a logical AND or OR operation between the current event flags group and the new specified event flags. The user specifies the type of logical operation (either AND or OR) in the call to the `tx_event_flags_set` service.

There are similar logical options for getting event flags. A get request can specify that all specified event flags are required (a logical AND). Alternatively, a get request can specify that any of the specified event flags satisfy the request (a logical OR). The user specifies the type of logical operation in the `tx_event_flags_get` call.

Event flags that satisfy a get request are cleared if the request specifies either of the options `TX_OR_CLEAR` or `TX_AND_CLEAR`. The flag values remain unchanged when you use the `TX_AND` or `TX_OR` options in a get request.

Each event flags group is a public resource. ThreadX imposes no constraints as to how an event flags group can be used.

An application usually creates event flags groups during initialization (that is, in the `tx_application_define` function), but this operation can be done during runtime. At the time of their creation, all event flags in the group are initialized to zero. There's no limit to the number of event flags groups an application may use.

Application threads can suspend while attempting to get any logical combination of event flags from a group. Immediately after one or more flags of a group have been set, ThreadX reviews the get requests of all threads suspended on that event flags group. All the threads whose get requests were satisfied by the set operation are resumed.

In this module, we investigate event flags groups by first discussing how to set flags. After learning how to set flags, we'll look at how to retrieve or get flags. The name of the project in this module is ProjectEventFlags.
