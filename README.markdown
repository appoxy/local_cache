LocalCache
==========

A local in memory cache, similar to Rails' built in MemoryStore, but adds more advanced features
like cache size limit and object expiration / ttl.

Usage
------

### For Rails

In environment.rb:

    require 'local_cache'

    config.cache_store = LocalCache.new

See rdoc for initialization options such as max size and default ttl.

### For regular usage

    cache = LocalCache.new
    cache.write("key", value)
    val = cache.read("key")


