/* ProjectEventFlags - Create three threads, one byte pool, and one event flags group.
   The Monitor thread sets the event flags group at periodic intervals and
   the other threads all wait for the desired event flags and then proceed en masse.

   Your task: Add a thread called Important and synchronize it with the other threads */

#include   "tx_api.h"
#include   <stdio.h>

#define     STACK_SIZE         1024
#define     BYTE_POOL_SIZE     9120
   /* Define the event flags value that will be used for synchronization.  */
#define     sync_flags    0xFFF

/* Define the ThreadX object control blocks...  */
TX_THREAD               Monitor_thread;
TX_THREAD               Urgent_thread;
TX_THREAD               Routine_thread;
TX_EVENT_FLAGS_GROUP    Synchronize;
TX_BYTE_POOL            my_byte_pool;
TX_TIMER                stats_timer;

/* Define the counters and actual flags used in the project application...  */
ULONG Urgent_thread_counter = 0, Routine_thread_counter = 0, actual_events;

/* Define variables for Routine thread performance info */
ULONG   resumptions_Routine, suspensions_Routine;

/* Define variables for Urgent thread performance info */
ULONG   resumptions_Urgent, suspensions_Urgent;

/* Define the thread prototypes.  */
void    Urgent_thread_entry(ULONG thread_input);
void    Routine_thread_entry(ULONG thread_input);
void    Monitor_thread_entry(ULONG thread_input);
void    print_stats(ULONG);

/* Define main entry point.  */
int main()
{
    /* Enter the ThreadX kernel.  */
    tx_kernel_enter();
}

/* Define what the initial system looks like.  */
void    tx_application_define(void* first_unused_memory)
{
    CHAR* Monitor_stack_ptr, * Routine_stack_ptr, * Urgent_stack_ptr;

    /* Create a memory byte pool from which to allocate the thread stacks */
    tx_byte_pool_create(&my_byte_pool, "my_byte_pool",
        first_unused_memory, BYTE_POOL_SIZE);

    /* Put system definition stuff in here, e.g., thread creates and other assorted
       create information */

       /* Allocate the stack for the Urgent thread */
    tx_byte_allocate(&my_byte_pool, (VOID**)&Urgent_stack_ptr, STACK_SIZE, TX_NO_WAIT);

    /* Create the Urgent_thread  */
    tx_thread_create(&Urgent_thread, "Urgent_thread", Urgent_thread_entry, 0,
        Urgent_stack_ptr, STACK_SIZE, 5, 5, TX_NO_TIME_SLICE, TX_AUTO_START);

    /* Allocate the stack for the Routine thread */
    tx_byte_allocate(&my_byte_pool, (VOID**)&Routine_stack_ptr, STACK_SIZE, TX_NO_WAIT);

    /* Create the Routine thread */
    tx_thread_create(&Routine_thread, "Routine_thread", Routine_thread_entry, 1,
        Routine_stack_ptr, STACK_SIZE, 15, 15,
        TX_NO_TIME_SLICE, TX_AUTO_START);

    /* Allocate the stack for the Monitor thread */
    tx_byte_allocate(&my_byte_pool, (VOID**)&Monitor_stack_ptr, STACK_SIZE, TX_NO_WAIT);

    /* Create the Monitor thread */
    tx_thread_create(&Monitor_thread, "Monitor_thread", Monitor_thread_entry, 1,
        Monitor_stack_ptr, STACK_SIZE, 2, 2,
        TX_NO_TIME_SLICE, TX_AUTO_START);

    /* Create the event flags group used by all three threads */
    tx_event_flags_create(&Synchronize, "Synchronize");

    /* Create and activate the timer */
    tx_timer_create(&stats_timer, "stats_timer", print_stats,
        0x1234, 200, 200, TX_AUTO_ACTIVATE);

}

/************************************************************/
/* Define the Monitor thread entry function */
void    Monitor_thread_entry(ULONG thread_input)
{
    /*  This is the Monitor thread - it has the highest priority and
        it periodically sets the event flags group to sync_flags. */
    while (1)
    {
        /* Sleep for 10 timer ticks and then set sync_flags using TX_OR.
           The other threads will suspend while waiting for sync_flags
           to appear in the event flags group */

        tx_thread_sleep(10);
        tx_event_flags_set(&Synchronize, sync_flags, TX_OR);
    }
}

/***********************************************************/
/* Define the Urgent thread  */
void    Urgent_thread_entry(ULONG thread_input)
{
    /* This is the Urgent thread - it has a priority of 5. */
    while (1)
    {
        /* Wait for sync_flags to appear in the event flags group
           using TX_AND_CLEAR, then sleep 5 timer ticks */

        tx_event_flags_get(&Synchronize, sync_flags, TX_AND_CLEAR,
            &actual_events, TX_WAIT_FOREVER);

        /* Increment the thread counter */
        Urgent_thread_counter++;

        tx_thread_sleep(5);
    }
}

/************************************************************/
/* Define the Routine_thread  */
void    Routine_thread_entry(ULONG thread_input)
{
    /* This is the Routine thread - it has a priority of 15. */
    while (1)
    {
        /* Wait for sync_flags to appear in the event flags group
           using TX_AND_CLEAR, then sleep 12 timer ticks */

        tx_event_flags_get(&Synchronize, sync_flags, TX_AND,
            &actual_events, TX_WAIT_FOREVER);

        /* Increment the thread counter */
        Routine_thread_counter++;

        tx_thread_sleep(12);
    }
}

/*****************************************************/
/* print statistics at specified times */
void print_stats(ULONG invalue)
{
    ULONG   current_time, current_flags;

    /* Retrieve performance information on Routine thread */
    tx_thread_performance_info_get(&Routine_thread, &resumptions_Routine,
        &suspensions_Routine, TX_NULL, TX_NULL,
        TX_NULL, TX_NULL, TX_NULL, TX_NULL,
        TX_NULL, TX_NULL);

    /* Retrieve performance information on Urgent thread */
    tx_thread_performance_info_get(&Urgent_thread, &resumptions_Urgent,
        &suspensions_Urgent, TX_NULL, TX_NULL,
        TX_NULL, TX_NULL, TX_NULL, TX_NULL,
        TX_NULL, TX_NULL);

    current_time = tx_time_get();
    tx_event_flags_info_get(&Synchronize, TX_NULL,
        &current_flags, TX_NULL, TX_NULL, TX_NULL);
    printf("\nProjectEventFlags: 3 threads, 1 byte pool, 1 event flags group, and 1 timer.\n\n");
    printf("Current Time:                    %lu\n", current_time);

    printf("  Routine thread resumptions:    %lu\n", resumptions_Routine);
    printf("  Routine thread suspensions:    %lu\n", suspensions_Routine);
    printf("      Routine_thread counter:    %lu\n\n", Routine_thread_counter);

    printf("Urgent thread resumptions:       %lu\n", resumptions_Urgent);
    printf("Urgent thread suspensions:       %lu\n", suspensions_Urgent);
    printf("    Urgent_thread counter:       %lu\n\n", Urgent_thread_counter);
}
