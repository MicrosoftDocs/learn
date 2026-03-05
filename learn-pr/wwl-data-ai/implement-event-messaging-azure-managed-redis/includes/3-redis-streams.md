Both Azure Cache for Redis and Azure Managed Redis support Redis Streams, a reliable way to implement task queues and event processing in your AI backend services. When you're building AI applications that need to queue inference requests, coordinate multi-step processing pipelines, or handle long-running AI operations, Streams give you the durability and coordination capabilities that pub/sub doesn't provide.

Imagine you're building an API that processes documents through multiple AI models. Each step takes several seconds, and you can't block the API or lose documents if a service crashes. Redis Streams solves this: your upload handler adds the document to a Stream and returns immediately. Each AI service reads from the Stream at its own pace. If a service crashes while processing a document, that task stays in the pending list and gets automatically reassigned when the service restarts.

## Implementing task queues with Redis Streams

From a developer perspective, Streams are append-only task queues where you add work items (inference requests, processing tasks, etc.) and consumers pull items off the queue. You use `XADD` to add tasks, `XREADGROUP` to pull tasks in your worker code, and `XACK` to mark tasks complete. The key difference from a simple list is that Streams track which consumer is processing which task, enabling automatic retry if your service crashes.

### What developers get from Streams

- **Tasks survive crashes:** When your AI service restarts, unprocessed tasks are still in the Stream. You don't lose inference requests or processing jobs.

- **Automatic retry handling:** If your code crashes while processing a task, that task automatically becomes available for retry without you writing retry logic.

- **Built-in work distribution:** When you scale to multiple workers, Stream consumer groups automatically distribute tasks across instances without duplicate processing.

- **Processing history:** You can query what happened in your pipeline, replay processing for debugging, or let new services catch up on historical data.

- **Simple async patterns:** Your API handlers can add tasks to Streams and return immediately while background workers process tasks at their own pace.

### Understanding Stream task structure

Each task you add to a Stream gets an auto-generated ID and can contain any fields your application needs. Think of it like adding a JSON object to a queue:

```python
# Adding an AI processing task
stream_id = redis.xadd('ai:inference:requests', {
    'user_id': '12345',
    'model': 'gpt-4',
    'prompt': 'Summarize this document...',
    'priority': 'high'
})
# Returns ID like: '1699980000000-0'
```

The ID ensures tasks are processed in order and lets you track which tasks are completed.

### Scaling with multiple workers

When you deploy multiple instances of your AI worker service, consumer groups ensure each task goes to only one worker. You create a group once, then each worker instance reads from the same group:

```python
# In your worker deployment/startup code
try:
    redis.xgroup_create('ai:inference:requests', 'workers', id='0', mkstream=True)
except redis.ResponseError:
    pass  # Group already exists

# In your worker's processing loop (runs on each instance)
while True:
    tasks = redis.xreadgroup('workers', 'worker-instance-1', 
                             {'ai:inference:requests': '>'}, 
                             count=10, block=5000)
    for task_id, task_data in tasks:
        process_ai_task(task_data)
        redis.xack('ai:inference:requests', 'workers', task_id)
```

Now you can scale horizontally—add more worker instances to share the workload.

## When to use Streams

Redis Streams are ideal for specific development scenarios where reliability and task persistence matter. Here are the key situations where Streams solve real problems for AI backend developers:

- **API endpoints that queue AI inference requests:** Instead of blocking your API while waiting for model inference, add the request to a Stream and return a job ID immediately. Background workers process requests and update results.

    ```python
    # In your FastAPI/Flask route handler
    @app.post("/api/analyze")
    async def analyze_document(doc: UploadFile):
        job_id = redis.xadd('ai:analysis:pending', {
            'doc_id': doc.filename,
            'uploaded_by': current_user.id,
            'timestamp': time.time()
        })
        return {"job_id": job_id, "status": "queued"}
    ```

- **Multi-step AI processing pipelines:** When processing requires multiple stages (extract → analyze → summarize → embed), each stage reads from one Stream and writes to the next. If any stage fails, you don't lose progress.

- **Worker services that scale horizontally:** When you go from one worker to five workers processing AI tasks, Streams automatically distribute work without you implementing complex coordination logic.

- **Long-running operations that need retry:** If your embedding generation times out or your GPU runs out of memory mid-inference, Streams keep the failed task in a pending list for automatic retry when your service recovers.

