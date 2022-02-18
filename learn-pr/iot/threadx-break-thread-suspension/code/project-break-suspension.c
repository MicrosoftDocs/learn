/* ProjectBreakSuspension - create three threads, one byte pool, one semaphore, and one timer. 
   The Monitor thread uses wait abort to break Urgent or Routine thread's suspension after
   a long period of idleness. The Urgent and Routine threads each use the semaphore to proceed, 
   but occasionally each thread sleeps for an extremely long time. The Monitor thread
   detects this idleness and breaks that thread's suspension.
   
   Your task is to detect the idleness for the Routine thread and break its suspension */

#include   "tx_api.h"
#include   <stdio.h>

#define     STACK_SIZE         1024
#define     BYTE_POOL_SIZE     9120

/* Define the ThreadX object control blocks...  */
TX_THREAD      Urgent, Routine, Monitor;
TX_SEMAPHORE   my_semaphore;
TX_BYTE_POOL   my_byte_pool;
TX_TIMER       stats_timer;

/* Define the counters used in the PROJECT application...  */
ULONG    Urgent_counter=0, total_Urgent_time=0;
ULONG    Routine_counter=0, total_Routine_time=0;

/* Define the current run count for Urgent and Routine threads */
ULONG	 Urgent_previous_run_count = 0;
ULONG	 Routine_previous_run_count = 0;

/* Define variables for Routine thread performance info */
ULONG resumptions_Routine;
ULONG suspensions_Routine;
ULONG wait_aborts_Routine;

/* Define variables for Urgent thread performance info */
ULONG resumptions_Urgent;
ULONG suspensions_Urgent;
ULONG wait_aborts_Urgent;

/* Define function prototypes.  */
void    Urgent_entry(ULONG thread_input);
void    Routine_entry(ULONG thread_input);
void    Monitor_entry(ULONG thread_input);
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
CHAR *Urgent_stack_ptr, *Routine_stack_ptr, *Monitor_stack_ptr;

    /* Create a byte memory pool from which to allocate the thread stacks.  */
    tx_byte_pool_create(&my_byte_pool, "my_byte_pool",
                        first_unused_memory, BYTE_POOL_SIZE);

    /* Allocate the stack for the Urgent thread.  */
    tx_byte_allocate(&my_byte_pool, (VOID **) &Urgent_stack_ptr, STACK_SIZE, TX_NO_WAIT);

    /* Create the Urgent.  */
    tx_thread_create(&Urgent, "Urgent", Urgent_entry, 0x1234,  
                     Urgent_stack_ptr, STACK_SIZE, 5, 5, TX_NO_TIME_SLICE, TX_AUTO_START);

    /* Allocate the stack for the Routine thread.  */
    tx_byte_allocate(&my_byte_pool, (VOID **) &Routine_stack_ptr, STACK_SIZE, TX_NO_WAIT);

    /* Create the Routine thread */
    tx_thread_create(&Routine, "Routine", Routine_entry, 0x1234,  
                     Routine_stack_ptr, STACK_SIZE, 15, 15,
                     TX_NO_TIME_SLICE, TX_AUTO_START);

    /* Allocate the stack for the Monitor thread.  */
    tx_byte_allocate(&my_byte_pool, (VOID **) &Monitor_stack_ptr, STACK_SIZE, TX_NO_WAIT);

    /* Create the Monitor thread */
    tx_thread_create(&Monitor, "Monitor", Monitor_entry, 0x1234,  
                     Monitor_stack_ptr, STACK_SIZE, 3, 3,
                     TX_NO_TIME_SLICE, TX_AUTO_START); 

    /* Create the semaphore used by both threads.  */
    tx_semaphore_create(&my_semaphore, "my_semaphore", 2);

    /* Create and activate the timer */
    tx_timer_create (&stats_timer, "stats_timer", print_stats,
                     0x1234, 1000, 1000, TX_AUTO_ACTIVATE);
}

/************************************************************/

/* Urgent thread entry function */

void    Urgent_entry(ULONG thread_input)
{
ULONG   start_time, cycle_time, current_time, sleep_time, status;

    /* This is the Urgent thread--it has a higher priority than the Routine thread */
    while(1)
    {
      /* Get the starting time for this cycle */
      start_time = tx_time_get();
        
      /* Get the semaphore and sleep--90% of the time sleep_time==5,
                                      10% of the time sleep_time==75. */
      tx_semaphore_get(&my_semaphore, TX_WAIT_FOREVER);
      if (rand() % 100 < 90) sleep_time = 5;
         else sleep_time = 75;
		
      status = tx_thread_sleep(sleep_time);
      if (status == TX_WAIT_ABORTED)
      {
         /* Sleep suspension is terminated
            Code to handle this situation would be here */ ;
       }

      /* Release the semaphore.  */
      tx_semaphore_put(&my_semaphore);
    
      /* Increment the thread counter and get timing info  */
      Urgent_counter++;
      current_time = tx_time_get();
      cycle_time = current_time - start_time;
      total_Urgent_time += cycle_time;
    }
}

