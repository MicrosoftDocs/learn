## Introduction

Fast response to external events is the most important function of real-time embedded applications. However, many applications must also perform certain activities at predetermined intervals of time.

Application timers enable applications to execute application functions at specific intervals. It's also possible for an application timer to expire only once. This type of timer is called a one-shot timer, while repeating interval timers are called periodic timers. Each application timer is a public resource.

## Application timer attributes

Every application timer must have the following items.

| Attribute | Description |
|--- | ------ |
| Control block | Contains essential system information. |
| Timer name | Primarily used for identification purposes. |
| Expiration function | Executed when the timer expires.|
| Expiration input | A value that is passed to the expiration function, which is for the developer to use. |
| Initial timer ticks | Contains the initial number of timer ticks for the timer expiration. A related attribute specifies the number of timer ticks for all timer expirations after the first. |
| Reschedule timer ticks | Specifies whether the application timer is automatically activated at creation, or whether it's created in an inactive state that would require a thread to start it. |

Initial timer tick values range from 1 to 0xFFFFFFFF, and reschedule timer tick values range from 0 to 0xFFFFFFFF.

Application timers are similar to interrupt service routines (ISRs), except the actual hardware implementation (usually a single periodic hardware interrupt is used) is hidden from the application. Applications use such timers to perform time-outs, periodic operations, or watchdog services. Just like ISRs, application timers most often interrupt thread execution. Unlike ISRs, however, application timers can’t interrupt each other.

We'll use application timers in ProjectAnalyze to display statistical summaries at periodic intervals.

## One-shot timer

When a one-shot timer is created, it's immediately activated. In the following example, it will expire in 50 timer ticks, and then it will deactivate.

```c
TX_TIMER    my_timer;
UINT        status;
:
status = tx_timer_create
            (&my_timer, "one_shot_timer",
             one_shot_timer_function, 0x12,
             50, 0, TX_ACTIVATE);
```

## Recurring timer

When a recurring timer in this example is created, it's immediately activated. It will first expire in 150 timer ticks, and then it will expire every 200 timer ticks thereafter. Each time the timer expires, it invokes the timer function, in this case the `recurring_timer_function`.

```c
TX_TIMER    my_timer;
UINT        status;
:
status = tx_timer_create
            (&my_timer, "recurring_timer",
             recurring_timer_function, 0x34,
             150, 200, TX_ACTIVATE);
```

### Key to terms

- `&my_timer`: pointer to the application timer control block (TCB) structure
- `recurring_timer`: pointer to a string with the application timer name
- `recurring_timer_function`: application timer's entry function
- `0x34`: application timer entry function parameter to be used by the developer
- `150`: parameter specifying the number of timer ticks for the first timer expiration
- `200`: parameter specifying the number of timer ticks for subsequent timer expirations
- `TX_ACTIVATE`: specifies that the timer will be activated immediately upon creation

Following is a complete list of all application timer services:

- `tx_timer_activate`
- `tx_timer_change`
- `tx_timer_create`
- `tx_timer_deactivate`
- `tx_timer_delete`
- `tx_timer_info_get`
- `tx_timer_performance_info_get`
- `tx_timer_performance_system_info_get`

For complete details on all ThreadX services, consult the [Azure RTOS ThreadX User Guide](/azure/rtos/threadx/about-this-guide).