- **Systems requiring processing history:** When debugging why certain predictions were made or investigating user complaints, you can read the Stream history to see exactly what tasks were processed and when.

## Code examples for Streams

This section provides practical code examples showing how to implement common Stream operations in your AI applications. 

### Adding AI tasks to a queue

Use `XADD` to add tasks to a Stream from your API handlers or application code. Each task gets a unique ID and can contain any fields your application needs.

```python
# Your API handler code
def queue_inference_request(user_prompt, model_name):
    task_id = redis.xadd('ai:inference:queue', {
        'prompt': user_prompt,
        'model': model_name,
        'user_id': current_user.id,
        'requested_at': datetime.now().isoformat()
    })
    return task_id
```

### Processing tasks in your worker service

Worker services use `XREADGROUP` to fetch tasks from a Stream and `XACK` to mark them complete. Consumer groups ensure tasks are distributed across multiple worker instances without duplication.

```python
# Worker service processing loop
def process_ai_tasks():
    # One-time setup: create consumer group
    try:
        redis.xgroup_create('ai:inference:queue', 'workers', id='0', mkstream=True)
    except:
        pass  # Already exists
    
    # Main processing loop
    while True:
        # Get up to 5 tasks, wait 5 seconds if queue empty
        messages = redis.xreadgroup(
            groupname='workers',
            consumername=f'worker-{os.getpid()}',
            streams={'ai:inference:queue': '>'},
            count=5,
            block=5000
        )
        
        for stream, tasks in messages:
            for task_id, task_data in tasks:
                try:
                    # Do your AI processing
                    result = run_inference(task_data['prompt'], task_data['model'])
                    save_result(task_id, result)
                    
                    # Mark task complete
                    redis.xack('ai:inference:queue', 'workers', task_id)
                except Exception as e:
                    # Task stays in pending, will retry
                    log_error(f"Task {task_id} failed: {e}")
```

### Handling failed tasks

Use `XPENDING` to find tasks that have been processing too long and `XCLAIM` to reassign them. This handles cases where workers crash mid-processing.

```python
# Check for tasks that have been pending too long (stuck/crashed)
def retry_stuck_tasks():
    pending = redis.xpending('ai:inference:queue', 'workers', '-', '+', 10)
    
    for task in pending:
        task_id = task['message_id']
        idle_time = task['time_since_delivered']
        
        # If task pending more than 5 minutes, reassign it
        if idle_time > 300000:  # milliseconds
            redis.xclaim('ai:inference:queue', 'workers', 
                        f'worker-{os.getpid()}', 0, [task_id])
```

### Monitoring queue health

Use `XINFO` commands to get metrics about your Stream queues, including total tasks, pending tasks, and active consumers. This data is useful for monitoring dashboards and alerting.

```python
# Get Stream metrics for your application dashboard
def get_queue_stats():
    info = redis_client.xinfo_stream('ai:documents:queue')
    groups = redis_client.xinfo_groups('ai:documents:queue')
    
    return {
        'total_tasks': info['length'],
        'pending_tasks': groups[0]['pending'],
        'consumers': groups[0]['consumers']
    }
```

## Developer trade-offs to consider

While Streams provide powerful reliability features, they come with trade-offs you should understand before implementing them in your AI applications.

- **Memory management is your responsibility:** Unlike pub/sub where messages disappear after delivery, Stream tasks stay in memory until you explicitly remove them. For high-volume queues, you need to add trimming to your code:

    ```python
    # Trim to most recent 10,000 tasks when adding new ones
    redis.xadd('ai:inference:queue', task_data, maxlen=10000, approximate=True)
    
    # Or trim periodically in your worker after acknowledging tasks
    if task_count % 100 == 0:  # Every 100 tasks
        redis_client.xtrim('ai:documents:queue', maxlen=10000, approximate=True)
    ```

- **Slightly higher latency than pub/sub:** Streams add a few milliseconds of latency due to persistence and acknowledgment tracking. If you need microsecond latency, use pub/sub. For AI workloads where inference takes seconds, this overhead is negligible.

- **More code complexity:** You need to handle consumer groups, acknowledgments, and pending task checks. This is extra code compared to simple pub/sub subscribe callbacks, but you get reliability in return.

- **Tasks don't auto-expire:** Completed tasks stay in the Stream until trimmed. Plan your cleanup strategy upfront to avoid memory growth.

## Additional resources

- [Redis Streams Commands Reference](https://redis.io/docs/latest/commands/?group=stream) - Complete command documentation for implementing Streams
