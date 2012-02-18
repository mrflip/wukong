## Dataflow operations

* **load, source**

* **store, sink**
  - **dump** is a console sink
  
* **push**
* **pull**
  - **query**

* **buffer**
* **throttle**


__________________________________________________________________________

* **split**
  - 1-to-all: each record goes to all outputs
  - 1-to-n:   each record goes to exactly one output, based on an ordered set of filters

* **union**
  - in a stream context, produces a merged stream containing all incoming records with no guarantees of order or locality.

* **process** -- pass a set of inputs through a flow, receiving at a set of outputs. Note that this can be an external process, another flow, whatever

* **foreach**
  - **flatten**
  - **subgroup, subsort**

  - **decorate** (hash or fragment-replicate join) -- hang data from a hash on each record

  - **delay**
  - **trigger**

* **filter**
  - **sample**

* **limit, window**

__________________________________________________________________________

### Guarantees

* **partition**

* **sort**
  - **distinct**

* **group, cogroup** --

  - **join** is sugar for `cogroup`-and-`flatten`
  - **cross**

__________________________________________________________________________

### Coordination

* **counters**
* **locks**
* **registers**

* **announce/discover**

__________________________________________________________________________

### Meta

* **barrier**

* **schedule**

* idempotency control

* **stop/start/sleep**
  - **close**
  
* **simulate, explain, describe**
  - **audit**

* **register** sign something up to be a block
  - **compose** -- register a composite graph as a component

* hooks
  - can hook in post-hoc, inline or teeing
    - mini-mode
    - monitoring/logging
    - dark launch
  - middleware

* **locality** declarative advice -- influence where your data lives. See mesos' resource offers mechanism

* **bind** ties machine/resource groups to flows

* **priority** prioritized execution

__________________________________________________________________________

## Message passing

* Broadcast
* Listen
* Notify/ping
* Request/Response
* 

__________________________________________________________________________

## Components

* Chunked Record Source
* Recordizer
* Serializer
* ....

* Schema
__________________________________________________________________________


## Mediums


* Stream:
  - unix pipes
  - named pipes
  - socket
  - http streaming
  - websockets
  - syslogNG
  - Flume
  - file read/tail/append/write

* Dispatch:
  - UDP broadcast
  - jabber
  - http post/put

* Pull:
  - http get
  - db query

* Listen:
  - http listen
  - poll remote resource
  
  
__________________________________________________________________________


## Bibliography

* [Infopipes: An abstraction for multimedia streamin](http://web.cecs.pdx.edu/~black/publications/Mms062%203rd%20try.pdf) Black et al 2002

* [StreamSQL Event Processing with Esper](http://www.igvita.com/2011/05/27/streamsql-event-processing-with-esper/)
* [Esper EPL Reference](http://esper.codehaus.org/esper-4.5.0/doc/reference/en/html_single/index.html#epl_clauses)


* [Yahoo Pipes]() - [Yahoo Pipes wikipedia page](http://en.wikipedia.org/wiki/Yahoo_Pipes)
