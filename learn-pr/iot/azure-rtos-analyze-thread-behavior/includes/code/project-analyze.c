/* ProjectAnalyze - create two threads, one byte pool, and one mutex.
   The mutex protects the critical sections of the threads.
   The purpose of this program is to analyze the Behavior of Threads 
   using Timing Facilities and Performance Information of the Routine thread.
   Your task is to add Performance information for the Urgent thread
   and modify the output section. */

#include   "tx_api.h"
#include   <stdio.h>

#define     STACK_SIZE         1024
#define     BYTE_POOL_SIZE     9120

/* Define the ThreadX object control blocks...  */
TX_THREAD      Urgent, Routine;
TX_MUTEX       my_mutex;
TX_BYTE_POOL   my_byte_pool;
TX_TIMER       stats_timer;

/* Define the counters used in the project application. */
ULONG         Urgent_counter=0, total_Urgent_time=0,
              Routine_counter=0, total_Routine_time=0;

/* Define variables for Routine thread performance info */
ULONG Routine_resumptions, Routine_suspensions, Routine_solicited_preemptions;

/* Define variables for Urgent performance info
   define variables here */

/* Define function prototypes.  */
void    Urgent_entry(ULONG thread_input);
void    Routine_entry(ULONG thread_input);
void    print_stats(ULONG);

/* Define main entry point.  */
int main()
{
    /* Enter the ThreadX kernel.  */
    tx_kernel_enter();
}

/* Define what the initial system looks like.  */
/* Put system definition stuff in here, e.g., thread creates and other
   assorted create information.  */

void    tx_application_define(void *first_unused_memory)
{
CHAR *Urgent_stack_ptr, *Routine_stack_ptr;

    /* Create a byte memory pool from which to allocate the thread stacks.  */
    tx_byte_pool_create(&my_byte_pool, "my_byte_pool",
                        first_unused_memory, BYTE_POOL_SIZE);
 
    /* Allocate the stack for the Urgent thread.  */
    tx_byte_allocate(&my_byte_pool, (VOID **) &Urgent_stack_ptr, STACK_SIZE, TX_NO_WAIT);

    /* Create the Urgent thread.  */
    tx_thread_create(&Urgent, "Urgent", Urgent_entry, 0x1234,  
                     Urgent_stack_ptr, STACK_SIZE, 5, 5, TX_NO_TIME_SLICE, TX_AUTO_START);

    /* Allocate the stack for the Routine thread.  */
    tx_byte_allocate(&my_byte_pool, (VOID **) &Routine_stack_ptr, STACK_SIZE, TX_NO_WAIT);

    /* Create the Routine thread */
    tx_thread_create(&Routine, "Routine", Routine_entry, 0x1234,  
                     Routine_stack_ptr, STACK_SIZE, 15, 15,
                     TX_NO_TIME_SLICE, TX_AUTO_START);
 
    /* Create the mutex used by both threads.  */
    tx_mutex_create(&my_mutex, "my_mutex", TX_NO_INHERIT);

    /* Create and activate the timer */
    tx_timer_create (&stats_timer, "stats_timer", print_stats,
                     0x1234, 500, 500, TX_AUTO_ACTIVATE);
}

/************************************************************/

/* Define the lab project threads.  */

void    Urgent_entry(ULONG thread_input)
{
ULONG   start_time, cycle_time, current_time;

    /* This is the Urgent thread - it has a higher priority than the Routine thread */
    while(1)
    {
        /* Get the starting time for this cycle */
        start_time = tx_time_get();

        /* Activity 1:  2 timer ticks.  */
        tx_thread_sleep(2);

        /* Activity 2:  4 timer ticks **** critical section ***  */
        /* Get the mutex with suspension.  */
        tx_mutex_get(&my_mutex, TX_WAIT_FOREVER);
        tx_thread_sleep(4);
        /* Release the mutex.  */
        tx_mutex_put(&my_mutex);

        /* Increment the thread counter and get timing info  */
        Urgent_counter++;
        current_time = tx_time_get();
        cycle_time = current_time - start_time;
        total_Urgent_time += cycle_time;
    }
}

/************************************************************/

void    Routine_entry(ULONG thread_input)
{
ULONG	start_time, current_time, cycle_time;

    /* This is the Routine thread - it has a lower priority than the Urgent thread */
    while(1)
    {
        /* Get the starting time for this cycle */
        start_time = tx_time_get();

        /* Activity 3 - sleep 2 timer ticks **** preparation ***  */
         tx_thread_sleep(2);

        /* Activity 4:  7 timer ticks **** critical section ***  */
        tx_mutex_get(&my_mutex, TX_WAIT_FOREVER);
        tx_thread_sleep(7);
        /* Release the mutex.  */
        tx_mutex_put(&my_mutex);

        /* Increment the thread counter and get timing info  */
        Routine_counter++;

        current_time = tx_time_get();
        cycle_time = current_time - start_time;
        total_Routine_time += cycle_time;
    }
}

/*****************************************************/
/* print statistics at specified times */
void print_stats (ULONG invalue)
{
ULONG   current_time, avg_Routine_time, avg_Urgent_time;

/* Retrieve performance information for Routine thread */
   tx_thread_performance_info_get(&Routine, &Routine_resumptions,
          &Routine_suspensions, &Routine_solicited_preemptions,
          TX_NULL, TX_NULL, TX_NULL, TX_NULL, TX_NULL, TX_NULL, TX_NULL);

/* Retrieve performance information for Urgent thread
   Add tx_thread_performance_info_get service for Urgent thread here
   and printf statements for the Urgent thread below. */

   current_time = tx_time_get();
 
   if ((Urgent_counter>0) && (Routine_counter>0))
      {
         avg_Routine_time = total_Routine_time / Routine_counter;
         avg_Urgent_time = total_Urgent_time / Urgent_counter;
         printf("\nProjectAnalyze: 2 threads, 1 byte pool, 1 mutex, and 1 timer\n\n");
         printf("       Current Time:             %lu\n", current_time);
         printf("              Urgent counter:    %lu\n", Urgent_counter);
         printf("             Urgent avg time:    %lu\n", avg_Urgent_time);
         printf("             Routine counter:    %lu\n", Routine_counter);
         printf("            Routine avg time:    %lu\n\n", avg_Routine_time);
 
         printf("   Routine Thread resumptions:   %lu\n", Routine_resumptions);
         printf("   Routine Thread suspensions:   %lu\n", Routine_suspensions);
         printf("Routine solicited_preemptions:   %lu\n\n", Routine_solicited_preemptions);
         
      }
      else printf("Bypassing print_stats function, Current Time: %lu\n", tx_time_get());
}