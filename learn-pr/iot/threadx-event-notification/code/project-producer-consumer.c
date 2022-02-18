/* ProjectProducerConsumer - create two threads, one byte pool, 
   one counting semaphore, and one application timer.
   The threads cooperate with each other via the semaphore.
   This is a Producer-Consumer example.

   Your task is to modify this project so that there is one
   Producer and two Consumers. Among other items, you need
   to create another thread.  */

#include   "tx_api.h"
#include   <stdio.h>

#define     STACK_SIZE         1024
#define     BYTE_POOL_SIZE     9120

/* Define the ThreadX object control blocks */
TX_THREAD       Producer;
TX_THREAD       Consumer;
TX_SEMAPHORE    StorageFacility;
TX_BYTE_POOL    my_byte_pool;
TX_TIMER        stats_timer;

/* Define the counters used in this project  */
ULONG   Producer_counter=0, Consumer_counter=0;

/* Define thread prototypes.  */
void    Producer_entry(ULONG thread_input);
void    Consumer_entry(ULONG thread_input);
void    print_stats(ULONG);

/* Define main entry point.  */
int main()
{
    /* Enter the ThreadX kernel.  */
    tx_kernel_enter();
}

/* Define what the initial system looks like.
   Put system definition stuff in here, e.g., thread
   creates and other assorted create information.  */

void  tx_application_define(void *first_unused_memory)
{
   CHAR *Producer_stack_ptr, *Consumer_stack_ptr;

   /* Create a memory byte pool for thread stack allocation */
   tx_byte_pool_create(&my_byte_pool, "my_byte_pool",
                       first_unused_memory, BYTE_POOL_SIZE);

   /* Allocate the stack for the Producer thread.  */
   tx_byte_allocate(&my_byte_pool, (VOID **) &Producer_stack_ptr,
                    STACK_SIZE, TX_NO_WAIT);

   /* Create the Producer */
   tx_thread_create(&Producer, "Producer", Producer_entry, 0,  
	                Producer_stack_ptr, STACK_SIZE, 5, 5,
                    TX_NO_TIME_SLICE, TX_AUTO_START);

    /* Allocate the stack for the Consumer thread.  */
    tx_byte_allocate(&my_byte_pool, (VOID **) &Consumer_stack_ptr,
                     STACK_SIZE, TX_NO_WAIT);

    /* Create the Consumer thread */
    tx_thread_create(&Consumer, "Consumer", Consumer_entry, 1,  
		             Consumer_stack_ptr, STACK_SIZE, 15, 15,
                     TX_NO_TIME_SLICE, TX_AUTO_START);

    /* Create the counting semaphore used by both threads.  */
    tx_semaphore_create (&StorageFacility, "StorageFacility", 0); 

    /* Create and activate the timer */
    tx_timer_create (&stats_timer, "stats_timer", print_stats,
                     0x1234, 200, 200, TX_AUTO_ACTIVATE);
}

/************************************************************/

/* Define the entry function for the Producer thread  */
void    Producer_entry(ULONG thread_input)
{
    /* This is the higher priority thread - the Producer */
    while(1)
    {
        /* Put an instance on the counting semaphore and
           sleep for 5 timer ticks  */
        tx_semaphore_put (&StorageFacility);
        tx_thread_sleep(5);

        /* Increment the Producer thread counter */
        Producer_counter++;
    }
}

/************************************************************/
/* Define the entry function for the Consumer thread  */
void    Consumer_entry(ULONG thread_input)
{
    /* This is the lower priority thread - the Consumer  */
    while(1)
    {
        /* Get an instance of the counting semaphore and
           hold it for 12 timer ticks  */
        tx_semaphore_get (&StorageFacility, TX_WAIT_FOREVER);
        tx_thread_sleep(12);

        /* Increment the Consumer thread counter */
        Consumer_counter++;
    }
}

/*****************************************************/
/* print statistics at specified times */
void print_stats (ULONG invalue)
{
   ULONG   current_time, current_semaphore_count;
   current_time = tx_time_get();

   tx_semaphore_info_get(&StorageFacility, TX_NULL,
                         &current_semaphore_count, 
                         TX_NULL, TX_NULL, TX_NULL);

   printf("\n**** ProjectProducerConsumer: 2 threads, 1 byte pool, 1 counting semaphore, and 1 timer.\n\n");
   printf("     Current Time:                    %lu\n", current_time);
   printf("              Producer counter:       %lu\n", Producer_counter);
   printf("              Consumer counter:       %lu\n", Consumer_counter);
   printf(" Current StorageFacility count:       %lu\n", current_semaphore_count);
}
