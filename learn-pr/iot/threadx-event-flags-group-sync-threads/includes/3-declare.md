## Introduction

An event flags group is declared with the `TX_EVENT_FLAGS_GROUP` data type and is defined with the `tx_event_flags_create` service. When defining an event flags group, you must specify its Control Block and the name of the event flags group. When created, all the event flags of a group are initialized to zero.

The following image shows the attributes of event flags groups:

:::image type="content" alt-text="Diagram of the attributes of an event flags group." source="../media/attributes.png" border="false" loc-scope="Azure":::

The following code illustrates how to use this service to create an event flags group. We give our event flags group the name **my_event_group**. If the variable status contains the return value `TX_SUCCESS`, it means that we've successfully created an event flags group.

```c
TX_EVENT_FLAGS_GROUP my_event_group;
UNIT status;

/* Create an event flags group */
status = tx_event_flags_create(&my_event_group,
                                "my_event_group_name");
/* If status equals TX_SUCCESS, my_event_group is ready for the get and set services. */
```

The `tx_event_flags_set` service sets or clears one or more event flags in an event flags group. If the set service is performed and sets one or more flags, the ThreadX scheduler checks whether there are any threads suspended for that event flags group. If there are other threads suspended for the resulting value of this group, then those threads are resumed.

The process of setting or clearing event flags depends on the `set_option`, which is a logical (bitwise) AND or OR operation. The following table lists set options and their descriptions:

| Set option | Description |
|:---:|:---:|
| `TX_AND` | The specified event flags are ANDed into the current event flags group; this option often is used to clear event flags in a group. |
| `TX_OR` | The specified event flags are ORed with the current event flags group. |

For example, suppose the current values of the event flags group is 0xF0C. If we want to clear all flags except flags 0, 4, and 8, we can specify the value 0x111 (that is, event flags 0, 4, and 8) and use the `TX_AND` option:

```c
TX_EVENT_FLAGS_GROUP my_event_group;
UNIT status;
:
:
/* Clear all event flags except 0, 4 and 8 */
status = tx_event_flags_set(&my_event_group, 0x111, TX_AND);

/* If status equals TX_SUCCESS, the event flags have been set and any suspended threads whose requests were satisfied have been resumed. */
```

:::image type="content" alt-text="Diagram of an event flags group that uses the TX_AND set option." source="../media/set-option-tx-and.svg" loc-scope="Azure":::

The new value of the event flags group is 0x100 because flag 8 is the only flag in common for the values 0xFF0C and 0x112. However, if the `TX_OR` option is used, the new event flags group value is 0xF1D.

Here's a code example of the set service using `TX_OR`:

```c
TX_EVENT_FLAGS_GROUP my_event_group;
UNIT status;
:
:
/* Set event flags 0, 4 and 8 */
status = tx_event_flags_set(&my_event_group, 0x111, TX_OR);

/* If status equals TX_SUCCESS, the event flags have been set and any suspended threads whose requests were satisfied have been resumed. */
```

Here's the result:

:::image type="content" alt-text="Diagram of an event flags group that uses the TX_OR set option." source="../media/set-option-tx-or.svg" loc-scope="Azure":::

The set service always succeeds because there's no suspending condition. However, the get service can cause suspension because the threads must wait for a certain condition, that is, the specified event flags group.

The `tx_event_flags_get` service retrieves or gets the specified event flags from the event flags group. A get request is satisfied if the specified flags have been set in the event flags group. The `wait_option` determines what action to take if the get request isn't satisfied. The process of satisfying a get request depends on the `get_option`, which is an AND or OR operation, as depicted in the following table:

| Get option | Description |
|:---:|:---:|
| `TX_AND` | **All** requested event flags must be set in the specified event flags group. |
| `TX_AND_CLEAR` | **All** requested event flags must be set in the specified event flags group; event flags that satisfy the request are cleared. |
| `TX_OR` | **At least one** requested event flag must be set in the specified event flags group. |
| `TX_OR_CLEAR` | **At least one** requested event flag must be set in the specified event flags group; all event flags that satisfy the request are cleared. |

If a get service succeeds, all threads proceed that have been suspended because they've been waiting for the specified event flags. If a get service doesn't succeed, all threads that have been waiting for the specified event flags continue to be suspended, based on one of the three wait options that has been selected, that is, `TX_WAIT_FOREVER`, `TX_NO_WAIT`, or some timeout value expressed in timer ticks.

Here's an example of a get service that uses the `TX_AND_CLEAR` option and a timeout value of 20 timer ticks:

```c
TX_EVENT_FLAGS_GROUP    my_event_group;
ULONG                   actual_events
UNIT                    status;

...
/* Retrieve event flags 0, 4 and 8 if they are all set. Also, if they are set they will be cleared.
   If the event flags are not set, this service suspends for a maximum of 20 timer ticks. */
status = tx_event_flags_get(&my_event_group, 0x111, 
                            TX_AND_CLEAR, &actual_events, 20);

/* If status equals TX_SUCCESS, actual_events contains the actual events obtained, and event flags 0, 4 and 8 have been cleared from the event flags group. */
```

In this example, we're trying to retrieve or get all the flags in the specified events (that is, 0x111) that appear in `my_event_group`. If all the specified flags are present in `my_event_group`, the following actions occur:

- All the threads that were suspended on 0x111 proceed.
- The flags 0x111 are cleared from `my_event_group`.

If one or more flags in the specified events (that is, 0x111) don't appear in `my_event_group`, the suspended threads continue to wait up to a maximum of 20 timer ticks.

The following image illustrates this scenario:

:::image type="content" alt-text="Diagram of an event flags group Get service that uses TX_AND_CLEAR." source="../media/get-tx-and-clear.svg" loc-scope="Azure":::

*All* the flags in the specified events (that is, 0x111) appear in `my_event_group`, so the get service is satisfied. The new value of `my_event_group` has the flags 0, 4, and 8 cleared.

The following image contains an example using the get service with `TX_OR`. In this example, only one flag in 0x222 needs to be present in `my_event_group`.

:::image type="content" alt-text="Diagram of an event flags group Get service that uses TX_OR." source="../media/get-tx-or.svg" loc-scope="Azure":::
