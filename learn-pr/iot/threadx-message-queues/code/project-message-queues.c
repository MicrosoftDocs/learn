/* ProjectMessageQueues.c

   Create three threads, one byte pool, and two message queues.
   The threads communicate with each other via the message queues.

   Your task is to modify this program so that four threads
   communicate with three queues. Among other items, you need to
   create an Important thread and ImportantQueue */

   /****************************************************/
   /*    Declarations, Definitions, and Prototypes     */
   /****************************************************/

#include   "tx_api.h"
#include   <stdio.h>

#define     STACK_SIZE         1024
#define     BYTE_POOL_SIZE     9120
#define     NUMBER_OF_MESSAGES 100
#define     MESSAGE_SIZE       TX_1_ULONG
#define     QUEUE_SIZE         NUMBER_OF_MESSAGES*MESSAGE_SIZE*sizeof(ULONG)

/* Define the ThreadX object control blocks...  */
TX_THREAD     Dispatcher, Urgent, Routine;
TX_BYTE_POOL  my_byte_pool;
TX_TIMER      stats_timer;
TX_QUEUE      UrgentQueue, RoutineQueue;

/* Define the counters used in the project application...  */
ULONG  Dispatcher_counter = 0, Urgent_counter = 0, Routine_counter = 0;
ULONG  DispatcherMessage = 0, UrgentMessage, RoutineMessage;

/* Define prototypes.  */
void    Dispatcher_entry(ULONG thread_input);
void    Urgent_entry(ULONG thread_input);
void    Routine_entry(ULONG thread_input);
void    print_stats(ULONG);

/****************************************************/
/*               Main Entry Point                   */
/****************************************************/

/* Define main entry point.  */
int main()
{
    /* Enter the ThreadX kernel.  */
    tx_kernel_enter();
}

/****************************************************/
/*             Application Definitions              */
/****************************************************/

/* Define what the initial system looks like.  */

void    tx_application_define(void* first_unused_memory)
{
    CHAR* Dispatcher_stack_ptr, * Urgent_stack_ptr, * Routine_stack_ptr,
        * UrgentQueue_ptr, * RoutineQueue_ptr;

    /* Create a memory byte pool from which to allocate the thread stacks. */
    tx_byte_pool_create(&my_byte_pool, "my_byte_pool",
        first_unused_memory, BYTE_POOL_SIZE);

    /* Allocate the stack for Dispatcher thread */
    tx_byte_allocate(&my_byte_pool, (VOID**)&Dispatcher_stack_ptr,
        STACK_SIZE, TX_NO_WAIT);

    /* Create the Dispatcher thread */
    tx_thread_create(&Dispatcher, "Dispatcher", Dispatcher_entry, 0,
        Dispatcher_stack_ptr, STACK_SIZE, 5, 5,
        TX_NO_TIME_SLICE, TX_AUTO_START);

    /* Allocate the stack for Urgent thread */
    tx_byte_allocate(&my_byte_pool, (VOID**)&Urgent_stack_ptr,
        STACK_SIZE, TX_NO_WAIT);

    /* Create Urgent thread */
    tx_thread_create(&Urgent, "Urgent", Urgent_entry, 1, Urgent_stack_ptr,
        STACK_SIZE, 10, 10, TX_NO_TIME_SLICE, TX_AUTO_START);

    /* Allocate the stack for Routine thread */
    tx_byte_allocate(&my_byte_pool, (VOID**)&Routine_stack_ptr,
        STACK_SIZE, TX_NO_WAIT);

    /* Create Routine thread */
    tx_thread_create(&Routine, "Routine", Routine_entry, 1, Routine_stack_ptr,
        STACK_SIZE, 15, 15, TX_NO_TIME_SLICE, TX_AUTO_START);

    /* Create the Urgent queue */
    tx_byte_allocate(&my_byte_pool, (VOID**)&UrgentQueue_ptr, QUEUE_SIZE,
        TX_NO_WAIT);
    tx_queue_create(&UrgentQueue, "UrgentQueue", MESSAGE_SIZE, UrgentQueue_ptr,
        QUEUE_SIZE);

    /* Create the Routine queue */
    tx_byte_allocate(&my_byte_pool, (VOID**)&RoutineQueue_ptr, QUEUE_SIZE,
        TX_NO_WAIT);
    tx_queue_create(&RoutineQueue, "RoutineQueue", MESSAGE_SIZE,
        RoutineQueue_ptr, QUEUE_SIZE);

    /* Create and activate the timer */
    tx_timer_create(&stats_timer, "stats_timer", print_stats, 0x1234,
        200, 200, TX_AUTO_ACTIVATE);
}

/****************************************************/
/*              Function Definitions                */
/****************************************************/
/* Entry function definition of Dispatcher
   it has a higher priority than the other threads and
   it sends messages to the queues */

void    Dispatcher_entry(ULONG thread_input)
{
    while (1)
    {
        /* Send messages to UrgentQueue and RoutineQueue with sleep intervals */

        Dispatcher_counter++;

        DispatcherMessage++;
        tx_queue_send(&UrgentQueue, &DispatcherMessage, TX_WAIT_FOREVER);
        tx_thread_sleep(10);

        DispatcherMessage++;
        tx_queue_send(&RoutineQueue, &DispatcherMessage, TX_WAIT_FOREVER);
        tx_thread_sleep(5);
    }
}

/************************************************************/
/* Entry function definition of Urgent
   It has a lower priority than Dispatcher and it receives
   messages from UrgentQueue */

void    Urgent_entry(ULONG thread_input)
{
    while (1)
    {
        /* Receive a message from UrgentQueue and sleep 3 timer ticks.  */
        tx_queue_receive(&UrgentQueue, &UrgentMessage, TX_WAIT_FOREVER);
        Urgent_counter++;
        tx_thread_sleep(3);
    }
}

/************************************************************/
/* Entry function definition of Routine
   It has a lower priority than Dispatcher and it receives
   messages from RoutineQueue */

void    Routine_entry(ULONG thread_input)
{
    while (1)
    {
        /* Receive a message from RoutineQueue and sleep 17 timer ticks.  */
        tx_queue_receive(&RoutineQueue, &RoutineMessage, TX_WAIT_FOREVER);
        Routine_counter++;
        tx_thread_sleep(17);
    }
}

/*****************************************************/
/* print statistics at specified times */
void print_stats(ULONG invalue)
{
    ULONG   current_time, UrgentEnqueued, RoutineEnqueued;
    current_time = tx_time_get();
    tx_queue_info_get(&UrgentQueue, TX_NULL, &UrgentEnqueued, TX_NULL, TX_NULL, TX_NULL, TX_NULL);
    tx_queue_info_get(&RoutineQueue, TX_NULL, &RoutineEnqueued, TX_NULL, TX_NULL, TX_NULL, TX_NULL);

    printf("\nProjectMessageQueues: 3 threads, 1 byte pool, 2 message queues, and 1 timer.\n\n");
    printf("     Current Time:                   %lu\n", current_time);
    printf("           Dispatcher counter:       %lu\n", Dispatcher_counter);
    printf("               Urgent counter:       %lu\n", Urgent_counter);
    printf("              Routine counter:       %lu\n", Routine_counter);
    printf("          last message # sent:       %lu\n", DispatcherMessage);
    printf("        Urgent message # recd:       %lu\n", UrgentMessage);
    printf("         UrgentQueue contents:       %lu\n", UrgentEnqueued);
    printf("       Routine message # recd:       %lu\n", RoutineMessage);
    printf("        RoutineQueue contents:       %lu\n\n", RoutineEnqueued);
}
