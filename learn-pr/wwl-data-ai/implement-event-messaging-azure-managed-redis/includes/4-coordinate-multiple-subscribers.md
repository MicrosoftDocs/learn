When building scalable AI applications with Azure Cache for Redis or Azure Managed Redis, understanding how to coordinate multiple subscribers is crucial for choosing the right architecture. The behavior differs significantly depending on whether you're using pub/sub or Streams, and each approach serves different coordination needs in your AI backend services.

Imagine you have three worker services processing AI inference requests. With pub/sub, if you subscribe all three workers to the same channel, every worker receives every message—creating duplicate processing. This wastes GPU cycles and produces inconsistent results. With Streams consumer groups, each inference request goes to exactly one worker, distributing the workload automatically. Understanding this difference helps you choose the right tool and avoid common scaling pitfalls.

## Pub/sub: Broadcast to all subscribers

When you subscribe multiple services to the same Redis pub/sub channel, every subscriber receives every message. Redis pub/sub's fundamental behavior is designed for broadcasting events to multiple interested parties simultaneously.

### How broadcast distribution works

Redis delivers each published message to all active subscribers of that channel. If you have five AI services subscribed to `ai:models:updated`, and you publish one message to that channel, all five services receive the same message at the same time.

```python
# Publisher service
redis_client.publish('ai:cache:invalidate', 'embeddings-v2')

# All of these subscribers receive the message:
# - Subscriber 1 (API server instance 1)
# - Subscriber 2 (API server instance 2)  
# - Subscriber 3 (Background worker)
# - Subscriber 4 (Analytics service)
```

This broadcast behavior is intentional and useful for specific scenarios.

### When broadcast is what you want

Use pub/sub when you need all your services to react to the same event:

- **Cache invalidation across multiple API instances:** When your AI model is updated, all API instances need to clear their model cache simultaneously. Publishing to a channel ensures every instance receives the invalidation signal.

    ```python
    # Model update service
    def update_model(model_id, new_version):
        save_model_to_storage(model_id, new_version)
        # Notify all API instances to clear cache
        redis_client.publish('ai:models:cache:invalidate', 
                            f'{model_id}:{new_version}')
    
    # Each API instance subscribes and clears its own cache
    pubsub = redis_client.pubsub()
    pubsub.subscribe('ai:models:cache:invalidate')
    for message in pubsub.listen():
        if message['type'] == 'message':
            clear_local_model_cache(message['data'])
    ```

- **Configuration updates for distributed services:** When you change feature flags or AI model parameters, all running services need to reload their configuration. Pub/sub ensures every instance receives the update notification.

- **Real-time monitoring and metrics collection:** Multiple monitoring systems can subscribe to the same metrics channel, each processing the data differently (dashboards, alerting, logging) without interfering with each other.

- **Event notification to heterogeneous services:** When a user completes an AI interaction, you might need to notify the analytics service, the billing service, and the recommendation engine. Each service subscribes and processes the event according to its own needs.

### When broadcast causes problems

Don't use pub/sub when you want to distribute work:

- **Processing tasks that should only run once:** If you publish an inference request and have three worker subscriptions, all three workers process the same request. You tripled your compute costs and created inconsistent results.

- **Load balancing across workers:** Pub/sub doesn't distribute messages—it duplicates them. If you want to scale horizontally by adding more workers to share the load, pub/sub doesn't help.

- **Queue-like work distribution:** When you need guaranteed processing and acknowledgments, pub/sub's fire-and-forget nature creates problems. Messages might be processed multiple times or not at all.

## Streams: Coordinated work distribution

When you need to coordinate multiple subscribers to avoid duplicate processing and distribute workload, Redis Streams consumer groups solve the problem. Unlike pub/sub's broadcast model, consumer groups ensure each message goes to exactly one subscriber.

### How consumer groups distribute work

Consumer groups partition the Stream among group members. When multiple workers read from the same consumer group, Redis automatically assigns different messages to different workers. Each message is delivered to only one consumer in the group.

```python
# Setup: Create a consumer group once
redis_client.xgroup_create('ai:inference:queue', 'workers', '0', mkstream=True)

# Worker 1 gets messages 1, 3, 5
# Worker 2 gets messages 2, 4, 6
# Worker 3 gets messages 7, 8, 9

# All workers use the same group name but different consumer names
messages = redis_client.xreadgroup(
    groupname='workers',  # Same group
    consumername=f'worker-{worker_id}',  # Unique per worker
    streams={'ai:inference:queue': '>'},
    count=10
)
```

This work distribution happens automatically—you don't write load balancing logic.

### Setting up consumer groups in your worker services