/************************************************************/

/* Routine thread entry function */

void    Routine_entry(ULONG thread_input)
{
ULONG	start_time, current_time, cycle_time, sleep_time;

    /* This is the Routine thread--it has a lower priority than the Urgent thread */
    while(1)
    {
        /* Get the starting time for this cycle */
        start_time = tx_time_get();
        
        /* Get the semaphore and sleep--90% of the time sleep_time==25,
                                        10% of the time sleep_time==400 */
        tx_semaphore_get(&my_semaphore, TX_WAIT_FOREVER);
        if (rand() % 100 < 90) sleep_time = 25;
        else sleep_time = 400;

	tx_thread_sleep(sleep_time);
        /* Insert if statement to determine whether sleep was wait aborted */
		
        /* Release the semaphore.  */
        tx_semaphore_put(&my_semaphore);

        /* Increment the thread counter and get timing info  */
        Routine_counter++;

        current_time = tx_time_get();
        cycle_time = current_time - start_time;
        total_Routine_time += cycle_time;
    }
}

/************************************************************/

/* Monitor thread entry function */

void    Monitor_entry(ULONG thread_input)
{

/* Parameter for the thread info get service */
ULONG run_count;

   /* This is the Monitor thread - it has the highest priority */
   while(1)
   {
      /* The Monitor thread wakes up every 50 timer ticks and checks on the other threads */
      tx_thread_sleep(50);

      /* Determine whether the Urgent thread has stalled--if so, break its suspension */
      tx_thread_info_get(&Urgent, TX_NULL, TX_NULL, 
                         &run_count, TX_NULL, TX_NULL, TX_NULL, TX_NULL, TX_NULL);
	
      /* If the previous Urgent thread run count is the same as the current run count, abort suspension */
      if (Urgent_previous_run_count == run_count)  tx_thread_wait_abort(&Urgent);
         Urgent_previous_run_count = run_count;

      /**** Insert code here for the Routine thread ****/

   }
}

/***************************************************/
/* print statistics at specified times */
void print_stats (ULONG invalue)
{
ULONG   current_time, avg_Routine_time, avg_Urgent_time;

   /* Retrieve performance information on Routine thread */
   tx_thread_performance_info_get(&Routine, &resumptions_Routine, &suspensions_Routine,
                                  TX_NULL, TX_NULL, TX_NULL, TX_NULL, TX_NULL, TX_NULL, 
                                  &wait_aborts_Routine, TX_NULL);

   /* Retrieve performance information on Urgent thread */
   tx_thread_performance_info_get(&Urgent, &resumptions_Urgent, &suspensions_Urgent,
                                  TX_NULL, TX_NULL, TX_NULL, TX_NULL, TX_NULL, TX_NULL, 
                                  &wait_aborts_Urgent, TX_NULL);

   current_time = tx_time_get();
 
   if ((Urgent_counter>0) && (Routine_counter>0))
      {
         avg_Routine_time = total_Routine_time / Routine_counter;
         avg_Urgent_time = total_Urgent_time / Urgent_counter;
         printf("\nProjectBreakSuspension: 3 threads, 1 byte pool, 1 semaphore, and 1 timer.\n\n");
         printf("     Current Time:                %lu\n", current_time);
         printf("            Urgent counter:       %lu\n", Urgent_counter);
         printf("           Urgent avg time:       %lu\n", avg_Urgent_time);
         printf("           Routine counter:       %lu\n", Routine_counter);
         printf("          Routine avg time:       %lu\n\n", avg_Routine_time);
         
	 printf(" Urgent Thread resumptions:       %lu\n", resumptions_Urgent);
         printf("               suspensions:       %lu\n", suspensions_Urgent);
	 printf("               wait aborts:       %lu\n\n", wait_aborts_Urgent);
        
         printf("Routine Thread resumptions:       %lu\n", resumptions_Routine);
         printf("               suspensions:       %lu\n", suspensions_Routine);
	 printf("               wait aborts:       %lu\n\n", wait_aborts_Routine);
        		
      }
      else printf("Bypassing print_stats function, Current Time: %lu\n", tx_time_get());
}
