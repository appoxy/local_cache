require 'active_support'

module ActiveSupport
    module Cache
        class LocalCache < Store

            def initialize(size=1000, default_expires_in=60)
                puts 'Creating new LocalCache'
                @size = size
                @default_expires_in = default_expires_in
                # we initialize an empty hash
                @cache = {}
                @cache_list = []
            end

            def get(key)
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

            def put(key, val, seconds_to_store)

                seconds_to_store = seconds_to_store || @default_expires_in
                #puts 'seconds=' + seconds_to_store.to_s
                @cache[key] = [Time.now+seconds_to_store, val]
                @cache_list << key
                while @cache.size > @size && @cache_list.size > 0
                    to_remove = @cache_list.pop
                    @cache.delete(to_remove) unless to_remove.nil?
                end
            end

            def read(name, options = nil)
#        puts 'read from localcache'
                super
                ret = get(name)
#        puts 'ret.frozen=' + ret.frozen?.to_s
                return ret
            end

            def write(name, value, options = nil)
                super
                put(name, value, options.nil? ? nil : options[:expires_in])
#        puts 'write.frozen=' + value.frozen?.to_s
            end

            def delete(name, options = nil)
                super
                @cache.delete(name)
            end

            def delete_matched(matcher, options = nil)
                super
                raise "delete_matched not supported by LocalCache"
            end

        end
    end
end