The typical pattern is to create the consumer group once during application initialization, then have each worker instance read from the same group:

```python
# Application startup code (runs once per deployment, not per instance)
def setup_worker_infrastructure():
    try:
        redis_client.xgroup_create(
            'ai:document:analysis',
            'analysis-workers',
            '0',  # Start from beginning
            mkstream=True  # Create stream if doesn't exist
        )
    except redis.ResponseError as e:
        # Group already exists, which is fine
        if 'BUSYGROUP' not in str(e):
            raise

# Worker processing loop (runs on each worker instance)
def process_documents():
    worker_id = f"{os.getenv('HOSTNAME')}-{os.getpid()}"
    
    while True:
        messages = redis_client.xreadgroup(
            groupname='analysis-workers',
            consumername=worker_id,
            streams={'ai:document:analysis': '>'},
            count=5,
            block=5000
        )
        
        for stream, tasks in messages:
            for task_id, task_data in tasks:
                analyze_document(task_data)
                redis_client.xack('ai:document:analysis', 
                                 'analysis-workers', 
                                 task_id)
```

Each worker gets different tasks automatically, enabling horizontal scaling.

### Understanding the `>` symbol and consumer positions

When reading from a consumer group, the `>` symbol tells Redis to give you new messages not yet delivered to any consumer:

```python
# Read only NEW messages not yet delivered to any consumer
redis_client.xreadgroup('workers', 'worker-1', 
                       {'ai:queue': '>'}, count=10)
```

This is what enables work distribution. When worker-1 reads with `>`, it gets messages that worker-2 doesn't receive. Redis tracks which messages are delivered to which consumers.

You can also specify an ID to read from a specific position, which is useful for handling pending messages:

```python
# Read messages pending for this specific consumer
redis_client.xreadgroup('workers', 'worker-1',
                       {'ai:queue': '0'}, count=10)
```

### Scaling workers dynamically

One of the key advantages of consumer groups is that you can add or remove workers without code changes. When you scale your worker deployment from two instances to five instances, the new workers automatically participate in work distribution:

```python
# This same code runs on 2 workers or 20 workers
# Redis automatically distributes work based on how many workers are reading

def worker_main():
    setup_worker_infrastructure()  # Idempotent group creation
    
    worker_id = generate_unique_worker_id()
    
    while True:
        tasks = fetch_next_tasks('workers', worker_id)
        process_tasks(tasks)
        acknowledge_completion(tasks)
```

As you add workers, each worker gets a smaller share of the total workload. As you remove workers, remaining workers automatically pick up the slack.

## Handling failures and task reassignment

Consumer groups provide built-in mechanisms for handling worker failures. When a worker crashes while processing a task, that task stays in the pending list and can be reassigned to a healthy worker.

### Detecting and claiming stuck tasks

Use `XPENDING` to find tasks in progress too long (likely due to worker crashes) and `XCLAIM` to reassign them:

```python
# In a separate monitoring/health-check service or worker
def reassign_abandoned_tasks():
    # Check for tasks pending more than 5 minutes
    pending = redis_client.xpending_range(
        'ai:inference:queue',
        'workers',
        '-', '+',
        count=100
    )
    
    current_time = int(time.time() * 1000)
    
    for task in pending:
        task_id = task['message_id']
        idle_time = current_time - task['time_since_delivered']
        
        # Task processes for more than 5 minutes, likely stuck
        if idle_time > 300000:
            # Claim it for reprocessing
            redis_client.xclaim(
                'ai:inference:queue',
                'workers',
                f'recovery-worker-{os.getpid()}',
                300000,
                message_ids=(task_id,)
            )
            
            # Now process it
            reprocess_stuck_task(task_id)
```

This pattern ensures tasks don't get lost when workers crash.

### Implementing automatic retry in workers

Each worker can check for its own pending tasks on startup, enabling automatic recovery after restarts:

```python
def worker_startup_recovery():
    worker_id = get_worker_id()
    
    # Check if this worker holds any pending tasks from before crash
    pending = redis_client.xpending_range(
        'ai:inference:queue',
        'workers',
        '-', '+',
        count=100
    )
    
    # Filter for tasks assigned to this consumer
    my_pending = [p for p in pending if p['consumer'] == worker_id]
    
    # Retry each pending task
    for task in my_pending:
        try:
            retry_task(task['message_id'])
            redis_client.xack('ai:inference:queue', 'workers', 
                            task['message_id'])
        except Exception as e:
            log_error(f"Retry failed for {task['message_id']}: {e}")
```

This makes your AI services self-healing.

## Choosing the right approach

The choice between pub/sub and Streams depends on whether you need broadcast or coordination:

