/* ProjectHelloWorld.c

   Create two threads, one byte pool, and one mutex.
   The mutex protects the critical sections of the threads. */

/****************************************************/
/*    Declarations, Definitions, and Prototypes     */
/****************************************************/

#include   "tx_api.h"
#include   <stdio.h>

#define     STACK_SIZE         1024
#define     BYTE_POOL_SIZE     9120

/* Define the ThreadX object control blocks */
TX_THREAD     Urgent;
TX_THREAD     Routine;
TX_MUTEX      Processor;
TX_BYTE_POOL  my_byte_pool;

/* Define thread prototypes. */
void    Urgent_entry(ULONG thread_input);
void    Routine_entry(ULONG thread_input);

/****************************************************/
/*               Main Entry Point                  */
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

/* Define what the initial system looks like. 
   Put system definition stuff in here, e.g., thread
   creates and other assorted create information.  */

void    tx_application_define(void *first_unused_memory)
{
CHAR    *Urgent_stack_ptr;
CHAR    *Routine_stack_ptr;

    /* Create a memory byte pool for thread stack allocation. */
    tx_byte_pool_create(&my_byte_pool, "my_byte_pool",
                        first_unused_memory, BYTE_POOL_SIZE);
 
    /* Allocate the stack for the Urgent thread.  */
    tx_byte_allocate(&my_byte_pool, (VOID **) &Urgent_stack_ptr,
                     STACK_SIZE, TX_NO_WAIT);

    /* Create the Urgent thread.  */
    tx_thread_create(&Urgent, "Urgent",
                     Urgent_entry, 0,  
                     Urgent_stack_ptr, STACK_SIZE, 5, 5,
                     TX_NO_TIME_SLICE, TX_AUTO_START);

    /* Allocate the stack for the Routine thread.  */
    tx_byte_allocate(&my_byte_pool, (VOID **) &Routine_stack_ptr,
                     STACK_SIZE, TX_NO_WAIT);

    /* Create the Routine thread.  */
    tx_thread_create(&Routine, "Routine",
                     Routine_entry, 1, Routine_stack_ptr, 
                     STACK_SIZE, 15, 15,
                     TX_NO_TIME_SLICE, TX_AUTO_START);

    /* Create the mutex used by both threads  */
    tx_mutex_create(&Processor, "Processor", TX_NO_INHERIT);
}

/****************************************************/
/*              Function Definitions                */
/****************************************************/

/* Entry function definition of Urgent
   it has a higher priority than Routine */

void  Urgent_entry(ULONG thread_input)
{
ULONG current_time;
   while (1)
   {
      /* Activity 1:  2 timer ticks  *** preparation ****/
      tx_thread_sleep(2);

      /* Activity 2:  4 timer ticks  *** critical section *** */
      /* Get the mutex with suspension */
      tx_mutex_get(&Processor, TX_WAIT_FOREVER);
      tx_thread_sleep(4);
      /* Release the mutex */
      tx_mutex_put(&Processor);

      current_time = tx_time_get();
      printf("Current Time: %5lu  Urgent Thread finished a cycle...\n",
              current_time);
   }
}
/****************************************************/

/* Entry function definition of Routine
   it has a lower priority than Urgent */

void  Routine_entry(ULONG thread_input)
{
ULONG current_time;
   while(1)
   {
      /* Activity 3: 2 timer ticks  *** preparation ***  */
      tx_thread_sleep(2);

      /* Activity 4: 7 timer ticks *** critical section *** */
      /* Get the mutex with suspension */
      /******* complete Activity 4 here -- use Activity 2 as a guide *****/

      current_time = tx_time_get();
      printf("Current Time: %5lu    Routine Thread finished a cycle...\n",
              current_time);
    }
}
