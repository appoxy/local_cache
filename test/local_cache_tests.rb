require 'test/unit'
require File.join(File.dirname(__FILE__), "../lib/local_cache")

class LocalCacheTests < Test::Unit::TestCase

    def test_put_get

        key = "tk"
        to_put = "something"
        cache = ActiveSupport::Cache::LocalCache.new
        cache.write(key, to_put)
        puts 'read=' + cache.read("tk").inspect
        assert cache.read("tk") == to_put

    end

end