**Use pub/sub when:**
- All subscribers need to process the same message (cache invalidation, configuration updates, notifications)
- You don't need delivery guarantees or acknowledgments
- Subscribers perform different actions based on the same event

**Use Streams consumer groups when:**
- Each message should be processed by exactly one worker (task queues, job processing)
- You need guaranteed delivery and acknowledgments
- You need to scale processing by adding more workers
- You need to handle worker failures and task reassignment

## Code examples for common scenarios

This section provides practical examples showing how to implement both broadcast and coordinated processing.

### Broadcast cache invalidation

When you need all API instances to react to the same event (like clearing caches), use pub/sub:

```python
# Service that updates AI models
def deploy_new_model(model_name, version):
    upload_model_to_storage(model_name, version)
    
    # Notify all API servers to invalidate cache
    redis_client.publish('ai:models:invalidate', 
                        json.dumps({
                            'model': model_name,
                            'version': version,
                            'timestamp': time.time()
                        }))

# Each API server instance runs this subscriber
async def cache_invalidation_listener():
    redis_client = redis.asyncio.Redis(...)
    
    async with redis_client.pubsub() as pubsub:
        await pubsub.subscribe('ai:models:invalidate')
        
        async for message in pubsub.listen():
            if message['type'] == 'message':
                data = json.loads(message['data'])
                invalidate_model_cache(data['model'], data['version'])
                logger.info(f"Cache invalidated for {data['model']}:{data['version']}")
```

### Distributed task processing

When you need to distribute AI processing tasks across multiple workers without duplication, use Streams with consumer groups:

```python
# API endpoint that queues inference requests
@app.post("/api/inference")
async def queue_inference(request: InferenceRequest):
    task_id = redis_client.xadd('ai:inference:queue', {
        'prompt': request.prompt,
        'model': request.model,
        'user_id': request.user_id,
        'priority': request.priority
    })
    
    return {"task_id": task_id, "status": "queued"}

# Worker service (multiple instances running this code)
def inference_worker():
    # Setup consumer group (idempotent)
    try:
        redis_client.xgroup_create('ai:inference:queue', 
                                   'inference-workers', 
                                   '0', mkstream=True)
    except:
        pass
    
    worker_id = f"{socket.gethostname()}-{os.getpid()}"
    
    while True:
        # Each worker gets different tasks automatically
        messages = redis_client.xreadgroup(
            groupname='inference-workers',
            consumername=worker_id,
            streams={'ai:inference:queue': '>'},
            count=1,
            block=5000
        )
        
        for stream, tasks in messages:
            for task_id, task_data in tasks:
                try:
                    result = run_model_inference(
                        task_data['prompt'],
                        task_data['model']
                    )
                    save_result(task_id, result)
                    
                    # Mark complete
                    redis_client.xack('ai:inference:queue',
                                     'inference-workers',
                                     task_id)
                except Exception as e:
                    # Task stays pending for retry
                    logger.error(f"Task {task_id} failed: {e}")
```

### Hybrid approach

Some AI architectures need both approaches. Use pub/sub to broadcast notifications and Streams to queue actual work:

```python
# When a large document arrives for processing
@app.post("/api/process-document")
async def process_document(doc: UploadFile):
    # Queue the actual processing work
    task_id = redis_client.xadd('ai:document:queue', {
        'doc_id': doc.filename,
        'size': doc.size,
        'user': current_user.id
    })
    
    # Broadcast notification for real-time updates
    redis_client.publish('ai:documents:events',
                        json.dumps({
                            'event': 'document_received',
                            'task_id': task_id,
                            'user': current_user.id
                        }))
    
    return {"task_id": task_id}

# Multiple worker instances process from the Stream (coordinated)
def document_processor_worker():
    # ... worker code using consumer groups

# Multiple services listen to events (broadcast)
# - WebSocket service broadcasts to user's browser
# - Analytics service records metrics  
# - Monitoring service tracks queue depth
async def event_listener_service():
    async with redis_client.pubsub() as pubsub:
        await pubsub.subscribe('ai:documents:events')
        async for message in pubsub.listen():
            # Each service processes events independently
            handle_event(message['data'])
```

## Additional resources

- [Redis Pub/Sub Documentation](https://redis.io/docs/latest/develop/pubsub/) - Official Redis guide to publish/subscribe functionality
- [Redis Streams Consumer Groups](https://redis.io/docs/latest/develop/data-types/streams/) - Official documentation on coordinated message processing with consumer groups
- [Publish/Subscribe Pattern Overview](https://learn.microsoft.com/azure/architecture/patterns/publisher-subscriber) - Microsoft Learn article on the pub/sub pattern in distributed systems
