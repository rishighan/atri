# config/initializers/redis.rb
$redis = Redis::Namespace.new("rishi_ganalytics", :redis => Redis.new)
