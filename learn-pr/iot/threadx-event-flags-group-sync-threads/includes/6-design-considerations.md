## Introduction

In addition to the Urgent thread and the Routine thread, we need another thread to control the synchronization process, and we call that thread the Monitor thread. The Monitor thread has priority 2, which is the highest of the three threads. The Monitor thread sleeps 10 timer ticks and then sets the specified events flags with the value 0xFFF, that we call `sync_flags`. We give the name `Synchronize` to the event flags group.
