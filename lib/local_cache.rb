require 'active_support'


class LocalCache < ActiveSupport::Cache::Store

    # Initialize a new LocalCache.
    #
    # Options:
    #     :size => 1000 - max number of objects to store
    #     :ttl => 60 - default ttl (can be overridden on any PUT/WRITE)
    def initialize(options={})
        puts 'Creating new LocalCache'
        @size = options[:size] || 1000
        @default_expires_in = options[:ttl] || 60
        # we initialize an empty hash
        @cache = {}
        # and a list for pushing objects out
        @cache_list = []
    end

    def get(key, options={})
        # if the API URL exists as a key in cache, we just return it
        # we also make sure the data is fresh
        #puts 'looking in cache for: ' + key.to_s
        if @cache.has_key? key
            expires = @cache[key][0]
            #puts 'checking expired=' + key + ' at ' + expires.to_s + ' and now=' + Time.now.to_s
            if expires - Time.now > 0
#            puts 'returning from cache ' + @cache[key][1].inspect
                # todo: implement LRU ordering
                return @cache[key][1]
            else
                #puts 'expired'
                delete(key)
            end
        else
#          puts 'cache does not contain ' + key
        end
        return nil
    end

    def get_multi(keys, options={})
        ret = {}
        keys.each do |k|
            val = get(k)
            ret[k] = val unless val.nil?
        end
        ret
    end

    def get_i(key)
        val = get(key)
        return nil if val.nil?
        return val.to_i
    end

    def exist?(key)
        return !get(key).nil?
    end

    def increment(key, val=1)
        ret = get(key)
        if ret.is_a?(Fixnum)
            ret += val
        else
            ret = val
            put(key, ret)
        end
    end

    def put(key, val, options={})
        seconds_to_store = options[:expires_in] || options[:ttl] || @default_expires_in
        @cache[key] = [Time.now+seconds_to_store, val]
        @cache_list << key
        while @cache.size > @size && @cache_list.size > 0
            to_remove = @cache_list.pop
            @cache.delete(to_remove) unless to_remove.nil?
        end
    end

    def read(name, options={})
#        puts 'read from localcache'
        super
        ret = get(name, options)
#        puts 'ret.frozen=' + ret.frozen?.to_s
        return ret
    end

    def write(name, value, options={})
        super
        put(name, value, options)
#        puts 'write.frozen=' + value.frozen?.to_s
    end

    def delete(name, options={})
        super
        @cache.delete(name)
    end

    def delete_matched(matcher, options={})
        super
        raise "delete_matched not supported by LocalCache"
    end

end

# Backwards compatibility
module ActiveSupport
    module Cache
        class LocalCache < ::LocalCache
        end
    end
end
