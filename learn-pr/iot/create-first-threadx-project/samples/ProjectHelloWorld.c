/* HelloWorld.c

   Create two threads, one byte pool, and one mutex.
   The mutex protects the critical sections of the threads. */

/****************************************************/
/*    Declarations, Definitions, and Prototypes     */
/****************************************************/

#include   "tx_api.h"
#include   <stdio.h>

#define     STACK_SIZE         1024
#define     BYTE_POOL_SIZE     9120

/* Define the ThreadX object control blocks...  */
TX_THREAD     speedy_thread;
TX_THREAD     slow_thread;
TX_MUTEX      my_mutex;
TX_BYTE_POOL  my_byte_pool;

/* Define thread prototypes. */
void    speedy_thread_entry(ULONG thread_input);
void    slow_thread_entry(ULONG thread_input);

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
CHAR    *speedy_stack_ptr;
CHAR    *slow_stack_ptr;

    /* Create a byte memory pool for thread stack allocation. */
    tx_byte_pool_create(&my_byte_pool, "my_byte_pool",
                        first_unused_memory, BYTE_POOL_SIZE);
 
    /* Allocate the stack for the speedy_thread.  */
    tx_byte_allocate(&my_byte_pool, (VOID **) &speedy_stack_ptr,
                     STACK_SIZE, TX_NO_WAIT);

    /* Create the speedy_thread.  */
    tx_thread_create(&speedy_thread, "speedy_thread",
                     speedy_thread_entry, 0,  
                     speedy_stack_ptr, STACK_SIZE, 5, 5,
                     TX_NO_TIME_SLICE, TX_AUTO_START);

    /* Allocate the stack for the slow_thread.  */
    tx_byte_allocate(&my_byte_pool, (VOID **) &slow_stack_ptr,
                     STACK_SIZE, TX_NO_WAIT);

    /* Create the slow_thread.  */
    tx_thread_create(&slow_thread, "slow_thread",
                     slow_thread_entry, 1, slow_stack_ptr, 
                     STACK_SIZE, 15, 15,
                     TX_NO_TIME_SLICE, TX_AUTO_START);

    /* Create the mutex used by both threads  */
    tx_mutex_create(&my_mutex, "my_mutex", TX_NO_INHERIT);
}

/****************************************************/
/*              Function Definitions                */
/****************************************************/

/* Entry function definition of speedy_thread
   it has a higher priority than slow_thread */

void  speedy_thread_entry(ULONG thread_input)
{
ULONG current_time;
   while (1)
   {
      /* Activity 1:  2 timer ticks */
      tx_thread_sleep(2);

      /* Activity 2:  5 timer ticks  *** critical section *** */
      /* Get the mutex with suspension */
      tx_mutex_get(&my_mutex, TX_WAIT_FOREVER);
      tx_thread_sleep(5);
      /* Release the mutex */
      tx_mutex_put(&my_mutex);

      current_time = tx_time_get();
      printf("Current Time: %5lu  Speedy Thread finished a cycle...\n",
              current_time);
   }
}
/****************************************************/

/* Entry function definition of slow_thread
   it has a lower priority than speedy_thread */

void  slow_thread_entry(ULONG thread_input)
{
ULONG current_time;
   while(1)
   {
      /* Activity 3: 12 timer ticks  *** critical section ***  */
      /* Get the mutex with suspension */
      /******* complete Activity 3 here -- use Activity 2 as a guide *****/
	   tx_thread_sleep(12);

      /* Activity 4: 8 timer ticks  */
      tx_thread_sleep(8);

      current_time = tx_time_get();
      printf("Current Time: %5lu    Slow Thread finished a cycle...\n",
              current_time);
    }
}
